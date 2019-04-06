## requires

- Microsoft Windows 10 {Professional or Enterprise} (64-bit) Version 1809 or later
- [Docker Desktop Community](https://hub.docker.com/editions/community/docker-ce-desktop-windows) (needed switch to Windows containers mode)

## examples

### build docker

```
cd winci-msys2
docker.exe build -t mizarjp/winci-msys2 . --no-cache
```

### full-build YaneuraOu (msys2 build)

```
mkdir C:\git
cd C:\git
git.exe clone https://github.com/mizar/YaneuraOu.git
cd C:\git\YaneuraOu
docker run --rm -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:latest powershell C:\YaneuraOu\script\msys2_build.ps1
```

- isolation process

```
docker run --rm --isolation=process -v C:\git\YaneuraOu:C:\YaneuraOu mizarjp/winci-msys2:latest powershell C:\YaneuraOu\script\msys2_build.ps1
```
