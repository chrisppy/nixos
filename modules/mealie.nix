{ inputs, ... }:
{
  flake.modules.nixos.mealie =
    { config, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      sops = {
        secrets.mealie_secret_key = { };
        templates."mealie-env" = {
          content = ''
            SECRET_KEY=${config.sops.placeholder.mealie_secret_key}
          '';
          owner = "mealie";
          group = "mealie";
        };
      };
      services.mealie = {
        enable = true;
        package = unstable.mealie;
        credentialsFile = config.sops.templates."mealie-env".path;
        listenAddress = "127.0.0.1";
        port = 9000;
        settings = {
          BASE_URL = "https://meals.chrisppy.me";
          ALLOW_SIGNUP = false;
          TOKEN_TIME = "48";
          TZ = "America/New_York";
          WORKERS_PER_CORE = "1";
          MAX_WORKERS = "4";
        };
      };
    };
}
