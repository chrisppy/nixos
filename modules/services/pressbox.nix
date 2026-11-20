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
                "Baltimore-Orioles" = {
                  url = "https://www.mlb.com/orioles/feeds/news/rss.xml";
                  fullText = true;
                  tags = [ "baseball" ];
                };
                "Chris" = {
                  url = "https://chris.palmerlife.online/atom.xml";
                  fullText = true;
                  tags = [
                    "nix"
                    "rust"
                    "software"
                  ];
                };
                "Frederick-Keys" = {
                  url = "https://www.milb.com/frederick/feeds/news/rss.xml";
                  fullText = true;
                  tags = [ "baseball" ];
                };
                "FreeCAD" = {
                  url = "https://blog.freecad.org/feed/";
                  fullText = true;
                  tags = [ "software" ];
                };
                "HomeAssistant" = {
                  url = "https://www.home-assistant.io/atom.xml";
                  fullText = true;
                  tags = [ "software" ];
                };
                "Jellyfin" = {
                  url = "https://jellyfin.org/posts/atom.xml";
                  fullText = true;
                  tags = [ "software" ];
                };
                "NixOS" = {
                  url = "https://nixos.org/blog/announcements-rss.xml";
                  fullText = true;
                  tags = [ "nix" ];
                };
                "nrxdp" = {
                  url = "https://nrd.sh/feed.xml";
                  fullText = true;
                  tags = [ "nix" ];
                };
                "red-oxide" = {
                  url = "https://red-oxide.org/atom.xml";
                  fullText = true;
                  tags = [
                    "nix"
                    "rust"
                    "software"
                  ];
                };
                "Rustlang" = {
                  url = "https://blog.rust-lang.org/feed.xml";
                  fullText = true;
                  tags = [ "rust" ];
                };
                "Tailscale" = {
                  url = "https://tailscale.com/blog/index.xml";
                  fullText = true;
                  tags = [ "software" ];
                };
                "This-Week-in-Ekala" = {
                  url = "https://ekala-project.github.io/twie/atom.xml";
                  fullText = true;
                  tags = [ "nix" ];
                };
                "Tokio" = {
                  url = "https://tokio.rs/blog/index.xml";
                  fullText = true;
                  tags = [ "rust" ];
                };
                "Yorik" = {
                  url = "https://www.uncreated.net/yorik/?feed";
                  fullText = true;
                  tags = [ "software" ];
                };
                "Linux-Unplugged" = {
                  url = "https://feeds.jupiterbroadcasting.com/lup";
                  fullText = true;
                  tags = [ "linux" ];
                };
                "The-Launch" = {
                  url = "https://serve.podhome.fm/rss/04b078f9-b3e8-4363-a576-98e668231306";
                  fullText = true;
                  tags = [ "linux" ];
                };
                "This-Week-in-Bitcoin" = {
                  url = "https://feeds.fountain.fm/40huHEEF6JMPGYctMuUI";
                  fullText = true;
                  tags = [ "finance" ];
                };
                "Jupiter-Extras" = {
                  url = "https://feeds.fireside.fm/extras/rss";
                  fullText = true;
                  tags = [ "linux" ];
                };
              };
            };
          };
        };
        caddy.virtualHosts = mkVHost name port;
      };
    };
    homeManager = {
      pressbox-clients = {
        imports = [ inputs.pressbox.homeManagerModules.default ];
        programs.pressbox = {
          enable = true;
          server = "https://${mkDomain name}";
          tui.enable = true;
          desktop.enable = true;
        };
      };
    };
  };
}
