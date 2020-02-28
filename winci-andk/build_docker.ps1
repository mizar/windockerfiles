Set-Location $PSScriptRoot;

$Tags = @(1909;'ltsc2019';);
$Targets = @('winci-andk';);

$Tags|ForEach-Object { $Tag = $_;

  $DockerPath = (Join-Path $PSScriptRoot "winci-andk-${Tag}");
  New-Item -ItemType "Directory" -Path $DockerPath -ErrorAction SilentlyContinue;
  Out-File -InputObject @"
# escape=``
FROM mcr.microsoft.com/windows/servercore:$Tag
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference='Stop';
$ProgressPreference='SilentlyContinue';
Push-Location C:\Windows\Temp;
curl.exe -#RL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u242b08.msi -o OpenJDK8U-jdk_x64_windows.msi;
curl.exe -#RL https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip -o sdk-tools-windows.zip;
Expand-Archive -Path sdk-tools-windows.zip -DestinationPath C:\Android\android-sdk;
Pop-Location;
Start-Process -NoNewWindow -PassThru -Wait -FilePath C:\Windows\System32\msiexec.exe -ArgumentList '/i','C:\Windows\Temp\OpenJDK8U-jdk_x64_windows.msi','/passive','ADDLOCAL=FeatureOracleJavaSoft,FeatureEnvironment,FeatureMain,FeatureJarFileRunWith,FeatureJavaHome';
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\Android\android-sdk\tools\bin;C:\Android\android-sdk\ndk-bundle','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
RUN echo y|C:\Android\android-sdk\tools\bin\sdkmanager.bat ndk-bundle
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
