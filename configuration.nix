# NixOS Configuration file by Reend
# github: Reend21

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Paketler
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  pkgs.vscodium 
  pkgs.fish
  pkgs.flatpak
  ];

  environment.gnome.excludePackages = (with pkgs; [
  atomix
  cheese
  evince
  geary
  gedit
  gnome-contacts
  gnome-weather
  gnome-maps
  gnome-characters
  gnome-music
  gnome-photos
  gnome-terminal
  gnome-tour
  gnome-logs
  decibels
  yelp
  simple-scan
  hitori
  iagno
  papers
  tali
  totem
]);

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Önyükleme
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = true;

  boot.loader.grub.enable = false;
  # boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = false;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "tr_TR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "trq";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  services.libinput.enable = true;

  users.users."reend" = {
    isNormalUser = true;
    description = "Reend";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Servisler
  services.openssh.enable = true;
  services.flatpak.enable = true;

  # Güvenlik Duvarı Opsiyonları
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Sistem Opsiyonları
  networking.hostName = "badblood";

  system.copySystemConfiguration = true; # also coppy the config file to /run/current-system/configuration.nix if you accidentally deleted.
  system.stateVersion = "26.05";

  # Video için tutulan opsiyonlar
  # Enable CUPS to print documents.
  # services.printing.enable = true; 
}
