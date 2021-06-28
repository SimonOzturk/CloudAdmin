using namespace System.Management.Automation
using namespace System.Net

[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Install-Module -Name 'MSOnline' -Confirm:$false -Force
Install-Module -Name 'AzureAD' -Confirm:$false -Force
Install-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -Confirm:$false -Force
Install-Module -Name 'PnP.PowerShell' -Confirm:$false -Force
Install-Module -Name 'MicrosoftTeams' -Confirm:$false -Force
Install-Module -Name 'Microsoft.PowerApps.Administration.PowerShell' -Confirm:$false -Force
Install-Module -Name 'Microsoft.PowerApps.PowerShell' -AllowClobber -Confirm:$false -Force
Install-Module -Name 'Microsoft.Xrm.OnlineManagementAPI' -Confirm:$false -Force
Install-Module -Name 'Microsoft.Xrm.Tooling.CrmConnector.PowerShell' -Confirm:$false -Force

Import-Module -Name 'MSOnline'
Import-Module -Name 'AzureAD'
Import-Module -Name 'Microsoft.Online.SharePoint.PowerShell'
Import-Module -Name 'PnP.PowerShell'
Import-Module -Name 'MicrosoftTeams'
Import-Module -Name 'Microsoft.PowerApps.Administration.PowerShell'
Import-Module -Name 'Microsoft.PowerApps.PowerShell'
Import-Module -Name 'Microsoft.Xrm.OnlineManagementAPI'
Import-Module -Name 'Microsoft.Xrm.Tooling.CrmConnector.PowerShell'

$Tenant = Get-Content .\Config.json  | ConvertFrom-Json -AsHashtable
$Tenant.AzureAD.Admin.Credential = [PSCredential]::new($Tenant.AzureAD.Admin.UserName, (ConvertTo-SecureString $Tenant.AzureAD.Admin.Password -AsPlainText -Force ))
$Tenant.SharePoint.Admin.Credential = [PSCredential]::new($Tenant.SharePoint.Admin.UserName, (ConvertTo-SecureString $Tenant.SharePoint.Admin.Password -AsPlainText -Force ))
$Tenant.Exchange.Admin.Credential = [PSCredential]::new($Tenant.Exchange.Admin.UserName, (ConvertTo-SecureString $Tenant.Exchange.Admin.Password -AsPlainText -Force ))
$Tenant.Complience.Admin.Credential = [PSCredential]::new($Tenant.Complience.Admin.UserName, (ConvertTo-SecureString $Tenant.Complience.Admin.Password -AsPlainText -Force ))
$Tenant.Teams.Admin.Credential = [PSCredential]::new($Tenant.Teams.Admin.UserName, (ConvertTo-SecureString $Tenant.Teams.Admin.Password -AsPlainText -Force ))
$Tenant.PowerApps.Admin.Credential = [PSCredential]::new($Tenant.PowerApps.Admin.UserName, (ConvertTo-SecureString $Tenant.PowerApps.Admin.Password -AsPlainText -Force ))

Connect-MsolService -Credential $Tenant.AzureAD.Admin.Credential
Connect-AzureAD -Credential $Tenant.AzureAD.Admin.Credential
Connect-SPOService -Credential $Tenant.SharePoint.Admin.Credential -Url $Tenant.SharePoint.Admin.Url
Connect-PnPOnline -Url $Tenant.SharePoint.Admin.Url -UseWebLogin 
Connect-MicrosoftTeams -Credential $Tenant.Teams.Admin.Credential  
Add-PowerAppsAccount -Endpoint prod -Username $Tenant.PowerApps.Admin.UserName -Password (ConvertTo-SecureString $Tenant.PowerApps.Admin.Password -AsPlainText -Force )

