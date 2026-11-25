_: {
  flake.lib = rec {
    baseDomain = "palmerlife.online";

    # mkDomain "meals" => "meals.palmerlife.online"
    mkDomain = name: "${name}.${baseDomain}";

    # mkVHost "meals" 9000 => { "meals.palmerlife.online".extraConfig = ...; }
    mkVHost = name: port: {
      ${mkDomain name}.extraConfig = ''
        tls {
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          # Cloudflare's nameservers update within seconds; skip Caddy's own
          # propagation check (it gave false negatives) and let the CA validate.
          propagation_delay 60s
          propagation_timeout -1
        }
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };
}
