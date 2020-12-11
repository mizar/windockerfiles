Set-Location $PSScriptRoot;

#& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$DockerUser = 'mizarjp';
$Tags = @('latest';'2009';'2004';'1909';'ltsc2019';);
$Targets = @('winci-msys2';'winci-msys2-base';);

$Targets|ForEach-Object { $Target = $_;
    $Tags|ForEach-Object { $Tag = $_;
        Write-Host "* ${Target}:${Tag}";
        docker image tag ${Target}:${Tag} ${DockerUser}/${Target}:${Tag};
        docker image push ${DockerUser}/${Target}:${Tag};
    }
}
