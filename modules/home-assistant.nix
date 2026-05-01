_: {
  flake.modules.nixos.home-assistant =
    { config, ... }:
    {
      virtualisation.oci-containers = {
        backend = "podman";
        containers.homeassistant = {
          volumes = [ "home-assistant:/config" ];
          environment.TZ = config.time.timeZone;
          image = "ghcr.io/home-assistant/home-assistant:stable";
          extraOptions = [
            "--network=host"
          ];
        };
      };

      networking.firewall.allowedTCPPorts = [ 8123 ];
    };
}
