{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  # nhx (Helix with Steel plugins) is a Home Manager module. It only writes
  # files into $HOME and adds packages, so it's evaluated here against just
  # those `home.*` options, and the files it writes become one store
  # directory that a wrapped `hx` uses as its config and Steel home.
  flake.modules.nixos.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      homeOptions =
        { lib, ... }:
        {
          options.home = {
            homeDirectory = lib.mkOption {
              type = lib.types.str;
              default = "/home/${username}";
            };
            file = lib.mkOption {
              default = { };
              type = lib.types.attrsOf (
                lib.types.submodule {
                  options = {
                    source = lib.mkOption {
                      type = lib.types.nullOr lib.types.path;
                      default = null;
                    };
                    text = lib.mkOption {
                      type = lib.types.nullOr lib.types.lines;
                      default = null;
                    };
                  };
                }
              );
            };
            packages = lib.mkOption {
              type = lib.types.listOf lib.types.package;
              default = [ ];
            };
            sessionVariables = lib.mkOption {
              type = lib.types.attrsOf lib.types.anything;
              default = { };
            };
          };
        };

      # The base24 theme for Helix, from base24-themes; without a background
      # when the terminal is translucent.
      helixTheme = (pkgs.formats.toml { }).generate "base24.toml" (
        inputs.base24-themes.lib.base24.apps.helix {
          theme = config.theme.scheme;
          transparent = config.stylix.opacity.terminal != 1.0;
        }
      );
      themeFile = {
        programs.nhx.settings.theme = "base24";
        home.file.".config/helix/themes/base24.toml".source = helixTheme;
      };

      nhx =
        (lib.evalModules {
          modules = [
            { _module.args = { inherit pkgs; }; }
            homeOptions
            inputs.nhx.homeManagerModules.nhx
            themeFile
            config.nhx
          ];
        }).config;

      helixHome = pkgs.linkFarm "nhx-home" (
        lib.mapAttrsToList (path: file: {
          name = path;
          path = if file.source != null then file.source else pkgs.writeText (baseNameOf path) file.text;
        }) nhx.home.file
      );
      editor = nhx.programs.nhx.package;
    in
    {
      options.nhx = lib.mkOption {
        type = lib.types.deferredModule;
        default = { };
        description = "Settings for nhx, as in its Home Manager module (`programs.nhx`).";
      };

      config = {
        wrappers.hx.module = {
          package = editor;
          env = {
            # Helix reads config.toml, languages.toml, themes/ and init.scm
            # from here. Programs started from hx inherit it too.
            XDG_CONFIG_HOME = "${helixHome}/.config";
            STEEL_HOME = "${helixHome}/.local/share/steel";
          };
        };

        # Everything else nhx installs, such as steel-language-server.
        users.users.${username}.packages = lib.remove editor nhx.home.packages;
      };
    };
}
