{ config, ... }:
let
  inherit (config.flake.lib) mkDomain;
in
{
  # Push host alerts to ntfy: ZFS (ZED) events, failed systemd services,
  # SMART warnings, low disk space, boots, auto-upgrades and TLS certs.
  # Topic is the host name; the token comes from the ntfy module's secret.
  flake.modules.nixos.ntfy-alerts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      host = config.networking.hostName;
      ntfy = config.services.ntfy-sh;
      # Talk to the local server directly when it runs here, so alerts don't depend on Caddy/DNS.
      url =
        if ntfy.enable then "http://${ntfy.settings.listen-http}" else "https://${mkDomain "ntfy"}";
      token = config.sops.placeholder.ntfy_alerts_token;
      envFile = config.sops.templates."ntfy-alerts-env".path;

      # Alert thresholds
      spaceThreshold = 80; # percent used
      spaceMounts = [
        "/"
        "/boot"
      ];
      certDays = 14; # warn when a cert has fewer days left

      # usage: ntfy-send TITLE [PRIORITY] [TAGS] < body   (root only: reads the token)
      ntfySend = pkgs.writeShellApplication {
        name = "ntfy-send";
        runtimeInputs = [ pkgs.curl ];
        text = ''
          title="$1"
          priority="''${2:-default}"
          tags="''${3:-}"
          # shellcheck disable=SC1091
          . ${envFile}
          curl -fsS --retry 5 --retry-connrefused --retry-delay 5 \
            --data-binary @- \
            -H "Authorization: Bearer $NTFY_TOKEN" \
            -H "Title: $title" \
            -H "Priority: $priority" \
            -H "Tags: $tags" \
            "${url}/${host}" >/dev/null
        '';
      };

      daily = name: {
        timers.${name} = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "*-*-* 08:00:00";
            RandomizedDelaySec = "15min";
            Persistent = true;
          };
        };
      };

      # Same rendering the NixOS zfs module uses for zed.rc
      zedConf = lib.generators.toKeyValue {
        mkKeyValue = lib.generators.mkKeyValueDefault {
          mkValueString =
            v:
            if lib.isInt v then
              toString v
            else if lib.isString v then
              "\"${v}\""
            else if v == true then
              "1"
            else if v == false then
              "0"
            else if lib.isList v then
              "\"${lib.concatStringsSep " " v}\""
            else
              throw "ntfy-alerts: unsupported zed setting value";
        } "=";
      } config.services.zfs.zed.settings;
    in
    lib.mkMerge [
      {
        sops = {
          secrets.ntfy_alerts_token = { };
          templates."ntfy-alerts-env".content = ''
            NTFY_TOKEN=${token}
          '';
        };

        environment.systemPackages = [ ntfySend ];

        systemd = {
          # Any failed service
          services."notify-failure@" = {
            description = "ntfy alert for failed unit %i";
            serviceConfig.Type = "oneshot";
            scriptArgs = "%i";
            script = ''
              unit="$1"
              ${pkgs.systemd}/bin/journalctl -u "$unit" -n 15 --no-pager -o cat \
                | ${lib.getExe ntfySend} "${host}: $unit failed" high rotating_light || true
            '';
          };

          packages = [
            # Top-level drop-in: every .service gets OnFailure=
            (pkgs.writeTextDir "etc/systemd/system/service.d/10-ntfy-onfailure.conf" ''
              [Unit]
              OnFailure=notify-failure@%n.service
            '')
            # Same-named drop-in shadows it for the notifier itself (no loops)
            (pkgs.writeTextDir "etc/systemd/system/notify-failure@.service.d/10-ntfy-onfailure.conf" ''
              [Unit]
              OnFailure=
            '')
          ];

          # Boot notice: an unexpected one means a crash or power loss
          services.ntfy-boot = {
            description = "ntfy notice on boot";
            wantedBy = [ "multi-user.target" ];
            wants = [ "network-online.target" ];
            after = [ "network-online.target" ] ++ lib.optional ntfy.enable "ntfy-sh.service";
            restartIfChanged = false;
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            path = [ pkgs.coreutils ];
            script = ''
              last=$(${pkgs.systemd}/bin/journalctl -b -1 -n 1 --no-pager -o short-iso 2>/dev/null \
                | tail -n 1 | cut -d' ' -f1 || true)
              printf 'kernel %s\nprevious boot last logged: %s\n' "$(uname -r)" "''${last:-unknown}" \
                | ${lib.getExe ntfySend} "${host} booted" default arrows_counterclockwise || true
            '';
          };
        };
      }

      # Disk space: mounts above plus every ZFS pool
      {
        systemd = lib.mkMerge [
          (daily "ntfy-space-check")
          {
            services.ntfy-space-check = {
              description = "ntfy alert for low disk space";
              serviceConfig.Type = "oneshot";
              path = [
                pkgs.coreutils
                pkgs.gawk
                pkgs.util-linux
              ]
              ++ lib.optional config.boot.zfs.enabled config.boot.zfs.package;
              script = ''
                msg=""
                for m in ${lib.escapeShellArgs spaceMounts}; do
                  mountpoint -q "$m" || continue
                  pct=$(df -P "$m" | awk 'NR==2 { sub("%", "", $5); print $5 }')
                  if [ "$pct" -ge ${toString spaceThreshold} ]; then msg+="$m: $pct% used"$'\n'; fi
                done
                if command -v zpool >/dev/null; then
                  while read -r name cap; do
                    cap=''${cap%\%}
                    if [ "$cap" -ge ${toString spaceThreshold} ]; then msg+="pool $name: $cap% used"$'\n'; fi
                  done < <(zpool list -H -o name,capacity)
                fi
                if [ -n "$msg" ]; then
                  printf '%s' "$msg" | ${lib.getExe ntfySend} "${host}: disk space low" high floppy_disk
                fi
              '';
            };
          }
        ];
      }

      # SMART warnings from smartd
      (lib.mkIf config.services.smartd.enable {
        services.smartd.defaults.monitored =
          let
            smartdNtfy = pkgs.writeShellScript "smartd-ntfy" ''
              printf '%s\n' "$SMARTD_FULLMESSAGE" \
                | ${lib.getExe ntfySend} "${host}: SMART $SMARTD_FAILTYPE on $SMARTD_DEVICESTRING" urgent warning
            '';
          in
          "-a -m <nomailer> -M exec ${smartdNtfy}";
      })

      # Auto-upgrade results (failures are already covered by notify-failure@)
      (lib.mkIf config.system.autoUpgrade.enable {
        systemd.services = {
          nixos-upgrade.onSuccess = [ "ntfy-upgrade-done.service" ];
          ntfy-upgrade-done = {
            description = "ntfy notice after a successful auto-upgrade";
            serviceConfig = {
              Type = "oneshot";
              StateDirectory = "ntfy-alerts";
            };
            path = [ pkgs.coreutils ];
            script = ''
              state=/var/lib/ntfy-alerts/last-system
              cur=$(readlink -f /run/current-system)
              prev=$(cat "$state" 2>/dev/null || true)
              [ "$cur" = "$prev" ] && exit 0
              echo "$cur" > "$state"
              [ -z "$prev" ] && exit 0 # first run: just record it

              booted=$(readlink /run/booted-system/{initrd,kernel,kernel-modules})
              built=$(readlink /run/current-system/{initrd,kernel,kernel-modules})
              if [ "$booted" != "$built" ]; then
                printf 'now on %s\nnew kernel/initrd: reboot to apply\n' "$(basename "$cur")" \
                  | ${lib.getExe ntfySend} "${host}: upgraded, reboot needed" default arrows_counterclockwise
              else
                printf 'now on %s\n' "$(basename "$cur")" \
                  | ${lib.getExe ntfySend} "${host}: upgraded" low white_check_mark
              fi
            '';
          };
        };
      })

      # TLS certs served by Caddy
      (lib.mkIf config.services.caddy.enable {
        systemd = lib.mkMerge [
          (daily "ntfy-cert-check")
          {
            services.ntfy-cert-check = {
              description = "ntfy alert for expiring TLS certificates";
              wants = [ "caddy.service" ];
              after = [ "caddy.service" ];
              serviceConfig.Type = "oneshot";
              path = [
                pkgs.coreutils
                pkgs.openssl
              ];
              script = ''
                msg=""
                for d in ${lib.escapeShellArgs (lib.attrNames config.services.caddy.virtualHosts)}; do
                  cert=$(openssl s_client -connect 127.0.0.1:443 -servername "$d" </dev/null 2>/dev/null \
                    | openssl x509 2>/dev/null || true)
                  if [ -z "$cert" ]; then
                    msg+="$d: no certificate served"$'\n'
                  elif ! printf '%s\n' "$cert" | openssl x509 -noout -checkend ${toString (certDays * 86400)} >/dev/null; then
                    end=$(printf '%s\n' "$cert" | openssl x509 -noout -enddate | cut -d= -f2)
                    msg+="$d: expires $end"$'\n'
                  fi
                done
                if [ -n "$msg" ]; then
                  printf '%s' "$msg" | ${lib.getExe ntfySend} "${host}: TLS certificate problem" high lock
                fi
              '';
            };
          }
        ];
      })

      # ZFS: ZED has native ntfy support
      (lib.mkIf config.boot.zfs.enabled {
        services.zfs.zed = {
          enableMail = false;
          settings = {
            ZED_NTFY_URL = url;
            ZED_NTFY_TOPIC = host;
            ZED_NOTIFY_VERBOSE = false; # true = also notify on clean scrub finishes
            ZED_NOTIFY_INTERVAL_SECS = 3600;
          };
        };

        # zed.rc is sourced by the zedlets, so render it via sops to keep the token out of the store
        sops.templates."zed.rc".content = zedConf + ''
          ZED_NTFY_ACCESS_TOKEN="${token}"
        '';
        environment.etc."zfs/zed.d/zed.rc".source =
          lib.mkForce config.sops.templates."zed.rc".path;
      })
    ];
}
