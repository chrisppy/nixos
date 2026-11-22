_: {
  configurations.nixos.smoky.module =
    { lib, ... }:
    {
      # Laptop: NetworkManager owns every interface. Turn off the networkd
      # setup from modules/core/network.nix so the two don't fight over
      # enp3s0, and so boot doesn't wait for an unplugged ethernet cable.
      networking = {
        hostId = "aadc8d2d";
        hostName = "smoky";
        networkmanager.enable = true;
        useNetworkd = lib.mkForce false;
      };
      systemd.network.enable = lib.mkForce false;
    };
}
