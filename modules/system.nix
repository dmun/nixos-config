{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    vim_configurable
    curl
    wget
    git
    htop
    tmux
    glance
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
    };
  };

  programs.ssh.enableAskPassword = true;

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 80 443 ]; # HTTP and HTTPS
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}

