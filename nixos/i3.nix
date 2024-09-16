{ config, pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];

  services.libinput.enable = true;

  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "caps:escape";

    desktopManager = {
      xterm.enable = false;
      gnome.extraGSettingsOverrides = ''
      	[org.gnome.desktop.interface]
      	gtk-theme='Yaru'
      '';
      runXdgAutostartIfNone = true;
    };

    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick = {
          enable = true;
          theme.name = "Yaru";
        };
      };

    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status-rust
        i3lock-color
        dunst
      ];
    };
  };

  services.displayManager.defaultSession = "none+i3";
}
