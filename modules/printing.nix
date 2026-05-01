_: {
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        printing.drivers = with pkgs; [
          gutenprint
          hplipWithPlugin
        ];
      };
    };
}
