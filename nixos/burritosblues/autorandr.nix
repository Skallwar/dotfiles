{ config, pkgs, lib, ... }:

{
  services.autorandr = {
    enable = true;
    defaultTarget = "laptop";

    profiles = {
      "laptop" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
        };
        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
         };
        };
      };

      "work" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
          DP-3-1 = "00ffffffffffff0005e301276c370300141f0103803c22782a8671a355539d250d5054bfef00d1c0b30095008180814081c001010101565e00a0a0a029503020350055502100001e000000ff00474e584d354841323130373936000000fc005132375031420a202020202020000000fd00324c1e631e000a202020202020018802031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000188c0ad090204031200c405500555021000018f03c00d051a0355060883a0055502100001c00000000000000f7";
        };
        config = {
          eDP-1 = {
            enable = false;
          };
          DP-3-1 = {
            enable = true;
            primary = true;
            mode = "2560x1440";
            rate = "60";
          };
        };
      };

      # "work_closed_lid" = {
      #   fingerprint = {
      #     DP-3-1 = "00ffffffffffff0005e301276c370300141f0103803c22782a8671a355539d250d5054bfef00d1c0b30095008180814081c001010101565e00a0a0a029503020350055502100001e000000ff00474e584d354841323130373936000000fc005132375031420a202020202020000000fd00324c1e631e000a202020202020018802031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000188c0ad090204031200c405500555021000018f03c00d051a0355060883a0055502100001c00000000000000f7";
      #   };
      #   config = {
      #     DP-3-1 = {
      #       enable = true;
      #       primary = true;
      #       mode = "2560x1440";
      #       rate = "60";
      #     };
      #   };
      # };

      "home" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
          HDMI-1 = "00ffffffffffff001c540d2701010101081f0103803c2178eecb85a75335b6250d50542fcf00d1c081809500b3000101010101010101565e00a0a0a0295030203500544f2100001a000000fd0030901ef33c000a202020202020000000fc004d3237510a2020202020202020000000ff003231303830423031303730370a013e020347714a020313042f901f403f61230917078301000067030c001000383c67d85dc4017880036d1a000002013090ec0000000000e305c000e6060501646449e30f0002e2006a60e80078a0a067501c209800544f2100001a3ec200a0a0a0555030203500544f2100001a967f8078703821401c203804544f2100001e000019";
        };
        config = {
          eDP-1.enable = false;
          HDMI-1 = {
            enable = true;
            primary = true;
            mode = "2560x1440";
            rate = "120";
          };
        };
      };

      "home2" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
          DP-3 = "00ffffffffffff001c540d2701010101081f0103803c2178eecb85a75335b6250d50542fcf00d1c081809500b3000101010101010101565e00a0a0a0295030203500544f2100001a000000fd0030901ef33c000a202020202020000000fc004d3237510a2020202020202020000000ff003231303830423031303730370a013e020347714a020313042f901f403f61230917078301000067030c001000383c67d85dc4017880036d1a000002013090ec0000000000e305c000e6060501646449e30f0002e2006a60e80078a0a067501c209800544f2100001a3ec200a0a0a0555030203500544f2100001a967f8078703821401c203804544f2100001e000019";
        };
        config = {
          eDP-1 = {
            enable = false;
          };
          DP-3 = {
            enable = true;
            primary = true;
            mode = "2560x1440";
            rate = "160";
          };
        };
      };

      "paris" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
          HDMI-1 = "00ffffffffffff004c2d927039445843221e010380301b782ae635a35b4fa327115054bfef8081c0810081809500a9c0b300714f0101023a801871382d40582c4500dc0b1100001e000000fd00324b1e5412000a202020202020000000fc004c46323254343530460a202020000000ff0048345a4e3830303138390a202001af02031bf14690041f130312230907078301000067030c0020008024011d00bc52d01e20b8285540dc0b1100001e8c0ad090204031200c405500dc0b110000188c0ad08a20e02d10103e9600dc0b11000018011d007251d01e206e285500dc0b1100001e2a4480a07038274030203500dc0b1100001a0000000000000000000074";
        };
        config = {
          eDP-1.enable = false;
          HDMI-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "59";
          };
        };
      };
    }; 
  };
}
