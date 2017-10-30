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
    interactiveShellInit = readFile ./zsh_init.zsh;
  };

  environment.systemPackages = with pkgs; [
    zsh-completions
    nix-zsh-completions
  ];

  environment.shellAliases = {
    edit = "$EDITOR -cnw";
  };
}
