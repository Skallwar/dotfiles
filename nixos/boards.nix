{ config, pkgs, lib, ... }:

{
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666", GROUP="plugdev"
      # Vivado stuff
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
      ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
	  ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{manufacturer}=="Xilinx", MODE:="666"
    '';
  };
}
