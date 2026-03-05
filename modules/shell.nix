{config, ...}: {
  flake.modules = {
    nixos.base = nixosArgs: {
      programs.fish.enable = true;
      users.users.${config.username}.shell = nixosArgs.config.programs.fish.package;
    };
  };
}
