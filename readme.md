# Powershell Scripts

This is a repository for my PowerShell scripts

## Get-WSUSMissingComputers

This script will export a list of computers that are joined to Active Directory but are not registered with the given WSUS server.
Example: `.\Get-WSUSMissingComputers.ps1 -Server wsus -Output missing.txt`