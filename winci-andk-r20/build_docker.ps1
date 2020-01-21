Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-andk-r20 . --isolation=process --no-cache ;
