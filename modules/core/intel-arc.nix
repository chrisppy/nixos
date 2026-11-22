# Shared userspace for Intel Arc dGPUs (blueridge: B580 on xe,
# sideling: A310 on i915). Gives VA-API, QSV and OpenCL to everything on
# the host (browsers, mpv, HandBrake, Jellyfin), not just one service.
_: {
  flake.modules.nixos.intel-arc =
    { lib, pkgs, ... }:
    {
      # GuC/HuC/GSC firmware from linux-firmware; Arc needs it for media
      # and power management. facter usually sets this already.
      hardware.enableRedistributableFirmware = lib.mkDefault true;

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # VA-API (iHD)
          vpl-gpu-rt # oneVPL / QSV runtime
          intel-compute-runtime # OpenCL (Jellyfin tone mapping, etc.)
        ];
      };

      # Arc is only supported by iHD; don't let libva probe the old i965.
      environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

      environment.systemPackages = with pkgs; [
        libva-utils # vainfo
        nvtopPackages.intel # works on both xe and i915, unlike intel_gpu_top
      ];
    };
}
