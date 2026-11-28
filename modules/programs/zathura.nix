_: {
  flake.modules.nixos.pc =
    { config, ... }:
    let
      inherit (config.lib.stylix) colors;
      inherit (config.stylix) opacity;
      channel = name: c: colors."${name}-rgb-${c}";
      rgb = name: "rgb(${channel name "r"}, ${channel name "g"}, ${channel name "b"})";
      rgba = name: alpha: "rgba(${channel name "r"}, ${channel name "g"}, ${channel name "b"}, ${toString alpha})";
    in
    {
      # Stylix's zathura target (from base16-zathura), without Home Manager.
      wrappers.zathura.module.settings = {
        default-bg = rgba "base00" opacity.applications;
        default-fg = rgb "base01";
        statusbar-fg = rgb "base04";
        statusbar-bg = rgb "base02";
        inputbar-bg = rgb "base00";
        inputbar-fg = rgb "base07";
        notification-bg = rgb "base00";
        notification-fg = rgb "base07";
        notification-error-bg = rgb "base00";
        notification-error-fg = rgb "base08";
        notification-warning-bg = rgb "base00";
        notification-warning-fg = rgb "base08";
        highlight-color = rgba "base0A" 0.5;
        highlight-active-color = rgba "base0D" 0.5;
        completion-bg = rgb "base01";
        completion-fg = rgb "base0D";
        completion-highlight-fg = rgb "base07";
        completion-highlight-bg = rgb "base0D";
        recolor-lightcolor = rgb "base00";
        recolor-darkcolor = rgb "base06";
      };
    };
}
