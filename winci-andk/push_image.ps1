Set-Location $PSScriptRoot;

& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$Tags = @('latest';1909;'ltsc2019';);
$Targets = @('winci-andk';);

$Targets|ForEach-Object { $Target = $_;
    $Tags|ForEach-Object { $Tag = $_;
        docker image push mizarjp/${Target}:${Tag};
    }
}
