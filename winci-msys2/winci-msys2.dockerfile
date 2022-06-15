# escape=`
ARG basetag="ltsc2019"
FROM mcr.microsoft.com/windows/servercore:${basetag}
# msys2 Nightly/Weekly Installer Builds [x86_64] https://github.com/msys2/msys2-installer/releases/tag/nightly-x86_64
RUN powershell -Command "`
$ErrorActionPreference='Stop';`
$ProgressPreference='SilentlyContinue';`
curl.exe -#RLo C:\Windows\Temp\msys2-base-x86_64-latest.sfx.exe https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe;`
Set-Location C:\;`
C:\Windows\Temp\msys2-base-x86_64-latest.sfx.exe;`
Remove-Item 'C:\Windows\Temp\*' -Force -Recurse;`
[Environment]::SetEnvironmentVariable('MSYSTEM',($env:MSYSTEM='MSYS2'),'Machine');`
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\msys64','Machine');`
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');`
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Sy; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --needed --noconfirm --disable-download-timeout -Sy pactoys-git; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -Sy clang:m openblas:m openmp:m toolchain:m expect: git:';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
Exit-PSSession;`
"
