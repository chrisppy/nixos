{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
  inherit (config.flake.lib) mkDomain mkVHost;
  name = "feeds";
  port = 7070;
in
{
  flake.modules = {
    nixos.pressbox = {
      imports = [ inputs.pressbox.nixosModules.default ];
      services = {
        pressbox = {
          enable = true;
          openFirewall = true;
          address = "127.0.0.1";
          port = 7070;
          users = {
            ${username} = {
              admin = true;
              feeds = {
                "This Week in Ekala" = {
                  url = "https://ekala-project.github.io/twie/atom.xml";
                  fullText = true;
                };
              };
            };
          };
        };
        caddy.virtualHosts = mkVHost name port;
      };
    };
    homeManager = {
      pressbox-tui = {
        imports = [ inputs.pressbox.homeManagerModules.default ];
        programs.pressbox = {
          enable = true;
          server = "https://${mkDomain name}";
          tui.enable = true;
        };
      };
    };
  };
}
