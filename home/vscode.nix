{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens

        # nix
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

        "gitlens.views.scm.grouped.views" = {
          "commits" = true;
          "branches" = true;
          "remotes" = true;
          "stashes" = false;
          "tags" = true;
          "worktrees" = true;
          "contributors" = true;
          "repositories" = false;
          "searchAndCompare" = false;
          "launchpad" = false;
        };
      };
    };
  };
}
