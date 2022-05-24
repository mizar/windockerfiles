Push-Location $PSScriptRoot;

& $Env:ProgramFiles\\Docker\\Docker\\DockerCli.exe -SwitchWindowsEngine

$Latest = 'ltsc2022';
$Tags = @('ltsc2019';'ltsc2022';'2004';'20H2';);
$Targets = @('winci-msys2-base';'winci-msys2';);

function DockerExec($o) {
    docker.exe pull mcr.microsoft.com/windows/servercore:$($o.Tag);

    $o.Targets|ForEach-Object { $Target = $_;

        docker.exe build -t ${Target}:$($o.Tag) -f "${Target}.dockerfile" --build-arg basetag=$($o.Tag) .;

        if($o.Tag -eq $o.Latest) {
            docker image tag ${Target}:$($o.Latest) ${Target}:latest;
        }

    }
}
$DockerExecDef = $function:DockerExec.ToString();

$Tags|
ForEach-Object {
    @{
        Tag = $_;
        Targets = $Targets;
        Latest = $Latest;
    };
}|
ForEach-Object -ThrottleLimit 5 -Parallel {
    $function:DockerExec = $using:DockerExecDef;
    DockerExec($_);
}

Pop-Location;
