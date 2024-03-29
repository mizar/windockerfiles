﻿Push-Location $PSScriptRoot;

& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$Latest = 'ltsc2019';
$Tags = @('ltsc2019';);
$Targets = @('winci-andk';);

# AdoptOpenJDK : https://adoptopenjdk.net/archive.html
# Android SDK Command line tools : https://developer.android.com/studio?hl=ja#cmdline-tools
# Android NDK : https://developer.android.com/ndk/downloads?hl=ja

Out-File -InputObject @"
# escape=``
ARG basetag="ltsc2019"
FROM mcr.microsoft.com/windows/servercore:`${basetag}
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","$([Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes(@'
$ErrorActionPreference='Stop';
$ProgressPreference='SilentlyContinue';
Push-Location C:\Windows\Temp;
curl.exe -#RLO https://dl.google.com/android/repository/android-ndk-r23b-windows.zip;
Expand-Archive -Path android-ndk-r23b-windows.zip -DestinationPath C:\Android\android-sdk;
Pop-Location;
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\Android\android-sdk\android-ndk-r23b\build','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
"@ -FilePath (Join-Path $PSScriptRoot "winci-andk.dockerfile") -Encoding utf8 -Force;

$Tags|ForEach-Object { $Tag = $_;

    docker pull mcr.microsoft.com/windows/servercore:${Tag};

    $Targets|ForEach-Object { $Target = $_;

        docker.exe build -t ${Target}:${Tag} -f "${Target}.dockerfile" --build-arg basetag=${Tag} . ;

        if($Tag -eq $Latest) {
            docker image tag ${Target}:${Latest} ${Target}:latest;
        }

    }

}

Pop-Location;
