{ ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Override packages
  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import (builtins.fetchTarball "https://github.com/nix-comm>
  #     inherit pkgs;
  #   };
  # };
}
