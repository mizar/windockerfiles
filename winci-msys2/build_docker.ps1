﻿Set-Location $PSScriptRoot;

$Tags = @(1909;'ltsc2019';);
$Targets = @('winci-msys2-base';'winci-msys2-major';'winci-msys2';);

$Tags|ForEach-Object { $Tag = $_;

  $DockerPath = (Join-Path $PSScriptRoot "winci-msys2-base-$Tag");
  New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
  Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:$Tag
#ADD 7za920.zip C:\Windows\Temp\
#ADD 7za920.zip msys2-base-x86_64-latest.tar.xz C:\Windows\Temp\
RUN powershell -Command "``
`$ErrorActionPreference='Stop';``
`$ProgressPreference='SilentlyContinue';``
Push-Location C:\Windows\Temp;``
if(-not (Test-Path 7za920.zip)){``
curl.exe -#RLO https://www.7-zip.org/a/7za920.zip};``
Expand-Archive -Path 7za920.zip -DestinationPath .;``
if(-not (Test-Path msys2-base-x86_64-latest.tar.xz)){``
curl.exe -#RLO https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.tar.xz};``
.\7za.exe e msys2-base-x86_64-latest.tar.xz;``
Pop-Location;``
tar -xf C:\Windows\Temp\msys2-base-x86_64-latest.tar;``
Remove-Item 'C:\Windows\Temp\*' -Force -Recurse;``
[Environment]::SetEnvironmentVariable('MSYSTEM',(`$env:MSYSTEM='MSYS2'),'Machine');``
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\msys64','Machine');``
`$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');``
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';``
Write-Host 'Successfully installed MSYS2';``
"
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

  $DockerPath = (Join-Path $PSScriptRoot "winci-msys2-major-$Tag");
  New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
  Out-File -InputObject @"
# escape=``
FROM mizarjp/winci-msys2-base:$Tag
RUN powershell -Command "``
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:';``
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';``
"
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

  $DockerPath = (Join-Path $PSScriptRoot "winci-msys2-$Tag");
  New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
  Out-File -InputObject @"
# escape=``
FROM mizarjp/winci-msys2-major:$Tag
RUN powershell -Command "``
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:';``
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';``
"
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

}

$Tags|ForEach-Object { $Tag = $_;

  docker pull mcr.microsoft.com/windows/servercore:${Tag};

  $Targets|ForEach-Object { $Target = $_;
    docker.exe build -t mizarjp/${Target}:${Tag} ${Target}-${Tag} --no-cache;
  }

}

$Targets|ForEach-Object { $Target = $_;
  docker image tag mizarjp/${Target}:1909 mizarjp/${Target}:latest;
}
