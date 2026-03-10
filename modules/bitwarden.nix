_: {
  flake.modules.nixos.pc = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
