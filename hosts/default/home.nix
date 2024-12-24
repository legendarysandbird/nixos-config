{ config, pkgs, ... }:

{
  imports = [
     ./i3.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "legendarysandbird";
  home.homeDirectory = "/home/legendarysandbird";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/legendarysandbird/etc/profile.d/hm-session-vars.sh
  #

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/ror2mm" = "r2modman.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "text/calendar" = "thunderbird.desktop";
      "application/zip" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
    };
  };
  
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.git = {
    enable = true;
    userName = "Brandon Dodd";
    userEmail = "legendarysandbird@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings.shell.program = "${pkgs.zellij}/bin/zellij";
  };

  programs.zellij = {
    enable = true;
    settings.default_shell = "${pkgs.nushell}/bin/nu";
  };

  programs.nushell = {
    enable = true;
  };

  programs.rofi.enable = true;

  programs.qutebrowser.enable = true;

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.freetube = {
    enable = true;
    settings = {
      autoplayVideos = false;
      barColor = true;
      defaultInterval = 0;
      defaultQuality = "1080";
      expandSideBar = false;
      hideChannelSubscriptions = true;
      hideCommentLikes = true;
      hideCommentPhotos = true;
      hideComments = true;
      hideHeaderLog = true;
      hideLabelsSideBar = false;
      hideLiveChat = true;
      hidePlaylists = false;
      hidePopularVideos = true;
      hideRecommendedVideos = true;
      hideSharingActions = true;
      hideTrendingVideos = true;
      hideVideoLikesAndDislikes = true;
      hideVideoViews = true;
      mainColor = "Amber";
      playNextVideo = false;
      quickBookmarkTargetPlayListId = "favorites";
      secColor = "Red";
      baseTheme = "dark";
    };
  };

  programs.autorandr = {
    enable = true;
    profiles = {
      desktop = {
        config = {
          "HDMI-0" = {
            enable = true;
            mode = "1920x1080";
            primary = true;
            position = "0x400";
            rate = "60.00";
            crtc = 1;  
          };
          "DP-4" = {
            enable = true;
            mode = "1920x1080";
            position = "1920x0";
            rate = "60.00";
            rotate = "left";
            crtc = 0;
          };
        };
        fingerprint = {
          "HDMI-0" = "00ffffffffffff0009d1327f455400000c1a010380351e782e9de1a654549f260d5054a56b80d1c0317c4568457c6168617c953c3168023a801871382d40582c4500132a2100001e000000ff003833473031393633534c300a20000000fd0018780f8711000a202020202020000000fc0042656e5120584c323431315a0a0184020323f15090050403020111121314060715161f202309070765030c00110083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001f8c0ad08a20e02d10103e9600132a210000190000000000000000000000000000000000000000c6";
          "DP-4" = "00ffffffffffff0006b3b128f77e0400111f0103803e22783a08a5a2574fa2280f5054bfef80d1c0814081809500b30081c08100010108e80030f2705a80b0588a006d552100001e04740030f2705a80b0588a006d552100001a000000fd00175018a03c000a202020202020000000fc00415355532056503238550a202001aa020344f15302030405900e0f1112131d1e141f5f615e605d23090707830100006d030c001100387820006001020367d85dc401788003681a00000101283c00e40f208000565e00a0a0a02950302035006d552100001ee26800a0a0402e60302036006d552100001ad50980a0205e63103060b20c6d552100001a000000000039";
        };
      };
    };
  };

  services.autorandr.enable = true;
}
