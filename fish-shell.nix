{ pkgs, ... }:

let
  starshipConfig = (pkgs.formats.toml { }).generate "starship.toml" {
    add_newline = false;
    format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

    username = {
      format = "[$user]($style)@";
      style_user = "bold blue";
      show_always = false;
    };

    hostname = {
      format = "[$hostname]($style) ";
      style = "bold green";
      ssh_only = true;
    };

    directory = {
      format = "[$path]($style)[$read_only]($read_only_style) ";
      style = "bold cyan";
      truncation_length = 4;
      truncate_to_repo = true;
      read_only = " ro";
    };

    git_branch = {
      format = "[$symbol$branch]($style) ";
      symbol = "git:";
      style = "bold purple";
    };

    git_status = {
      format = "([$all_status$ahead_behind]($style) )";
      style = "bold yellow";
    };

    cmd_duration = {
      min_time = 1000;
      format = "[took $duration]($style) ";
      style = "yellow";
    };

    character = {
      success_symbol = "[❯](bold green)";
      error_symbol = "[❯](bold red)";
    };
  };
in
{
  # Fish is both the system default and zihao's explicit login shell.
  users.defaultUserShell = pkgs.fish;
  users.users.zihao.shell = pkgs.fish;

  programs.fish = {
    enable = true;

    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';

    interactiveShellInit = ''
      set -g fish_greeting
      set -g fish_color_command brgreen --bold
      set -g fish_color_param cyan
      set -g fish_color_error brred --bold
      set -g fish_color_autosuggestion 555

      if type -q fzf_key_bindings
        fzf_key_bindings
      end
    '';

    shellAliases = {
      ls = "eza --group-directories-first";
      ll = "eza -lah --group-directories-first";
      la = "eza -a --group-directories-first";
      tree = "eza --tree --group-directories-first";
      gs = "git status --short --branch";

      rebuild = "sudo nixos-rebuild switch";
      nix-update = "sudo nixos-rebuild switch --upgrade";
      nix-gc = "sudo nix-collect-garbage -d";
      nix-search = "nix search nixpkgs";
    };
  };

  environment.variables.STARSHIP_CONFIG = starshipConfig;

  environment.systemPackages = with pkgs; [
    fish
    starship
    eza
    bat
    fzf
  ];
}
