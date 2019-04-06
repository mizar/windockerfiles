## requires

- Microsoft Windows {10 Professional, 10 Enterprise, or Server 2019} 64-bit Version 1809 (Build 17763.*) or later
- Docker Desktop for Windows (needed switch to Windows containers mode)
  - [Community edition](https://hub.docker.com/editions/community/docker-ce-desktop-windows) でも使えるようです。
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
docker run --rm -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:latest powershell C:\YaneuraOu\script\msys2_build.ps1
```

- Process isolation

```
docker run --rm --isolation=process -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:latest powershell C:\YaneuraOu\script\msys2_build.ps1
```

- Hyper-V isolation

```
docker run --rm --isolation=hyperv -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:latest powershell C:\YaneuraOu\script\msys2_build.ps1
```
