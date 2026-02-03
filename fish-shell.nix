{pkgs, inputs, ...}:

{
  # Set fish as default shell for all users
  users.defaultUserShell = pkgs.fish;

  # Enable fish shell
  programs.fish = {
    enable = true;
    
    # Interactive shell initialization
    interactiveShellInit = ''
      # Set up fzf key bindings if available
      if type -q fzf_key_bindings
        fzf_key_bindings
      end
    '';

    # Custom aliases
    shellAliases = {
      # Navigation
      # ".." = "cd ..";
      # "..." = "cd ../..";
      #"...." = "cd ../../..";
      
      
      
      # List files
      #"ls" = "ls -la --color=auto";
      #"ll" = "ls -lh";
      #"la" = "ls -lah";
      
      # Safety
      #"rm" = "rm -i";
      #"cp" = "cp -i";
      #"mv" = "mv -i";
      
      # Quick edits
      #"v" = "nvim";
      #"vi" = "nvim";
      #"vim" = "nvim";
      
      # System
      #"c" = "clear";
      #"q" = "exit";
      
      # Nix specific
      "rebuild" = "sudo nixos-rebuild switch";
      "nix-update" = "sudo nixos-rebuild switch --upgrade";
      "nix-gc" = "sudo nix-collect-garbage -d";
      "nix-search" = "nix search nixpkgs";
    };
  };

  # Ensure fish is in system packages
  environment.systemPackages = [
    pkgs.fish
  ];
}
