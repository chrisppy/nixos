# nixos-config

My personal NixOS configuration, managed as a Nix flake.

## Hosts

| Host | Platform |
| --------- | ------------ |
| blueridge | x86_64-linux |
| sideling | x86_64-linux |
| smoky | x86_64-linux |

## Structure

```
hosts/      per-host configuration
modules/    shared NixOS and home-manager modules
secrets/    sops-nix encrypted secrets
```

## Inputs

Inputs are pinned with [tack](https://github.com/manic-systems/tack) in
`.tack/pins.toml`, locked in `.tack/pins.lock.json`, so there is no
`flake.lock`. The flake still works as usual (`nixos-rebuild --flake`,
`nix build`); nix only reads the lock.

- `nix run github:manic-systems/tack/v2.0.0 -- update` moves every pin, or
  `... -- update nixpkgs` just one.
- The "Update tack pins" workflow does that daily and commits the lock; CI
  then promotes each host that builds to `tested-<host>` for autoUpgrade.
- `.tack/default.nix` is tack's resolver, vendored under EUPL-1.2.

## Key inputs

- [nixpkgs](https://github.com/NixOS/nixpkgs) (26.05)
- [home-manager](https://github.com/nix-community/home-manager)
- [disko](https://github.com/nix-community/disko)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [stylix](https://github.com/danth/stylix)
- [niri](https://github.com/niri-wm/niri)
