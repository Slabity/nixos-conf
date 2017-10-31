{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "common-aliases"
        "compleat"
        "dirhistory"
        "encode64"
        "fasd"
        "git"
        "git-extras"
        "nix"
        "per-directory-history"
        "sudo"
        "systemd"
        "vi-mode"
        "wd"
      ];
      theme = "../../../../../..${expr.powerlevel9k}/powerlevel9k/powerlevel9k";
    };
    interactiveShellInit = ''
      ${readFile ./powerlevel9k_init.zsh};

      edit() {
          emacsclient -cnw $@;
      }

      nsh() {
          nix-shell --command "exec zsh" $@
      }

      compinit
      '';
  };

  environment.systemPackages = with pkgs; [
    zsh-completions
    nix-zsh-completions
  ];

  environment.variables = {
    EDITOR = "edit";
    VISUAL = "edit";
  };
}
