_: {
  flake.modules.nixos.jellyfin = {pkgs, ...}: {
    nixpkgs.overlays = [
      (_self: super: {
        jellyfin-ffmpeg = super.jellyfin-ffmpeg.override {
          ffmpeg_7-full = super.ffmpeg_7-full.override {
            withMfx = false; # Older media driver
            withVpl = true; # New driver for Arc GPUs
            withUnfree = true;
          };
        };
      })
    ];

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
      openFirewall = true;
    };
  };
}
