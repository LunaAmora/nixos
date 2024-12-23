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
      prismlauncher
      vlc
      qbittorrent
      heroic
      rustup
      nil
      mold
      clang
    ];

    file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
  };

  programs.bash.historyControl = [
    "ignoreboth"
    "erasedups"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };
}
