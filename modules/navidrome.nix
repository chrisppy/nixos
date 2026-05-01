{ inputs, ... }:
{
  flake.modules.nixos.navidrome =
    { pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      services.navidrome = {
        enable = true;
        package = unstable.navidrome;
        openFirewall = true;
        settings = {
          Port = 4533;
          Address = "127.0.0.1";
          EnableInsightsCollector = false;
          MusicFolder = "/mnt/stillhouse/music";
        };
      };
    };
}
