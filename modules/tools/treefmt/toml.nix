_: {
  perSystem.treefmt = {
    programs.taplo.enable = true;
    settings.formatter.taplo.options = [
      "fmt"
      "-o"
      "align_entries=true"
      "-o"
      "reorder_keys=true"
    ];
  };
}
