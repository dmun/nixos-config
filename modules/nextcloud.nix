
{ config, lib, pkgs, ... }:

{
  environment.etc."nextcloud-admin-pass".text = "jemoeder123";
  services.nextcloud = {
    enable = true;
    # https = true;
    configureRedis = true;
    package = pkgs.nextcloud31;
    hostName = "192.168.2.21";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      adminuser = "admin";
      dbtype = "sqlite";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news calendar tasks notes deck;
      theming_customcss = pkgs.fetchNextcloudApp {
        url = "https://github.com/nextcloud/theming_customcss/releases/download/v1.18.0/theming_customcss.tar.gz";
        sha256 = "sha256-MsF+im9yCt7bRNIE8ait0wxcVzMXsHMNbp+IIzY/zJI=";
        license = "gpl3";
      };
    };
    extraAppsEnable = true;
    # settings = let
    #   prot = "http"; # or https
    #   host = "192.168.2.21";
    #   dir = "/nextcloud";
    # in {
    #   overwriteprotocol = prot;
    #   overwritehost = host;
    #   overwritewebroot = dir;
    #   overwrite.cli.url = "${prot}://${host}${dir}/";
    #   htaccess.RewriteBase = dir;
    # };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  
    virtualHosts = {
      "192.168.2.21" = {
        # forceSSL = true;
        # enableACME = true;
      };
    };
  };
}

