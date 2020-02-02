# escape=`
FROM mcr.microsoft.com/windows/servercore:1903
#ADD 7za920.zip C:\Windows\Temp\
#ADD 7za920.zip msys2-base-x86_64-latest.tar.xz C:\Windows\Temp\
RUN powershell -Command "`
$ErrorActionPreference='Stop';`
$ProgressPreference='SilentlyContinue';`
if(-not (Test-Path C:\Windows\Temp\7za920.zip)){`
Invoke-WebRequest 'https://www.7-zip.org/a/7za920.zip' -OutFile C:\Windows\Temp\7za920.zip;};`
Expand-Archive -Path C:\Windows\Temp\7za920.zip -DestinationPath C:\Windows\Temp;`
if(-not (Test-Path C:\Windows\Temp\msys2-base-x86_64-latest.tar.xz)){`
Invoke-WebRequest 'https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.tar.xz' -OutFile C:\Windows\Temp\msys2-base-x86_64-latest.tar.xz;};`
C:\Windows\Temp\7za.exe e C:\Windows\Temp\msys2-base-x86_64-latest.tar.xz -oC:\Windows\Temp\;`
tar -xf C:\Windows\Temp\msys2-base-x86_64-latest.tar;`
Remove-Item 'C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*' -Force -Recurse;`
[Environment]::SetEnvironmentVariable('MSYSTEM',($env:MSYSTEM='MSYS2'),'Machine');`
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\msys64','Machine');`
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');`
C:\msys64\usr\bin\bash.exe -lc 'exit 0';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Syuu';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
Write-Host 'Successfully installed MSYS2';`
"
