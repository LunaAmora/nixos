{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];

      userSettings = {
        "editor.formatOnSave" = true;
        "editor.inlayHints.enabled" = "offUnlessPressed";
        "editor.unicodeHighlight.invisibleCharacters" = false;

        "diffEditor.ignoreTrimWhitespace" = false;

        "explorer.confirmDelete" = false;

        "security.workspace.trust.untrustedFiles" = "open";
        "update.showReleaseNotes" = false;
        "update.mode" = "none";

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
      };
    };
  };
}
