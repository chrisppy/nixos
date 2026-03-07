_: {
  flake.modules.homeManager.base = {
    config,
    lib,
    ...
  }: {
    home.preferXdgDirectories = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = lib.mkDefault true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/share";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };
}
