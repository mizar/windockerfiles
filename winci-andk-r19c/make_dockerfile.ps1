Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:1809
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference='Stop';
$ProgressPreference='SilentlyContinue';
Invoke-WebRequest 'https://dl.google.com/android/repository/android-ndk-r19c-windows-x86_64.zip' -OutFile C:\Windows\Temp\android-ndk-r19c.zip;
Expand-Archive -Path C:\Windows\Temp\android-ndk-r19c.zip -DestinationPath C:\Android\android-sdk;
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\Android\android-sdk\android-ndk-r19c','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
"@ -FilePath (Join-Path $PSScriptRoot 'Dockerfile') -Encoding utf8 -Force;
