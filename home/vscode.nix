{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens

      # nix
      jnoortheen.nix-ide

      # rust
      fill-labs.dependi
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
    ];

    userSettings = {
      "editor.formatOnSave" = true;
      "editor.inlayHints.enabled" = "offUnlessPressed";
      "editor.unicodeHighlight.invisibleCharacters" = false;

      "diffEditor.ignoreTrimWhitespace" = false;

      "explorer.confirmDelete" = false;

      "security.workspace.trust.untrustedFiles" = "open";
      "update.showReleaseNotes" = false;

      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [
              "nix"
              "fmt"
              "--"
              "-"
            ];
          };
        };
      };

      "rust-analyzer.lens.enable" = false;
      "rust-analyzer.check.command" = "clippy";
    };
  };
}
