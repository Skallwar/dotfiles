{ config, pkgs, ... }:

{  
  nixpkgs.config.packageOverrides = pkgs: {
    freetype_subpixel = pkgs.freetype.override {
      useEncumberedCode = true;
    };
  };
  environment.systemPackages = [ pkgs.freetype_subpixel ];
  environment.variables.LD_LIBRARY_PATH = [ "${pkgs.freetype_subpixel}/lib" ];

  fonts.packages = with pkgs; [
      nerdfonts
      noto-fonts-emoji
      noto-fonts
      font-awesome
      source-code-pro
    ];
}
