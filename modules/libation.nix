{
  config,
  inputs,
  ...
}:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.media =
    { lib, pkgs, ... }:
    let
      unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = with unstable; [
        libation
      ];

      systemd = {
        timers.libation-sync = {
          timerConfig = {
            OnCalendar = "12:00";
            Persistent = true;
          };
          wantedBy = [ "timers.target" ];
        };
        services.libation-sync.serviceConfig = {
          Type = "oneshot";
          User = username;
          ExecStart = lib.getExe (
            pkgs.writeShellApplication {
              name = "libation-sync";
              runtimeInputs = [ unstable.libation ];
              text = ''
                libationcli scan
                libationcli liberate
              '';
            }
          );
        };
      };
    };
}
