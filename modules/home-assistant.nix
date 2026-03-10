_: {
  flake.modules.nixos.home-assistant = {
    config,
    pkgs,
    ...
  }: {
    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = ["home-assistant:/config"];
        environment.TZ = config.time.timeZone;
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [
          "--network=host"
        ];
      };
    };

    systemd = {
      timers.restart-homeassistant = {
        timerConfig = {
          Unit = "restart-homeassistant.service";
          OnCalendar = "Tue 02:00";
        };
        wantedBy = ["timers.target"];
      };
      services.restart-homeassistant.serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl try-restart podman-homeassistant.service";
      };
    };

    networking.firewall.allowedTCPPorts = [8123];
  };
}
