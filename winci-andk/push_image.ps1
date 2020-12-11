Set-Location $PSScriptRoot;

#& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$DockerUser = 'mizarjp';
$Tags = @('latest';'2009';);
$Targets = @('winci-andk';);

$Targets|ForEach-Object { $Target = $_;
    $Tags|ForEach-Object { $Tag = $_;
        Write-Host "* ${Target}:${Tag}";
        docker image tag ${Target}:${Tag} ${DockerUser}/${Target}:${Tag};
        docker image push ${DockerUser}/${Target}:${Tag};
    }
}
