{ config, pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    libinput.enable = true;

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

      defaultSession = "none+i3";
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
}
