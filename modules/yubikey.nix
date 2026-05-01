_: {
  flake.modules.nixos = {
    base = {
      programs.yubikey-manager.enable = true;
      services.yubikey-agent.enable = true;
    };
    pc =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          yubioath-flutter
        ];
      };
  };
}
