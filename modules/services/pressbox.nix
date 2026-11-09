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
                "FreeCAD" = {
                  url = "https://blog.freecad.org/feed/";
                  fullText = true;
                };
                "HomeAssistant" = {
                  url = "https://www.home-assistant.io/atom.xml";
                  fullText = true;
                };
                "Jellyfin" = {
                  url = "https://jellyfin.org/posts/atom.xml";
                  fullText = true;
                };
                "NixOS" = {
                  url = "https://nixos.org/blog/announcements-rss.xml";
                  fullText = true;
                };
                "nrxdp" = {
                  url = "https://nrd.sh/feed.xml";
                  fullText = true;
                };
                "Rustlang" = {
                  url = "https://blog.rust-lang.org/feed.xml";
                  fullText = true;
                };
                "Tailscale" = {
                  url = "https://tailscale.com/blog/index.xml";
                  fullText = true;
                };
                "This-Week-in-Ekala" = {
                  url = "https://ekala-project.github.io/twie/atom.xml";
                  fullText = true;
                };
                "Tokio" = {
                  url = "https://tokio.rs/blog/index.xml";
                  fullText = true;
                };
                "Yorik" = {
                  url = "https://www.uncreated.net/yorik/?feed";
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
