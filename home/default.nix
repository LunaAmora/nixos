{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./vscode.nix
    ./git.nix
    ./rust.nix
    ./direnv.nix
    ./alice.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      nil
      nh
      firefox
      vesktop
      vlc
      qbittorrent
      kdePackages.filelight
      audacity
      heroic
      libreoffice
      gamescope
    ];

    sessionVariables.NH_FLAKE = "/etc/nixos";
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
  };
}
