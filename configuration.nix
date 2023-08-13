# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nasty"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  #   keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    videoDrivers = [ "intel" ];
    libinput.enable = true;
    layout = "us";
    displayManager = {
      defaultSession = "none+herbstluftwm";
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuckboi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "adm" "video" "sound" "storage" ];
    createHome = true;
    home = "/home/cuckboi";
    shell = "/run/current-system/sw/bin/fish";
    packages = with pkgs; [
      firefox
      pciutils
      binutils
      coreutils
      gcc
      cmake
      git
      wget
      curl
      nano
      sudo
      vscodium
      neovim
      radare2
      shutter
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    coreutils
    binutils
    pciutils
    acpi
    htop
    sudo 
    nano
    gcc
    cmake
    vscodium
    neovim
    feh
    dmenu
    git
    curl
    networkmanager
    wirelesstools
    nmap

    cwm
    herbstluftwm
    i3
    vscodium
    firefox
    vlc
    ffmpeg
    fish
    tcsh
    rxvt-unicode
    tdesktop
    discord
    wineWowPackages.stable
    winetricks
    shopify-cli
  ];

  
  # SECURITY
  security.sudo.wheelNeedsPassword = false;

  # NIXPKGS
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystems = true;
  };


  # FLAKES
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


 #  HOME_MANAGER 
#  users.users.cuckboi.isNormalUser = true;
 # home-manager.users.cuckboi = { pkgs, ... }: {
  #  programs.fish.enable = true;
   # manual.manpages.enable = false;
  #  home.packages = [ 
   #   pkgs.fish
    #  pkgs.binutils
    #  pkgs.pciutils
    #  pkgs.git
    #  pkgs.wget
    #  pkgs.curl
    #  pkgs.sudo
    #  pkgs.shutter
    #  pkgs.rxvt-unicode
   # ];
#  };
  
  hardware = {
    bluetooth = {
      enable = true;

      settings.General.Experimental = true;
    };
  };

  services.blueman.enable = true;


  #FONTS

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono
      source-code-pro
      jetbrains-mono
    ];
  };

  #PROGRAMS
  programs.fish.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

