{
  inputs = {
    base24-themes = {
      url = "github:chrisppy/base24-themes";
      inputs = {
        devfmt.follows = "devfmt";
        nixpkgs.follows = "nixpkgs";
      };
    };
    birdland = {
      url = "github:chrisppy/birdland";
      inputs = {
        base24-themes.follows = "base24-themes";
        devfmt.follows = "devfmt";
        nixpkgs.follows = "nixpkgs";
      };
    };
    devfmt = {
      url = "github:chrisppy/devfmt";
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
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nhx = {
      url = "github:Ra77a3l3-jar/nhx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-nix.url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    opengym = {
      url = "github:DuarteSantos8/openGym?dir=contrib/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pressbox = {
      url = "github:chrisppy/pressbox";
      inputs = {
        devfmt.follows = "devfmt";
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
