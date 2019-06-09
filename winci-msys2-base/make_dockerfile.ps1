Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:1809
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference='Stop';
$ProgressPreference='SilentlyContinue';
Invoke-WebRequest 'https://www.7-zip.org/a/7za920.zip' -OutFile C:\Windows\Temp\7za920.zip;
Expand-Archive -Path C:\Windows\Temp\7za920.zip -DestinationPath C:\Windows\Temp;
Invoke-WebRequest 'http://repo.msys2.org/distrib/msys2-x86_64-latest.tar.xz' -OutFile C:\Windows\Temp\msys2-x86_64-latest.tar.xz;
@(
@{FilePath='C:\Windows\Temp\7za.exe';Args=@('e','C:\Windows\Temp\msys2-x86_64-latest.tar.xz','-oC:\Windows\Temp\');};
@{FilePath='C:\Windows\Temp\7za.exe';Args=@('x','C:\Windows\Temp\msys2-x86_64-latest.tar','-oC:\');};
)|%{Start-Process -NoNewWindow -PassThru -Wait -FilePath $_.FilePath -ArgumentList $_.Args}
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('MSYSTEM',($env:MSYSTEM='MSYS2'),'Machine');
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\msys64','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
"@ -FilePath (Join-Path $PSScriptRoot 'Dockerfile') -Encoding utf8 -Force;
