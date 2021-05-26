# CloudAdmin

## PowerShell Gallery

### Transport Layer Security

#### PowerShell Gallery TLS Support

> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS) versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS 1.2
[PowerShell Gallery TLS Support](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/)

```powershell
use namespace System.Net
[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
```

or

```powershell
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
```

#### Repository

The Set-PSRepository cmdlet sets values for a registered module repository. The settings are persistent for the current user and apply to all versions of PowerShell installed for that user.

This command sets the installation policy for the PSGallery repository to Trusted, so that you are not prompted before installing modules from that source.

```powershell
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
```
