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

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/ror2mm" = "r2modman.desktop";
        "x-scheme-handler/mailto" = "thunderbird.desktop";
        "text/calendar" = "thunderbird.desktop";
        "application/zip" = "org.gnome.Nautilus.desktop";
        "application/pdf" = "org.gnome.Evince.desktop";
      };
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
    settings.terminal.shell.program = "${pkgs.zellij}/bin/zellij";
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "${pkgs.nushell}/bin/nu";
      show_startup_tips = false;
    };
  };

  programs.nushell = {
    enable = true;
    settings.show_banner = false;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "iroaseta";
      editor = {
        line-number = "relative";
      };
    };
    languages = {
      language = [{
        name = "c-sharp";
        auto-format = true;
      }];
    };
  };

  programs.rofi.enable = true;

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
          "DVI-D-0" = {
            enable = true;
            mode = "1920x1080";
            primary = true;
            position = "0x0";
            rate = "144.00";
          };
        };
        fingerprint = {
          "DVI-D-0" = "00ffffffffffff0009d1317f455400000c1a010380351e782e9de1a654549f260d5054a56b80d1c0457c617c818081bc953c317c0101023a801871382d40582c4500132a2100001e000000ff003833473031393633534c300a20000000fd0038901ea021000a202020202020000000fc0042656e5120584c323431315a0a01e402010400fe5b80a07038354030203500132a2100001a866f80a07038404030203500132a2100001afc7e80887038124018203500132a2100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c7";
        };
      };
    };
  };

  services.autorandr.enable = true;
}
