## requires

- Microsoft Windows {10 Professional, 10 Enterprise, or Server 2019} 64-bit Version 1909 (Build 18363.*) or later
  - `mcr.microsoft.com/windows/servercore:1909` をベースにしているため、 Process isolation では同じバージョンが必要、 Hyper-V isolation では同じかそれ以降のバージョンが必要
- Docker Desktop for Windows (needed switch to Windows containers mode)
  - [Community edition](https://hub.docker.com/editions/community/docker-ce-desktop-windows) でも使えるようです。
  - Docker Desktop for Windows インストール時は既定で Linux containers の実行モードになっていますが、このイメージには Windows containers の実行モードに切り替える必要があります。
    - https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/quick-start/quick-start-windows-10#switch-to-windows-containers
  - Docker Engine 18.09.1 以降 (Docker Desktop Version 2.0.0.3 時点で Docker Engine 18.09.2) では、 Windows 10 でも Process isolation で仮想化を実行できるようになり、 Hyper-V isolation より軽量に実行できるかと思います。但し、 Process isolation では ACL 周りで注意が必要な場合があるようです。
    - [Docker on Windows - Container Storage # Persistent Volumes](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-storage#persistent-volumes)
    - [Process Isolation for containers in Windows 10](https://blogs.msdn.microsoft.com/freddyk/2019/01/13/process-isolation-for-containers-in-windows-10/)
    - [Windows 10 で Process Isolation を使う時の注意点など](https://blog.shibayan.jp/entry/20190208/1549617101)

## examples

### build docker

```
cd winci-msys2
docker.exe build -t mizarjp/winci-msys2 . --no-cache
```

- https://cloud.docker.com/repository/docker/mizarjp/winci-msys2

### full-build YaneuraOu (msys2 build)

```
mkdir C:\git
cd C:\git
git.exe clone https://github.com/mizar/YaneuraOu.git
cd C:\git\YaneuraOu
docker pull mizarjp/winci-msys2:1909
docker run --rm -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:1909 powershell C:\YaneuraOu\script\msys2_build.ps1
```

- Process isolation

```
docker run --rm --isolation=process -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:1909 powershell C:\YaneuraOu\script\msys2_build.ps1
```

- Hyper-V isolation

```
docker run --rm --isolation=hyperv -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:1909 powershell C:\YaneuraOu\script\msys2_build.ps1
```
