{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  # Ephemeral root: "/" is a tmpfs and only what is listed under
  # preservation.preserveAt."/persist" (plus /nix and /home, which are their
  # own subvolumes) survives a reboot. Hosts add their own entries on top.
  flake.modules.nixos.preservation =
    { config, lib, ... }:
    {
      imports = [ inputs.preservation.nixosModules.default ];

      # preservation sets up its early mounts in the systemd initrd
      boot.initrd.systemd.enable = true;

      fileSystems = {
        "/persist".neededForBoot = true;
        # sops' age key lives in $HOME and is needed during activation
        "/home".neededForBoot = true;
      };

      preservation = {
        enable = true;
        preserveAt."/persist" = {
          directories = [
            # uid/gid allocations, so files keep their owners
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
            "/var/lib/systemd/coredump"
            "/var/lib/systemd/timers"
            "/var/log"
          ];
          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
            {
              file = "/var/lib/systemd/random-seed";
              how = "symlink";
              inInitrd = true;
              configureParent = true;
            }
            # also the sops-nix host identity
            {
              file = "/etc/ssh/ssh_host_ed25519_key";
              how = "symlink";
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key.pub";
              how = "symlink";
              configureParent = true;
            }
          ];
        };
      };

      # The bind-mounted machine-id is already persistent; the commit unit would fail.
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

      # /etc/shadow is rebuilt every boot, so passwords have to be declarative.
      sops.secrets.user_password_hash.neededForUsers = true;
      users = {
        mutableUsers = false;
        users.${username} = {
          initialPassword = lib.mkForce null;
          hashedPasswordFile = config.sops.secrets.user_password_hash.path;
        };
      };
    };
}
