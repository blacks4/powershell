######################################################################################################################
# 
# This script runs remotely and determines the last time servers were rebooted. A text file with the server list must
# be provided.
# Created by Steve Tractenberg December 2015
#
######################################################################################################################

foreach ($Server in Get-Content "C:\Users\stractenberg\Desktop\scripts\servers.txt")
{
Write-Host -NoNewline $Server "Last Reboot = "

[Management.ManagementDateTimeConverter]::ToDateTime( (gwmi Win32_OperatingSystem -Comp $Server).LastBootUpTime )

}