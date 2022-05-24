# escape=`
ARG basetag="ltsc2019"
FROM mcr.microsoft.com/windows/servercore:${basetag}
RUN ["powershell","-ExecutionPolicy","Bypass","-EncodedCommand","JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQA9ACcAUwB0AG8AcAAnADsADQAKACQAUAByAG8AZwByAGUAcwBzAFAAcgBlAGYAZQByAGUAbgBjAGUAPQAnAFMAaQBsAGUAbgB0AGwAeQBDAG8AbgB0AGkAbgB1AGUAJwA7AA0ACgBQAHUAcwBoAC0ATABvAGMAYQB0AGkAbwBuACAAQwA6AFwAVwBpAG4AZABvAHcAcwBcAFQAZQBtAHAAOwANAAoAYwB1AHIAbAAuAGUAeABlACAALQAjAFIATABPACAAaAB0AHQAcABzADoALwAvAGQAbAAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBhAG4AZAByAG8AaQBkAC8AcgBlAHAAbwBzAGkAdABvAHIAeQAvAGEAbgBkAHIAbwBpAGQALQBuAGQAawAtAHIAMgAzAGIALQB3AGkAbgBkAG8AdwBzAC4AegBpAHAAOwANAAoARQB4AHAAYQBuAGQALQBBAHIAYwBoAGkAdgBlACAALQBQAGEAdABoACAAYQBuAGQAcgBvAGkAZAAtAG4AZABrAC0AcgAyADMAYgAtAHcAaQBuAGQAbwB3AHMALgB6AGkAcAAgAC0ARABlAHMAdABpAG4AYQB0AGkAbwBuAFAAYQB0AGgAIABDADoAXABBAG4AZAByAG8AaQBkAFwAYQBuAGQAcgBvAGkAZAAtAHMAZABrADsADQAKAFAAbwBwAC0ATABvAGMAYQB0AGkAbwBuADsADQAKAFIAZQBtAG8AdgBlAC0ASQB0AGUAbQAgAEAAKAAnAEMAOgBcAFcAaQBuAGQAbwB3AHMAXABUAGUAbQBwAFwAKgAnACwAJwBDADoAXABVAHMAZQByAHMAXAAqAFwAQQBwAHAAZABhAHQAYQBcAEwAbwBjAGEAbABcAFQAZQBtAHAAXAAqACcAKQAgAC0ARgBvAHIAYwBlACAALQBSAGUAYwB1AHIAcwBlADsADQAKAFsARQBuAHYAaQByAG8AbgBtAGUAbgB0AF0AOgA6AFMAZQB0AEUAbgB2AGkAcgBvAG4AbQBlAG4AdABWAGEAcgBpAGEAYgBsAGUAKAAnAFAAQQBUAEgAJwAsAFsARQBuAHYAaQByAG8AbgBtAGUAbgB0AF0AOgA6AEcAZQB0AEUAbgB2AGkAcgBvAG4AbQBlAG4AdABWAGEAcgBpAGEAYgBsAGUAKAAnAFAAQQBUAEgAJwAsACcATQBhAGMAaABpAG4AZQAnACkAKwAnADsAQwA6AFwAQQBuAGQAcgBvAGkAZABcAGEAbgBkAHIAbwBpAGQALQBzAGQAawBcAGEAbgBkAHIAbwBpAGQALQBuAGQAawAtAHIAMgAzAGIAXABiAHUAaQBsAGQAJwAsACcATQBhAGMAaABpAG4AZQAnACkAOwANAAoAJABlAG4AdgA6AFAAQQBUAEgAPQBbAEUAbgB2AGkAcgBvAG4AbQBlAG4AdABdADoAOgBHAGUAdABFAG4AdgBpAHIAbwBuAG0AZQBuAHQAVgBhAHIAaQBhAGIAbABlACgAJwBQAEEAVABIACcALAAnAE0AYQBjAGgAaQBuAGUAJwApACsAJwA7ACcAKwBbAEUAbgB2AGkAcgBvAG4AbQBlAG4AdABdADoAOgBHAGUAdABFAG4AdgBpAHIAbwBuAG0AZQBuAHQAVgBhAHIAaQBhAGIAbABlACgAJwBQAEEAVABIACcALAAnAFUAcwBlAHIAJwApADsA"]