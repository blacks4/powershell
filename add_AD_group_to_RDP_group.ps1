######################################################################################################################
#
# This script is meant for AD Domain Member servers only
# It adds the AD Security Group "DOMAINNAME\domaingroup" to the "Remote Desktop Users" local group on
# every server listed in "C:\Users\stractenberg\Desktop\scripts\servers.txt"
# Servers in the TXT file must be AD Domain Members
# Created by Steve Tractenberg September 2015
#
######################################################################################################################

$DomainGroup = [ADSI]"WinNT://*DOMAINNAME*/*DOMAINGROUP*,group" 

foreach ($Server in Get-Content "C:\Users\stractenberg\Desktop\scripts\servers.txt")
{ 
    $LocalGroup = [ADSI]"WinNT://$Server/Remote Desktop Users,group" 
 
    $LocalGroup.Add($DomainGroup.Path) 
 
    If (!$?)
    { 
     write-host $Server "= was already configured this way" -ForegroundColor Yellow
    } 
    Else
    { 
     write-host $Server "= group successfully added" -ForegroundColor Green
    } 
}