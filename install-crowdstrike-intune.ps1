#Check if CrowdStrike is already running before doing anything else

$CrowdStrikeService = Get-Service -DisplayName "CrowdStrike Falcon Sensor Service" -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq "Running"} 
If($CrowdStrikeService)
{
Write-Host "==>CrowdStrike already installed! Nothing to do."
}
Else
{

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path 'C:\Temp' -ErrorAction SilentlyContinue)) {

    New-Item -ItemType Directory -Path 'C:\Temp' -Force

}

#Download latest version package

$FalconSensorSource = "https://uvu365-my.sharepoint.com/:u:/g/personal/10003439_uvu_edu/EQ5bRA5BHVBDg4zk_TUrLwoB9X0HntuYQPD6FIGLabTc5w?e=DjCc0E"

$FalconSensorDestination = "c:\Temp\WindowsSensor.exe"

Invoke-WebRequest -Uri $FalconSensorSource -OutFile $FalconSensorDestination

#Install Falcon Sensor

Start-Process $FalconSensorDestination -ArgumentList "/install /quiet /norestart CID=F4EA3531A68C47B1852053F4344CF473-BF" -Wait

}
