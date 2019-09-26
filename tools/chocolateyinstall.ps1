$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destinationDir = "$($env:ProgramFiles)\SignalFx"
$configDir = "$($env:ProgramData)\SignalFxAgent"

# Test path to installation destination directory and agent config directory
if(!(Test-Path -Path $destinationDir))
{
  New-Item -ItemType directory -Path $destinationDir | Out-Null
}
if(!(Test-Path -Path $configDir))
{
  New-Item -ItemType directory -Path $configDir | Out-Null
}

# Some machines are using PSCX module for archive cmdlets, this will account for that and use
# the ones that are standard with PowerShell. The Expand-Archive will be using its fully qualified
# module name to make sure we are using the correct one for this chocolatey package.
Import-Module -Name C:\Windows\System32\WindowsPowerShell\v1.0\Modules\Microsoft.PowerShell.Archive
Microsoft.PowerShell.Archive\Expand-Archive -Path "$toolsDir\SignalFxAgent-4.10.0-win64.zip" -DestinationPath "$destinationDir\"

# Use the agent binaries arguments to do the install and start the service. This will also create a template agent.yaml file
if ($null -eq $service)
{
  $installArgs = '-service "install" -logEvents -config C:\ProgramData\SignalFx\agent.yaml'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $installArgs -NoNewWindow
  Start-Sleep -Seconds 2
  $serviceArgs = '-service "start"'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $serviceArgs -NoNewWindow
}

