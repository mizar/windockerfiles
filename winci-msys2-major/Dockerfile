# escape=`
FROM mizarjp/winci-msys2-base:latest
RUN `
C:\msys64\usr\bin\bash.exe -lc exit & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm --noprogressbar -Syuu' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm --noprogressbar -Syu' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm --noprogressbar -Su' & `
C:\msys64\usr\bin\bash.exe -lc 'pacboy --needed --noconfirm --noprogressbar --disable-download-timeout -S toolchain:m clang:m openblas:m base-devel: msys2-devel:' & `
C:\msys64\usr\bin\bash.exe -lc 'pacman --noconfirm -Scc'
