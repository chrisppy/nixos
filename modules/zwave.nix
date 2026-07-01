{
  config,
  inputs,
  ...
}:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.zwave =
    {
      config,
      pkgs,
      ...
    }:
    let
      cfgFile = "zwave-js-keys.json";
      # unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

      overlay = final: prev: {
        zwave-js-server = prev.zwave-js-server.overrideAttrs (_old: rec {
          version = "3.10.0";

          src = prev.fetchFromGitHub {
            owner = "zwave-js";
            repo = "zwave-js-server";
            rev = version;
            hash = "sha256-4gyELYM457g0Fam4651nj6Jt7WWI4ldV/2n+ofjRqoc=";
          };

          npmDeps = final.fetchNpmDeps {
            name = "zwave-js-server-${version}-npm-deps";
            inherit src;
            hash = "sha256-R4wZrQS5/9ll2tFrDqijfHyj+S8SaAb9jhzEw09gpq8=";
          };
        });
      };

      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        overlays = [ overlay ];
      };
    in
    {
      users.groups.uucp.members = [
        "zwave-js"
        username
      ];
      sops = {
        secrets = {
          zwave-s0-legacy = { };
          zwave-s2-unauthenticated = { };
          zwave-s2-authenticated = { };
          zwave-s2-access-control = { };
        };
        templates.${cfgFile} = {
          mode = "0444";
          content = ''
            {
              "securityKeys": {
                "S0_Legacy": "${config.sops.placeholder.zwave-s0-legacy}",
                "S2_Unauthenticated": "${config.sops.placeholder.zwave-s2-unauthenticated}",
                "S2_Authenticated": "${config.sops.placeholder.zwave-s2-authenticated}",
                "S2_AccessControl": "${config.sops.placeholder.zwave-s2-access-control}"
              }
            }
          '';
        };
      };

      services.zwave-js = {
        enable = true;
        package = unstable.zwave-js-server;
        port = 3000;
        secretsConfigFile = config.sops.templates.${cfgFile}.path;
        serialPort = "/dev/serial/by-id/usb-Nabu_Casa_ZWA-2_80B54EE5E558-if00";
      };
    };
}
