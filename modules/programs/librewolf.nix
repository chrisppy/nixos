{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      # The policies go into the wrapped browser, as Home Manager did it.
      users.users.${username}.packages = [
        (pkgs.librewolf.override (old: {
          extraPolicies = (old.extraPolicies or { }) // {
            BlockAboutConfig = true;
            DefaultDownloadDirectory = "/home/${username}/downloads";
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
        }))
      ];
    };
}
