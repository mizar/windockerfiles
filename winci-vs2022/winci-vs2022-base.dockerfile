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

ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
