_: {
  flake.modules.nixos.podman =
    {
      lib,
      pkgs,
      ...
    }:
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
              runtimeInputs = [ pkgs.podman ];
              text = ''
                images=$(podman ps -a --format="{{.Image}}" | sort -u)
                for image in $images; do
                  podman pull "$image"
                done
                containers=$(podman ps -a --format="{{.Names}}")
                for container in $containers; do
                  podman restart "$container"
                done
              '';
            }
          );
        };
      };
    };
}
