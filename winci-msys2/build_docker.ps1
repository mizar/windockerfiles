Set-Location $PSScriptRoot;

$Tags = @(1909;'ltsc2019';);
$Targets = @('winci-msys2-base';'winci-msys2-major';'winci-msys2';);

$Tags|ForEach-Object {
  $Tag = $_;
  docker pull mcr.microsoft.com/windows/servercore:${Tag};
  $Targets|ForEach-Object {
    docker.exe build -t mizarjp/${_}:${Tag} ${_}-${Tag} --no-cache;
  }
}
