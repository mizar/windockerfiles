# escape=`

ARG basetag="ltsc2019"

# Use the Windows Server Core image.
FROM mcr.microsoft.com/windows/servercore:${basetag} AS VSBUILDTOOLS_BASE

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

RUN powershell -c "`
Set-ExecutionPolicy Bypass -Scope Process -Force;`
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));`
cinst -y git NuGet.CommandLine`
"

RUN `
# Download the Build Tools bootstrapper.
curl.exe -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe `
# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
&& (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
--installPath "C:\BuildTools" `
--add Microsoft.VisualStudio.Workload.MSBuildTools `
--add Microsoft.VisualStudio.Workload.VCTools `
--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
--add Microsoft.VisualStudio.Component.Windows10SDK.19041 `
--remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
--remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
--remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
--remove Microsoft.VisualStudio.Component.Windows81SDK `
|| IF "%ERRORLEVEL%"=="3010" EXIT 0) `
# Cleanup
&& del /q vs_buildtools.exe;

FROM VSBUILDTOOLS_BASE AS VSBUILDTOOLS_CUDA

RUN powershell -c "`
curl.exe -RLo C:\cuda_11.7.0_windows_network.exe https://developer.download.nvidia.com/compute/cuda/11.7.0/network_installers/cuda_11.7.0_windows_network.exe;`
C:\cuda_11.7.0_windows_network.exe -s cudart_11.7 nvcc_11.7 nvrtc_11.7 visual_studio_integration_11.7;`
Wait-Process -Name cuda_11.7.0_windows_network -ErrorAction SilentlyContinue;`
Remove-Item C:\cuda_11.7.0_windows_network.exe;`
"

FROM mcr.microsoft.com/windows/servercore:${basetag} AS VSBUILDTOOLS_TRT_TEMP

COPY TensorRT-8.2.5.1.Windows10.x86_64.cuda-11.4.cudnn8.2.zip C:\
RUN powershell -c "`
Expand-Archive -Path C:\TensorRT-8.2.5.1.Windows10.x86_64.cuda-11.4.cudnn8.2.zip -DestinationPath C:\;`
"

FROM VSBUILDTOOLS_CUDA AS VSBUILDTOOLS_TRT

COPY --from=VSBUILDTOOLS_TRT_TEMP C:\TensorRT-8.2.5.1\ C:\ProgramData\YaneuraOu\TensorRT-8.2.5.1\

ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
