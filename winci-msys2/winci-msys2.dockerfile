# escape=`
ARG basetag="ltsc2019"
FROM winci-msys2-base:${basetag}
RUN powershell -Command "`
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Sy; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Sy; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -Sy clang:m openblas:m openmp:m toolchain:m expect: git:';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
Exit-PSSession;`
"
