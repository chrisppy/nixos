_: {
  flake.modules.nixos.base = {
    config,
    lib,
    pkgs,
    ...
  }: {
    boot.kernelPackages = lib.mkForce (
      if !(config.boot.supportedFilesystems.zfs or false)
      then pkgs.linuxPackages_latest
      else
        pkgs.linuxKernel.packages
        |> lib.filterAttrs (name: kernelPackages:
          builtins.match "linux_[0-9]+_[0-9]+" name
          != null
          && !(builtins.tryEval kernelPackages.${pkgs.zfs.kernelModuleAttribute}.meta.broken).value)
        |> builtins.attrValues
        |> lib.sort (a: b: lib.versionOlder a.kernel.version b.kernel.version)
        |> lib.last
    );
  };
}
