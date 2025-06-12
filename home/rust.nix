{pkgs, ...}: {
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        fill-labs.dependi
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
      ];

      userSettings = {
        "rust-analyzer.lens.enable" = false;
        "rust-analyzer.check.command" = "clippy";
      };
    };
  };

  home = {
    packages = with pkgs; [
      mold
      clang
      rustup
    ];

    file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
  };
}
