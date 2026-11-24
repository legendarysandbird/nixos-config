# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.maccel.nixosModules.default
      ../../modules/nixos/lutris.nix
      ../../modules/nixos/qtile/qtile.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      dpi = 96;
    };
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "custom";
      #   accelPointsMotion = [ 0.0 0.5 1.0 2.0 4.0 ];
      #   accelStepMotion = 0.5;
      #   accelPointsScroll = [ 1.0 2.0 4.0 ];
      #   accelStepScroll = 1.0;
      # };
    };
    udev.packages = [ pkgs.via ];
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    samba = {
      enable = true;
    };
  };

  fileSystems."/mnt/share" = {
    device = "//192.168.10.107/media";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-time=5s";
    in ["${automount_opts},credentials=/home/legendarysandbird/.config/nixos/smb-secrets"];
  };
  
  systemd = {
    targets.sleep.enable = false;
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    keyboard.qmk.enable = true;
    graphics = {
      enable = true;
    };
    maccel = {
      enable = true;
      enableCli = true;

      parameters = {
        sensMultiplier = 0.40;
        yxRatio = 1.0;
        inputDpi = 1000.0;
        angleRotation = 0.0;
        mode = "linear";

        acceleration = 0.0;
        offset = 0.0;
        outputCap = 0.0;
      };
    };
  };

  users.groups.maccel.members = [ "legendarysandbird" ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.legendarysandbird = {
      isNormalUser = true;
      description = "LegendarySandbird";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      #  thunderbird
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "legendarysandbird" = import ./home.nix;
    };
  };

  programs.thunar.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    element-desktop
    ldtk
    thunderbird
    libreoffice-qt
    librewolf
    hunspell
    hunspellDicts.en_US
    r2modman
    via
    qmk
    usbutils
    wineWow64Packages.stable
    linuxPackages.usbip
    godot-mono
    gitui
    texliveSmall
    rhythmbox
    cifs-utils
    opencomposite
    prismlauncher
    pulseaudio
    playerctl
    brightnessctl
    firefox
    inkscape
    pavucontrol
  ];

  # services.xserver.config = ''
  #   Section "InputClass"
  #     Identifier "Kensington Expert Force Custom"
  #     MatchProduct "Kensington Expert Mouse"
  #     Driver "libinput"
  #     Option "AccelProfile" "custom"
  #     Option "AccelStepMotion" "1.0"
  #     Option "AccelPointsMotion" "0.0 0.2 1.0 2.5 5.0"
  #   EndSection
  # '';

  fonts.packages = with pkgs; [
    nerd-fonts.hurmit
    roboto
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
