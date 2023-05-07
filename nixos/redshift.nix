{ config, pkgs, lib, ... }:

{
  location.provider = "geoclue2";
  # All values except 'enable' are optional.
  services.redshift = {
    enable = true;
    brightness = {
      # Note the string values below.
      day = "1";
      night = "0.8";
    };
    temperature = {
      day = 6500;
      night = 4500;
    };
  };
}
