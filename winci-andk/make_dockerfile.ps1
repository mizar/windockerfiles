Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:1903
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference='Stop';
$ProgressPreference='SilentlyContinue';
Invoke-WebRequest 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b04/OpenJDK8U-jdk_x64_windows_hotspot_8u212b04.msi' -OutFile C:\Windows\Temp\OpenJDK8U-jdk_x64_windows.msi;
Invoke-WebRequest 'https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip' -OutFile C:\Windows\Temp\sdk-tools-windows.zip;
Expand-Archive -Path C:\Windows\Temp\sdk-tools-windows.zip -DestinationPath C:\Android\android-sdk;
@(
@{FilePath='C:\Windows\System32\msiexec.exe';Args=@('/i','C:\Windows\Temp\OpenJDK8U-jdk_x64_windows.msi','/passive','ADDLOCAL=FeatureOracleJavaSoft,FeatureEnvironment,FeatureMain,FeatureJarFileRunWith,FeatureJavaHome');};
)|%{Start-Process -NoNewWindow -PassThru -Wait -FilePath $_.FilePath -ArgumentList $_.Args}
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\Android\android-sdk\tools\bin;C:\Android\android-sdk\ndk-bundle','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
RUN echo y|C:\Android\android-sdk\tools\bin\sdkmanager.bat ndk-bundle
"@ -FilePath (Join-Path $PSScriptRoot 'Dockerfile') -Encoding utf8 -Force;
