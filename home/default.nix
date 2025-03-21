{ pkgs, username, ... }:

{
  imports = [
    ./vscode.nix
    ./git.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      firefox
      vesktop
      vlc
      qbittorrent
      # heroic
      nil
      kdePackages.filelight
      etterna
    ];
  };
}
