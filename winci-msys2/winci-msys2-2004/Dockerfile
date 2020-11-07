# escape=`
FROM winci-msys2-base:2004
RUN powershell -Command "`
C:\msys64\usr\bin\bash.exe -lc \"ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"sed -i '1iServer = https://jaist.dl.sourceforge.net/project/msys2/REPOS/MSYS2/`$arch/' /etc/pacman.d/mirrorlist.msys\";`
C:\msys64\usr\bin\bash.exe -lc \"sed -i '1iServer = https://jaist.dl.sourceforge.net/project/msys2/REPOS/MINGW/i686/' /etc/pacman.d/mirrorlist.mingw32\";`
C:\msys64\usr\bin\bash.exe -lc \"sed -i '1iServer = https://jaist.dl.sourceforge.net/project/msys2/REPOS/MINGW/x86_64/' /etc/pacman.d/mirrorlist.mingw64\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc \"pacman --noconfirm --disable-download-timeout -Syuu; ps -ef ^| grep '[?]' ^| awk '{print `$2}' ^| xargs -r kill\";`
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S boost:m clang:m openblas:m opencl-headers:m opencl-icd-git:x openmp:m toolchain:m base-devel: git: msys2-devel:';`
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc';`
"
