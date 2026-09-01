{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.cudaPackages.cuda_nvcc
    pkgs.cudaPackages.cuda_ctadvisor
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.nccl
    pkgs.cudaPackages.cutlass
    pkgs.cudaPackages.tensorrt
  ];
}
