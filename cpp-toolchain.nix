{pkgs, inputs, ...}:

{
  environment.systemPackages = [
    pkgs.python313Packages.cmake
  ];
}
