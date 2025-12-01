{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      python3 = super.python3.override {
        packageOverrides = pythonSelf: pythonSuper: {
          qtile = pythonSuper.qtile.overrideAttrs (oldAttrs: rec {
            qtileSession = ''
              [Desktop Entry]
              Name=Qtile Wayland
              Comment=Qtile on Wayland
              Exec=qtile start -b wayland
              Type=Application
            '';

            postInstall = oldAttrs.postInstall or "" + ''
              mkdir -p $out/share/wayland-sessions
              echo "${qtileSession}" > $out/share/wayland-sessions/qtile.desktop
            '';

            passthru = oldAttrs.passthru or {
              providedSessions = [ "qtile" ];
            };
          });
        };
      };
    })
  ];

  services = {
    xserver.windowManager.qtile = {
      enable = true;
      configFile = ./qtile.py;
    };

    displayManager = {
      defaultSession = "qtile";
      sessionPackages = [ pkgs.python3.pkgs.qtile ];
    };
  };
}
