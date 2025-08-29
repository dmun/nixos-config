{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ../../modules/system.nix
      ../../modules/nextcloud.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
}

