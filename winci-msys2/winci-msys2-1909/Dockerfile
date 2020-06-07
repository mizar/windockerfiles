# escape=`
FROM mizarjp/winci-msys2-base:1909
RUN powershell -Command "`
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m openmp:m base-devel: msys2-devel:';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
"
