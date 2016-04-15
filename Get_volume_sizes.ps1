######################################################################################################################
# 
# This script runs remotely and scans the volumes of servers (provided in a text file), and returns the volumes, their
# size and free space.
# Created by Steve Tractenberg September 2015
#
######################################################################################################################

foreach ($Server in Get-Content "C:\Users\stractenberg\Desktop\scripts\servers.txt")
{
Write-Host "Drive information for $Server" -ForegroundColor green

Get-WmiObject -Class Win32_LogicalDisk -ComputerName $Server |
    Where-Object {$_.DriveType -ne 5} |
    Sort-Object -Property Name | 
    Select-Object Name, VolumeName, @{"Label"="DiskSize(GB)";"Expression"={"{0:N}" -f ($_.Size/1GB) -as [float]}}, @{"Label"="FreeSpace(GB)";"Expression"={"{0:N}" -f ($_.FreeSpace/1GB) -as [float]}}, @{"Label"="%Free";"Expression"={"{0:N}" -f ($_.FreeSpace/$_.Size*100) -as [float]}} |
    Format-Table -AutoSize
}