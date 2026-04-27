# nixos-config

My personal NixOS configuration, managed as a Nix flake.

## Hosts

| Host | Platform |
|------|----------|
| blueridge | x86_64-linux |
| sideling | x86_64-linux |
| smoky | x86_64-linux |

## Structure

```
hosts/      per-host configuration
modules/    shared NixOS and home-manager modules
secrets/    sops-nix encrypted secrets
```

## Key inputs

- [nixpkgs](https://github.com/NixOS/nixpkgs) (25.11)
- [home-manager](https://github.com/nix-community/home-manager)
- [disko](https://github.com/nix-community/disko)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [stylix](https://github.com/danth/stylix)
- [niri](https://github.com/niri-wm/niri)
