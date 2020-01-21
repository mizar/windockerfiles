Set-Location $PSScriptRoot;

docker.exe build -t mizarjp/winci-andk-r19c . --isolation=process --no-cache ;
