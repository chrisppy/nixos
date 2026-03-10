{config, ...}: {
  flake = {
    meta.owner = {
      email = "chris@red-oxide.org";
      name = "Chris Palmer";
      username = "chrisppy";
    };

    modules = {
      nixos.base = {
        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [
            "input"
            "render"
            "video"
          ];
        };

        nix.settings.trusted-users = [config.flake.meta.owner.username];
      };
    };
  };
}
