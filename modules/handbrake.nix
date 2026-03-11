_: {
  flake.modules.nixos.media = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      handbrake
    ];
  };
}
