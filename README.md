# 可跨设备复用的 NixOS 配置

仓库只保存与硬件无关的系统和 Home Manager 配置。以下文件由每台设备单独维护，且已被 Git 忽略：

- `hardware-configuration.nix`：文件系统 UUID、内核模块和 CPU 架构等探测结果。
- `host-configuration.nix`：主机名和 UEFI/BIOS 启动器等主机设置。

## 在新设备上使用

在本仓库目录中生成硬件配置：

```sh
sudo nixos-generate-config --show-hardware-config | sudo tee hardware-configuration.nix >/dev/null
cp host-configuration.nix.example host-configuration.nix
```

编辑 `host-configuration.nix`，至少设置唯一主机名，并根据设备选择 UEFI 或 BIOS 启动器。然后检查并部署：

```sh
sudo nixos-rebuild dry-build --flake "path:$PWD#nixos"
sudo nixos-rebuild switch --flake "path:$PWD#nixos"
```

这里必须使用 `path:`，因为普通 Git flake 不会包含被 Git 忽略的本机文件。

新安装完成后，不要把密码写进 Nix 配置；在目标系统上运行：

```sh
sudo passwd zihao
```

`nixosModules.default` 是纯通用模块，也可以从另一个主机 flake 中导入。
