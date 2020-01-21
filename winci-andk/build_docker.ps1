Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-andk . --isolation=process --no-cache ;
