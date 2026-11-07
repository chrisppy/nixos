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
          resolvers 1.1.1.1
          propagation_delay 60s
          propagation_timeout 300s
        }
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };
}
