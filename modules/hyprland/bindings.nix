_: {
  flake.modules.homeManager.hyprland =
    {
      config,
      lib,
      ...
    }:
    let
      left = "left";
      down = "down";
      up = "up";
      right = "right";
    in
    {
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bindd = [
          "$mod, escape, Close active window, killactive,"

          "$mod, ${left}, Move to previous column, layoutmsg, move -col"
          "$mod, ${right}, Move to next column, layoutmsg, move +col"

          "$mod, ${down}, Resize current column -, layoutmsg, colresize -conf"
          "$mod, ${up}, Resize current column +, layoutmsg, colresize +conf"

          "$mod SHIFT, ${left}, Swap the current column to the left, layoutmsg, swapcol l"
          "$mod SHIFT, ${right}, Swap the current column to the right, layoutmsg, swapcol r"

          "$mod SHIFT, ${down}, Move window to the left, layoutmsg, movewindowto l"
          "$mod SHIFT, ${up}, Move window to the right, layoutmsg, movewindowto r"

          "$mod CTRL, l, Lock Screen, exec, ${lib.getExe config.programs.hyprlock.package}"
        ]
        ++ (
          lib.range 1 9
          |> map (
            ws:
            let
              s = toString ws;
            in
            "$mod, code:1${s}, Switch to workspace ${s}, workspace, ${s}"
          )
        );
      };
    };
}
