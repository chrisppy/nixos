{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  # Replaces Home Manager. Programs are configured as wrapped packages
  # (nix-wrapper-modules): any module can add to `wrappers.<name>.module`,
  # and the wrapped package is installed for the owner and readable as
  # `wrappers.<name>.package`. Config files that need to live in $HOME
  # (because the program writes next to them, or has no wrapper) go in
  # `home.files`, linked by systemd-tmpfiles at login.
  flake.modules.nixos.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      known =
        inputs.nix-wrapper-modules.wrappers // inputs.birdland.wrappers // inputs.pressbox.wrappers;
      # For programs nix-wrapper-modules has no module for: set `package` and
      # `env`/`flags` yourself.
      generic =
        (inputs.nix-wrapper-modules.lib.evalModule (
          { wlib, ... }:
          {
            imports = [ wlib.modules.default ];
          }
        )).config;
    in
    {
      options = {
        wrappers = lib.mkOption {
          default = { };
          description = "Wrapped programs for the owner.";
          type = lib.types.attrsOf (
            lib.types.submodule (
              { name, config, ... }:
              {
                options = {
                  module = lib.mkOption {
                    type = lib.types.deferredModule;
                    default = { };
                    description = "Settings for the wrapper; every definition is merged.";
                  };
                  wrapper = lib.mkOption {
                    type = lib.types.raw;
                    default = known.${name} or generic;
                    defaultText = lib.literalMD "the nix-wrapper-modules, birdland or pressbox wrapper of that name, else a generic one";
                    description = "The wrapper to configure.";
                  };
                  install = lib.mkOption {
                    type = lib.types.bool;
                    default = true;
                    description = "Install the package for the owner.";
                  };
                  package = lib.mkOption {
                    type = lib.types.package;
                    readOnly = true;
                    description = "The wrapped package.";
                  };
                };
                config.package = config.wrapper.wrap [
                  { inherit pkgs; }
                  config.module
                ];
              }
            )
          );
        };

        home.files = lib.mkOption {
          type = lib.types.attrsOf lib.types.path;
          default = { };
          example = lib.literalExpression ''{ ".config/foo/config.toml" = ./foo.toml; }'';
          description = "Files linked into the owner's home directory, by path relative to it.";
        };
      };

      config = {
        users.users.${username}.packages = lib.pipe config.wrappers [
          (lib.filterAttrs (_: w: w.install))
          (lib.mapAttrsToList (_: w: w.package))
        ];

        systemd.user.tmpfiles.users.${username}.rules = lib.mapAttrsToList (
          path: source: "L+ %h/${path} - - - - ${source}"
        ) config.home.files;
      };
    };
}
