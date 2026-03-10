_: {
  flake.modules.homeManager.gui = {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        {
          name = "selection";
          no_anim = "on";
          "match:namespace" = "selection";
        }
      ];
      windowrule = [
        {
          name = "default";
          suppress_event = "maximize";
          opacity = "0.97 0.9";
          "match:class" = ".*";
        }
        {
          name = "floating";
          center = "on";
          float = "on";
          size = "1500 1000";
          "match:tag" = "floating-window";
        }
        {
          name = "float-class";
          tag = "+floating-window";
          "match:class" = "(blueberry.py|Wiremix|org.gnome.NautilusPreviewer|About|TUI.float)";
        }
        {
          name = "float-about";
          tag = "+floating-window";
          "match:class" = "(xdg-desktop-portal-gtk|DesktopEditors)";
          "match:title" = "^(Open.*Files?|Save.*Files?|Save.*As|All Files|Save)";
        }
        {
          name = "float-picard";
          tag = "+floating-window";
          "match:class" = "(org.musicbrainz.Picard)";
          "match:title" = "^(Album Search Results|Artist Search Dialog|Track Search Results)";
        }
        {
          name = "bitwarden";
          no_screen_share = "on";
          "match:class" = "^(Bitwarden)$";
        }
        {
          name = "rule0";
          no_focus = "on";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = "1";
          "match:float" = "1";
          "match:fullscreen" = "0";
          "match:pin" = "0";
        }
      ];
    };
  };
}
