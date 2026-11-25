{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
  inherit (config.flake.lib) mkDomain mkVHost;
  name = "ntfy";
  port = 2586;
in
{
  flake.modules.nixos.ntfy =
    { config, ... }:
    {
      sops = {
        secrets = {
          # bcrypt hash from `ntfy user hash`
          ntfy_password_hash = { };
          # token from `ntfy token generate` (used by ntfy-alerts)
          ntfy_alerts_token = { };
        };
        templates."ntfy-env" = {
          content = ''
            NTFY_AUTH_USERS='${username}:${config.sops.placeholder.ntfy_password_hash}:admin'
            NTFY_AUTH_TOKENS='${username}:${config.sops.placeholder.ntfy_alerts_token}:alerts'
          '';
          restartUnits = [ "ntfy-sh.service" ];
        };
      };

      services = {
        ntfy-sh = {
          enable = true;
          environmentFile = config.sops.templates."ntfy-env".path;
          settings = {
            base-url = "https://${mkDomain name}";
            listen-http = "127.0.0.1:${toString port}";
            behind-proxy = true;
            auth-default-access = "deny-all";
            enable-login = true;
            enable-signup = false;
            # relay poll requests through ntfy.sh so iOS gets instant pushes
            upstream-base-url = "https://ntfy.sh";
          };
        };
        caddy.virtualHosts = mkVHost name port;
      };
    };
}
