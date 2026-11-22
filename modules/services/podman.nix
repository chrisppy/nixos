_: {
  flake.modules.nixos.podman =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      # Restart through systemd so the oci-containers units stay in charge
      # of the containers instead of podman restarting them behind its back.
      units =
        config.virtualisation.oci-containers.containers
        |> lib.attrNames
        |> map (name: "podman-${name}.service");
    in
    {
      virtualisation.podman = {
        enable = true;
        autoPrune = {
          enable = true;
          flags = [ "--all" ];
        };
      };

      systemd = {
        timers.update-containers = {
          timerConfig = {
            Unit = "update-containers.service";
            OnCalendar = "Mon 02:00";
          };
          wantedBy = [ "timers.target" ];
        };
        services.update-containers.serviceConfig = {
          Type = "oneshot";
          ExecStart = lib.getExe (
            pkgs.writeShellApplication {
              name = "update-containers";
              runtimeInputs = [
                pkgs.podman
                pkgs.systemd
              ];
              text = ''
                images=$(podman ps -a --format="{{.Image}}" | sort -u)
                for image in $images; do
                  podman pull "$image"
                done
                ${lib.optionalString (units != [ ]) "systemctl restart ${lib.escapeShellArgs units}"}
              '';
            }
          );
        };
      };
    };
}
