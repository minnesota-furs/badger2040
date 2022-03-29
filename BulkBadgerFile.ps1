<#************************************************************************************************************
Author: Kevin "Legonnare" McCarty
Purpose: Allow creation of multiple badge.txt files for Badger2040
Requirements: A CSV file with the column headers "BadgeName" and "BadgeNumber"
Usage:
    -Path : Path and filename of the CSV file containing the "BadgeName" and "BadgeNumber" information.
        If there is no path, then the script will ask for the relevant information further in the script.
        If there is a path then the CSV will be loaded and processed in bulk.  The script will still ask
        for Company name and Job title for all the names in the CSV.
************************************************************************************************************#>
Param
(
    [string]$Path
)
Function Bulk
{
    $Company = Read-Host -Prompt "What is the Company Name?"
    $Job = Read-Host -Prompt "What is the Job Name?"

    $CSV = Import-Csv -Path "$($Path)"
    $SaveDir = split-path -Path $Path -Parent
    if ($SaveDir -match ".")
    {
        $SaveDir = Get-ChildItem -Path $Path
        $SaveDir = Split-path $SaveDir -Parent
    }
    if (Test-Path -Path "$($SaveDir)\txt")
    {
        $Delete = Get-ChildItem -LiteralPath "$($SaveDir)\txt" -Recurse
        foreach ($File in $Delete)
        {
            Remove-Item -LiteralPath "$($File.FullName)" -Recurse -Force
        }
        $Delete = Get-ChildItem -LiteralPath "$($SaveDir)\txt"
    }
    else
    {
        New-item -Path "$($SaveDir)\txt" -ItemType Directory | Out-null -ErrorAction SilentlyContinue
    }

    foreach ($Entry in $CSV)
    {
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Company)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeName)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Role"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Job)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Badge #"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeNumber)"
    }
}

Function single
{
    Write-Host "No path to CSV file given.  Please follow the prompts below."
    Write-Host ""
    $Company = Read-Host -Prompt "What is the Company Name?" 
    $BadgeName = Read-Host -Prompt "What is the Badge Name?"
    $Job = Read-Host -Prompt "What is the Job Name?"
    $BadgeNumber = Read-Host -Prompt "What is the Badge Number?"
    $SaveDir = Get-Location

    if (Test-Path -Path "$($SaveDir)\txt\$($BadgeNumber)_badge.txt")
    {
        Remove-Item -Path "$($SaveDir)\txt\$($BadgeNumber)_badge.txt" -Recurse -Force
    }
    else
    {
        if (Test-Path -Path "$($SaveDir)\txt\")
        {
        }
        else
        {
            New-item -Path "$($SaveDir)\txt\$($BadgeNumber)_badge.txt" -ItemType Directory | Out-null -ErrorAction SilentlyContinue
        }
            
    }

    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "$($Company)"
    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "$($BadgeName)"
    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "Role"
    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "$($Job)"
    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "Badge #"
    Add-content -Path "txt\$($BadgeNumber)_badge.txt" -Value "$($BadgeNumber)"
}

if ($path -like "")
{
    single
}
elseif ($Path -notlike "")
{
    bulk ($Path)
}
Clear-Variable Path -ErrorAction SilentlyContinue
