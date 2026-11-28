{
  inputs = {
    base24-themes = {
      # TODO: back to the default branch once red-oxide/base24-themes#14 is merged
      url = "github:red-oxide/base24-themes?ref=feat/wrapper-modules";
      inputs = {
        devfmt.follows = "devfmt";
        nixpkgs.follows = "nixpkgs";
      };
    };
    birdland = {
      # TODO: back to the default branch once red-oxide/birdland#20 is merged
      url = "github:red-oxide/birdland?ref=feat/wrapper-modules";
      inputs = {
        base24-themes.follows = "base24-themes";
        devfmt.follows = "devfmt";
        nix-wrapper-modules.follows = "nix-wrapper-modules";
        nixpkgs.follows = "nixpkgs";
      };
    };
    devfmt = {
      url = "github:red-oxide/devfmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    freecad-flake = {
      url = "github:chrisppy/freecad-flake";
      inputs = {
        devfmt.follows = "devfmt";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nhx = {
      url = "github:Ra77a3l3-jar/nhx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wrapper-modules = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-nix.url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # TODO: drop once bcachefs-tools builds against 6.18.64+ (see hosts/sideling/host.nix)
    nixpkgs-kernel.url = "github:NixOS/nixpkgs/f68407657ad294471eb4b2e65d193df26edf729f";
    opengym = {
      url = "github:DuarteSantos8/openGym?dir=contrib/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pressbox = {
      # TODO: back to the default branch once red-oxide/pressbox#43 is merged
      url = "github:red-oxide/pressbox?ref=feat/wrapper-modules";
      inputs = {
        devfmt.follows = "devfmt";
        nix-wrapper-modules.follows = "nix-wrapper-modules";
        nixpkgs.follows = "nixpkgs";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.devfmt.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.devfmt.lib.importTree ./modules)
        (inputs.devfmt.lib.importTree ./hosts)
      ];

      _module.args = {
        rootPath = ./.;
      };
    };
}
