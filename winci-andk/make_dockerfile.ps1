Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:1809
RUN ["powershell", "-ExecutionPolicy", "Bypass", "-EncodedCommand", "$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference = 'Stop';
$ProgressPreference = 'SilentlyContinue';
Invoke-WebRequest 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u202b08.msi' -OutFile C:\Windows\Temp\OpenJDK8U-jdk_x64_windows.msi;
Invoke-WebRequest 'https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip' -OutFile C:\Windows\Temp\sdk-tools-windows.zip;
Expand-Archive -Path C:\Windows\Temp\sdk-tools-windows.zip -DestinationPath C:\Android\android-sdk;
@(
@{FilePath='C:\Windows\System32\msiexec.exe';Args=@('/i','C:\Windows\Temp\OpenJDK8U-jdk_x64_windows.msi','/passive');};
)|%{Start-Process -NoNewWindow -PassThru -Wait -FilePath $_.FilePath -ArgumentList $_.Args}
Remove-Item @('C:\Windows\Temp\*', 'C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('JAVA_HOME', ($env:JAVA_HOME = 'C:\Program Files\AdoptOpenJDK\jdk-8.0.202.08'), 'Machine');
$expath = ';C:\Android\android-sdk\ndk-bundle';
$env:PATH += $expath;
[Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH', 'Machine') + $expath, 'Machine');
'@)))"]
RUN echo y|C:\Android\android-sdk\tools\bin\sdkmanager.bat ndk-bundle
"@ -FilePath (Join-Path $PSScriptRoot 'Dockerfile') -Encoding utf8 -Force;
