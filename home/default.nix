{ pkgs, username, ... }:

{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      firefox
      vesktop
      vscode
      prismlauncher
      vlc
      qbittorrent
      direnv
      nix-direnv
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

  programs.git = {
    enable = true;
    userName = "LunaAmora";
    userEmail = "luna.mberry@gmail.com";
    extraConfig.merge.conflictStyle = "diff3";
  };

  programs.bash.historyControl = [
    "ignoreboth"
    "erasedups"
  ];
}
