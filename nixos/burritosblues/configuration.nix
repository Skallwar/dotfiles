# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, fetchFromGitHub, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wireguard.nix
      ./autorandr.nix
      ./syncthing.nix
    ];

  # Kernel version test
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  # Cross compile
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Enable networking
  networking.hostName = "burritosblues"; # Define your hostname.
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  programs.nm-applet.enable = true;
  system.activationScripts = {
    rfkillUnblockWlan = {
      text = ''
        rfkill unblock wlan
      '';
      deps = [];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  
  # Hardware accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
      vpl-gpu-rt
      # intel-ocl
    ];
    # extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver vaapiIntel vaapiVdpau ];
  };
  
  # Fingerprint
  # services.fprintd.enable = true;
  
  # Printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplipWithPlugin
  ];
  # Important to resolve .local domains of printers, otherwise you get an error
  # like  "Impossible to connect to XXX.local: Name or service not known"

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "fr_FR.utf8";
  #   LC_IDENTIFICATION = "fr_FR.utf8";
  #   LC_MEASUREMENT = "fr_FR.utf8";
  #   LC_MONETARY = "fr_FR.utf8";
  #   LC_NAME = "fr_FR.utf8";
  #   LC_NUMERIC = "fr_FR.utf8";
  #   LC_PAPER = "fr_FR.utf8";
  #   LC_TELEPHONE = "fr_FR.utf8";
  #   LC_TIME = "fr_FR.utf8";
  # };

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    videoDrivers = [ "modesetting" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.esteban = {
    isNormalUser = true;
    description = "Esteban";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "dialout" "netboot" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables = rec {
    GTK_THEME = "Yaru";
  };

  # Use nix-ld for non patched binaries
  # programs.nix-ld.enable = true;
  # environment.variables = {
    # NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  # };
  # systemd.tmpfiles.rules = [
  #   "L+ /lib64/ld-linux-x86-64.so.2 - - - - ${pkgs.glibc}/lib64/ld-linux-x86-64.so.2"
  # ];

  # Media keys
  services.actkbd.enable = true;

 # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wants = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Sudo
  security.sudo.extraConfig = "Defaults !tty_tickets";

  # Laptop performance
  services.thinkfan = {
    enable = true; 
    levels = [
      [0 0 80]
      ["level auto" 80 90]
      ["level disengaged" 90 255]
    ];
  };
  services.throttled = {
    enable = true; # Higher TDP
    # extraArgs = ["--monitor"];
    extraConfig = ''
      [GENERAL]
      # Enable or disable the script execution
      Enabled: True
      # SYSFS path for checking if the system is running on AC power
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      # Auto reload config on changes
      Autoreload: True

      ## Settings to apply while connected to Battery power
      [BATTERY]
      # Update the registers every this many seconds
      Update_Rate_s: 30
      # Max package power for time window #1
      PL1_Tdp_W: 29
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 90
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False

      ## Settings to apply while connected to AC power
      [AC]
      # Update the registers every this many seconds
      Update_Rate_s: 5
      # Max package power for time window #1
      PL1_Tdp_W: 44
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 98
      # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
      # Uncomment only if you really want to use it
      # HWP_Mode: False
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False
    '';
  };
  services.tlp = {
    enable = true;
    settings = {
      # CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      # CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      # PLATFORM_PROFILE_ON_AC = "performance";
      # PLATFORM_PROFILE_ON_BAT = "low-power";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  # Disable suspend when closing lid with AC power
  services.logind.lidSwitchExternalPower = "ignore";
  
  # Laptop battery  
  systemd.user.timers.suspend-on-low-battery = {
    description = "Suspend on low battery";
    wantedBy = [ "timers.target" ];
    partOf = ["suspend-on-low-battery.service"];
    timerConfig = {
      OnUnitActiveSec = "2m";
      OnBootSec= "30s";
    };
  };
  systemd.user.services.suspend-on-low-battery = let
    battery-level-sufficient = pkgs.writeShellScriptBin
      "battery-level-sufficient" ''
      if [[ "$(cat /sys/class/power_supply/BAT0/status)" != Discharging ]]; then
        exit 0
      elif [[ "$(cat /sys/class/power_supply/BAT0/capacity)" -le 5 ]]; then
        ${pkgs.libnotify}/bin/notify-send --urgency=critical --hint=int:transient:1 --icon=battery_empty "Battery empty, shutting down in 2 minutes"
        sleep 120
        # Check if the user pluged the charger
        if [[ "$(cat /sys/class/power_supply/BAT0/status)" != Discharging ]]; then
        ${pkgs.libnotify}/bin/notify-send --urgency=normal --hint=int:transient:1 -t 5000 "Battery charging, disabling auto sleep"
          exit 0
        fi
        exit 1
      elif [[ "$(cat /sys/class/power_supply/BAT0/capacity)" -le 10 ]]; then
        ${pkgs.libnotify}/bin/notify-send --urgency=normal --hint=int:transient:1 --icon=battery_empty -t 5000 "Battery Low"
        exit 0
      fi
    '';
    in {
      serviceConfig = { Type = "oneshot"; };
      onFailure = [ "suspend.target" ];
      serviceConfig.PassEnvironment = [ "DISPLAY" "DBUS_SESSION_BUS_ADDRESS" ];
      script = "${lib.getExe battery-level-sufficient}";
    };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Nix
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
