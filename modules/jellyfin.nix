{inputs, ...}: {
  flake.modules.nixos.jellyfin = {pkgs, ...}: let
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  in {
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # VA-API (iHD) — works with xe
        vpl-gpu-rt # oneVPL / QSV runtime
        intel-compute-runtime # OpenCL
      ];
    };

    services.jellyfin = {
      enable = true;
      package = unstable.jellyfin;
      openFirewall = true;
    };
  };
}
