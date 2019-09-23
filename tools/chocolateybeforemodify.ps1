# Stop signalfx-agent service if it exists
$service = Get-Service "signalfx-agent" -ErrorAction SilentlyContinue
if ($null -ne $service)
{
    $service | Stop-Service
}
