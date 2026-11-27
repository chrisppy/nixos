_: {
  # Load each repo's dev shell on `cd` (its .envrc says `use flake`);
  # nix-direnv caches it and keeps it from being garbage-collected.
  flake.modules.homeManager.base = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
