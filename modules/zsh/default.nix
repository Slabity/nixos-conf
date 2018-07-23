{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  zshCfg = cfg.zsh;
in
{
  options.foxos.zsh.enable = mkEnableOption "Use ZSH shell.";

  config = mkIf zshCfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
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
        theme = "../../../../../..${pkgs.powerlevel9k}/powerlevel9k/powerlevel9k";
      };

      interactiveShellInit = ''
        ${readFile ./powerlevel9k_init.zsh};
        compinit
      '';
    };

    environment.systemPackages = with pkgs; [
      zsh-completions
      nix-zsh-completions
    ];
  };
}
