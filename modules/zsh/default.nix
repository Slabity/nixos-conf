{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  zshCfg = cfg.zsh;

  powerlevel9k = pkgs.stdenv.mkDerivation {
    name = "powerlevel9k";
    src = pkgs.fetchFromGitHub {
      owner = "bhilburn";
      repo = "powerlevel9k";
      rev = "master";
      sha256 = "1b8ifsmk1z43gfpz15ld4a49gyclljwvf34flj6q8yd1rrgn2djq";
    };

    installPhase = ''
      mkdir -p $out/powerlevel9k
      mv * $out/powerlevel9k
    '';
  };
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
        theme = "../../../../../..${powerlevel9k}/powerlevel9k/powerlevel9k";
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
