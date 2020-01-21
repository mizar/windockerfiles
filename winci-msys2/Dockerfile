# escape=`
FROM mizarjp/winci-msys2-major:latest
RUN `
C:\msys64\usr\bin\bash.exe -lc 'exit 0' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Syuu' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Syu' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Su' & `
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc'
