######################################################################################################################
# 
# This script deletes WarehouseErrorLog.txt files on the C:\errorlogs folder on servers.
# Created by Steve Tractenberg August 2015
#
######################################################################################################################

foreach ($srvr in Get-Content "C:\Users\stractenberg\Desktop\scripts\WarehouseErrorLog-servers.txt")
{
Remove-Item -Path "\\$srvr\c$\errorlogs\WarehouseErrorLog.txt" -Force
}