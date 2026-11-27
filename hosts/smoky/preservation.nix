_: {
  configurations.nixos.smoky.module = {
    preservation.preserveAt."/persist".directories = [
      "/etc/NetworkManager/system-connections" # saved Wi-Fi networks
      "/var/cache/tuigreet" # remembered user/session
      "/var/lib/bluetooth"
      "/var/lib/cups"
      "/var/lib/NetworkManager"
      "/var/lib/systemd/backlight"
      "/var/lib/systemd/rfkill"
      "/var/lib/tailscale"
      "/var/lib/upower"
    ];
  };
}
