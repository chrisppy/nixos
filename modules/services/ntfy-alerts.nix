{ config, ... }:
let
  inherit (config.flake.lib) mkDomain;
in
{
  # Push ZFS (ZED) events and failed systemd services to ntfy.
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

        systemd = {
          services."notify-failure@" = {
            description = "ntfy alert for failed unit %i";
            serviceConfig = {
              Type = "oneshot";
              EnvironmentFile = config.sops.templates."ntfy-alerts-env".path;
            };
            scriptArgs = "%i";
            script = ''
              unit="$1"
              ${pkgs.systemd}/bin/journalctl -u "$unit" -n 15 --no-pager -o cat \
                | ${lib.getExe pkgs.curl} -fsS --data-binary @- \
                    -H "Authorization: Bearer $NTFY_TOKEN" \
                    -H "Title: ${host}: $unit failed" \
                    -H "Priority: high" \
                    -H "Tags: rotating_light" \
                    "${url}/${host}" || true
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
        };
      }

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
