_: {
  flake.modules.nixos.audiobookshelf = {
    services.audiobookshelf = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 13378;
      dataDir = "/mnt/stillhouse/audiobooks";
    };
  };
}
