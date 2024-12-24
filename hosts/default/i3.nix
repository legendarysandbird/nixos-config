{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      modifier = mod;
      terminal = "alacritty";

      keybindings = lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+b" = "split h";
      };
    };
  };
}
