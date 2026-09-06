# * NixOS Configuration file by Reend
# * github: Reend21

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./localization.nix
      <home-manager/nixos>
    ];

  # * Packages
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
  gnome-software
  packagekit
  decibels
  yelp
  simple-scan
  hitori
  iagno
  papers
  tali
  totem
  gnome-system-monitor
  gnome-connections
  snapshot
  extensions
]);

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # ! GNOME Fine Tune

  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ gnome2.GConf ];

  home-manager.users.reend = {
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        "app-hider@lynith.dev"
        "appindicatorsupport@rgcjonas.gmail.com" 
        "blur-my-shell@aunetx"
        "custom-hot-corners-extended@G-dH.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "medialine@funinkina.co.in"
        "caffeine@patapon.info"
        "gnome-clipboard@b00f.github.io"
        "space-bar@luchrioh"
      ];
    };
  };
};

  # * Services
  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # * System

  # ! Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # ! Users
  users.users."reend" = {
    isNormalUser = true;
    description = "Reend";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # ! Network Tuning
  networking.hostName = "badblood";

  # ? networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # ? Configure network proxy if necessary
  # ? networking.proxy.default = "http://user:password@proxy:port/";
  # ? networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  services.libinput.enable = true;

  system.copySystemConfiguration = true; # also coppy the config file to /run/current-system/configuration.nix if you accidentally deleted.
  system.stateVersion = "26.05";
  
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
