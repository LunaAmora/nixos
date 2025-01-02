{ pkgs, ... }:

let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./.;
    dontUnpack = true;
    installPhase = ''
      cp $src/wallpaper.png $out
    '';
  };
in
{
  services = {
    displayManager.sddm = {
      theme = "breeze";
      enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background = ${background-package}
    '')
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
}
