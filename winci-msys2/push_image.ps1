Set-Location $PSScriptRoot;

#& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$Tags = @('latest';'2004';'1909';'ltsc2019';);
$Targets = @('winci-msys2';'winci-msys2-base';);

$Targets|ForEach-Object { $Target = $_;
    $Tags|ForEach-Object { $Tag = $_;
        docker image push mizarjp/${Target}:${Tag};
    }
}
