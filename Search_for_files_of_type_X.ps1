######################################################################################################################
# 
# This script runs remotely and searches domain servers provided in a text file, looking for .BAK type
# files on D:, L: or T:. It requires a text file with the server hostnames.
# Created by Steve Tractenberg March 2016
#
######################################################################################################################

foreach ($srvr in Get-Content "C:\Users\stractenberg\Desktop\scripts\servers.txt")
{

dir \\$srvr\d$\*.bak
dir \\$srvr\l$\*.bak
dir \\$srvr\t$\*.bak

}