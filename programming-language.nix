{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # go
<<<<<<< HEAD
    (python313.withPackages(ps: with ps; [ pygobject3 ]))
    uv
=======
   # (python313.withPackages(ps: with ps; [ pygobject3 ]))
   # uv
>>>>>>> 08db6f7 (revise)
    # nodePackages_latest.nodejs
    # nodePackages_latest.pnpm
    # bun
    # lua
    # zig
    # numbat
    # gleam
  ];
}
