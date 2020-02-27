Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-msys2 . <#--isolation=process#> --no-cache ;
