cd %~dp0
"%ProgramFiles%\Docker\Docker\DockerCli.exe" -SwitchWindowsEngine
docker build -t winci-vs2022-trt:ltsc2022 -f winci-vs2022-trt.dockerfile -m 8GB --build-arg basetag=ltsc2022 .
