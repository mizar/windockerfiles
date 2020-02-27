Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-msys2-base . <#--isolation=process#> --no-cache ;
