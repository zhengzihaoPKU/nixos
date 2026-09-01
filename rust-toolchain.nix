{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
  ];

  # 让 rust-analyzer 能够定位标准库源码。
  environment.variables.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
}
