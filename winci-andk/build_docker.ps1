Set-Location $PSScriptRoot;

#& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$Latest = '2009';
$Tags = @('2009';);
$Targets = @('winci-andk';);

# AdoptOpenJDK : https://adoptopenjdk.net/archive.html
# Android SDK Command line tools : https://developer.android.com/studio?hl=ja#cmdline-tools
# Android NDK : https://developer.android.com/ndk/downloads?hl=ja

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
curl.exe -#RLO https://dl.google.com/android/repository/android-ndk-r21b-linux-x86_64.zip;
Expand-Archive -Path android-ndk-r21b-linux-x86_64.zip -DestinationPath C:\Android\android-sdk;
Pop-Location;
Remove-Item @('C:\Windows\Temp\*','C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse;
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','Machine')+';C:\Android\android-sdk\android-ndk-r21b','Machine');
$env:PATH=[Environment]::GetEnvironmentVariable('PATH','Machine')+';'+[Environment]::GetEnvironmentVariable('PATH','User');
'@)))"]
"@ -FilePath (Join-Path $DockerPath 'Dockerfile') -Encoding utf8 -Force;

}

$Tags|ForEach-Object { $Tag = $_;

    docker pull mcr.microsoft.com/windows/servercore:${Tag};

    $Targets|ForEach-Object { $Target = $_;

        #docker.exe build -t ${Target}:${Tag} ${Target}-${Tag} --no-cache;
        docker.exe build -t ${Target}:${Tag} ${Target}-${Tag};

        if($Tag -eq $Latest) {
            docker image tag ${Target}:${Latest} ${Target}:latest;
        }

    }

}
