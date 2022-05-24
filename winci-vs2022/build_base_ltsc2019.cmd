cd %~dp0
"%ProgramFiles%\Docker\Docker\DockerCli.exe" -SwitchWindowsEngine
docker build -t winci-vs2022-base:ltsc2019 -f winci-vs2022-base.dockerfile -m 8GB --build-arg basetag=ltsc2019 .
