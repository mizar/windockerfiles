Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-msys2-major . <#--isolation=process#> --no-cache ;
