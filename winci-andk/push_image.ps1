Push-Location $PSScriptRoot;

& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$DockerUser = 'mizarjp';
$Tags = @('latest';'ltsc2019';);
$Targets = @('winci-andk';);

$Targets|ForEach-Object { $Target = $_;
    $Tags|ForEach-Object { $Tag = $_;
        Write-Host "* ${Target}:${Tag}";
        docker image tag ${Target}:${Tag} ${DockerUser}/${Target}:${Tag};
        docker image push ${DockerUser}/${Target}:${Tag};
    }
}

Pop-Location;
