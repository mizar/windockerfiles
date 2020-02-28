# escape=`
FROM mizarjp/winci-msys2-base:ltsc2019
RUN powershell -Command "`
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
"
