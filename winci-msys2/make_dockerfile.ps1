$Tags = @(1909;'ltsc2019';);

$Tags|ForEach-Object {

$DockerPath = (Join-Path $PSScriptRoot "winci-msys2-base-$_");
New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:$_
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

$DockerPath = (Join-Path $PSScriptRoot "winci-msys2-$_");
New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
Out-File -InputObject @"
# escape=``
FROM mizarjp/winci-msys2-base:$_
RUN powershell -Command "``
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:';``
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';``
"
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

$DockerPath = (Join-Path $PSScriptRoot "winci-msys2-$_");
New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
Out-File -InputObject @"
# escape=``
FROM mizarjp/winci-msys2-major:$_
RUN powershell -Command "``
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print ```$2}' ^| xargs -r kill\";``
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:';``
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';``
"
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

}
