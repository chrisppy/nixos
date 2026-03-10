_: {
  flake.modules.homeManager.hyprland = {
    inputs,
    lib,
    pkgs,
    ...
  }: let
    left = "left";
    down = "down";
    up = "up";
    right = "right";
    launcher = "${inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher}/bin/hyprlauncher";
    term = "${pkgs.kitty}/bin/kitty";
  in {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bindd =
        [
          "$mod, escape, Close active window, killactive,"
          "$mod, space, Launch apps, exec, ${launcher} | xargs hyprctl dispatch exec"
          "$mod, return, Terminal, exec, ${term}"

          "$mod, ${left}, Move to previous column, layoutmsg, move -col"
          "$mod, ${right}, Move to next column, layoutmsg, move +col"

          "$mod, ${down}, Resize current column -, layoutmsg, colresize -conf"
          "$mod, ${up}, Resize current column +, layoutmsg, colresize +conf"

          "$mod SHIFT, ${left}, Swap the current column to the left, layoutmsg, swapcol l"
          "$mod SHIFT, ${right}, Swap the current column to the right, layoutmsg, swapcol r"

          "$mod SHIFT, ${down}, Move window to the left, layoutmsg, movewindowto l"
          "$mod SHIFT, ${up}, Move window to the right, layoutmsg, movewindowto r"
        ]
        ++ (
          10
          |> lib.genList toString
          |> map (ws: [
            "$mod, code:1${ws}, Switch to workspace ${ws}, workspace, ${ws}"
          ])
          |> lib.concatLists
        );
    };
  };
}
