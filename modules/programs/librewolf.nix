_: {
  flake.modules.homeManager.gui =
    { config, pkgs, ... }:
    {
      programs.librewolf = {
        enable = true;
        package = pkgs.librewolf;
        policies = {
          BlockAboutConfig = true;
          DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
              default_area = "menupanel";
              private_browsing = true;
            };
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            "{3c078156-979c-498b-8990-85f7987dd929}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
      stylix.targets.librewolf.profileNames = [ "default" ];
    };
}
