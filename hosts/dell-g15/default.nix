{
  pkgs,
  config,
  username,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ../../modules/system.nix {inherit pkgs username;})
    ../../modules/wm/kde.nix
  ];

  networking.hostName = hostname;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  services = {
    xserver = {
      # Configure keymap in X11
      xkb = {
        layout = "br";
        variant = "";
      };
      enable = true;
      videoDrivers = [
        "modesetting"
        "nvidia"
      ];
    };

    tailscale.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [intel-media-driver];
    };

    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Open Source Kernel Modules
      open = true;

      # Apply CachyOS kernel 6.19 patch to NVIDIA latest driver
      package = let
        base = config.boot.kernelPackages.nvidiaPackages.beta;
        cachyos-nvidia-patch = pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
          sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
        };

        # Patch the appropriate driver based on config.hardware.nvidia.open
        driverAttr =
          if config.hardware.nvidia.open
          then "open"
          else "bin";
      in
        base
        // {
          ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or []) ++ [cachyos-nvidia-patch];
          });
        };

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    opentabletdriver.enable = true; #OTD
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  # ZRam
  zramSwap.enable = true;

  # Swap File
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];
}
