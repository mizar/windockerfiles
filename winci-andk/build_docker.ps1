Set-Location $PSScriptRoot;

$Tags = @(1909;'ltsc2019';);
$Targets = @('winci-andk';);

$Tags|ForEach-Object {
  $Tag = $_;
  docker pull mcr.microsoft.com/windows/servercore:${Tag};
  $Targets|ForEach-Object {
    docker.exe build -t mizarjp/${_}:${Tag} ${_}-${Tag} --no-cache;
  }
}
