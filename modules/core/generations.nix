_: {
  # Determinate Nixd handles garbage collection, but old system generations
  # are GC roots it never removes. Drop the ones older than 30 days weekly
  # (the current generation is always kept) so it can reclaim them.
  flake.modules.nixos.base =
    { config, ... }:
    {
      systemd = {
        services.prune-system-generations = {
          description = "Remove NixOS system generations older than 30 days";
          serviceConfig.Type = "oneshot";
          script = ''
            ${config.nix.package}/bin/nix --extra-experimental-features nix-command \
              profile wipe-history --profile /nix/var/nix/profiles/system --older-than 30d
          '';
        };
        timers.prune-system-generations = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "weekly";
            RandomizedDelaySec = "1h";
            Persistent = true;
          };
        };
      };
    };
}
