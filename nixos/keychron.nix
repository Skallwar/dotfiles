{ config, pkgs, lib, ... }:

{
  services.udev = {
    extraRules = ''
      SUBSYSTEMS=="input", ACTION=="add", ATTR{name}=="Keychron Keychron K6", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}+="setup-keychron.service", RUN+="${pkgs.stdenv.shell} -c 'echo 1 | tee /sys/module/hid_apple/parameters/swap_opt_cmd'"
    '';
  };

  systemd.user.services.setup-keychron = let
    script = pkgs.writeShellScriptBin "keychron_fix" ''
        sleep 1
        ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 9 = grave asciitilde"
    '';
    in {
      serviceConfig = { Type = "oneshot"; };
      script = "${lib.getExe script}";
  };
  
  services.upower.enable = true;

  hardware.bluetooth.settings = {
    General = {
      FastConnectable = true;
      Experimental = true;
      KernelExperimental = true;
    };
  };
}
