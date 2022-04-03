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
    $badgepy = Read-Host "Location of badge.py"
    $BadgeFile = Read-Host "Location of badge_image.bin"
    $Ports = Get-WMIObject Win32_SerialPort
    if($Ports.Count -eq 1)
    {
        $ComPort = $Ports.DeviceID
    }
    elseif ($Ports.Count -gt 1)
    {
        $Ports.DeviceID
        $ComPort.ToUpper() = Read-Host -Prompt "COM Port Number (Check Device Manager)"
    }
    $CSV = Import-Csv -Path "$($Path)"
    $SaveDir = split-path -Path $Path -Parent
    if ($SaveDir -match ".")
    {
        $SaveDir = Get-ChildItem -Path $Path
        $SaveDir = Split-path $SaveDir -Parent
    }
    

    foreach ($Entry in $CSV)
    {
        if (Test-Path -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)")
        {
            $Delete = Get-ChildItem -LiteralPath "$($SaveDir)\txt" -Recurse
            foreach ($File in $Delete)
            {
                Remove-Item -LiteralPath "$($File.DirectoryName)" -Recurse -Force
            }
            New-item -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)" -ItemType Directory | Out-null -ErrorAction SilentlyContinue
        }
        else
        {
            New-item -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)" -ItemType Directory | Out-null -ErrorAction SilentlyContinue
        }
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "$($Entry.Company)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "$($Entry.BadgeName)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "$($Entry.Role)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "$($Entry.Job)"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "Badge #"
        Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.txt" -Value "$($Entry.BadgeNumber)"
        Copy-Item -Path "$($badgepy)\badge.py" -Destination "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge.py"
        Copy-Item -Path "$($BadgeFile)\badge-image.bin" -Destination "$($SaveDir)\txt\$($Entry.BadgeNumber)\badge-image.bin"
        $Rshell = rshell --version
        if ($Rshell -match "0.0.3*")
        {
            Set-Location -Path "$SaveDir\txt\"
            & rshell --port $COMPort --buffer 512 rsync \\$($Entry.BadgeNumber)\\ /pyboard
        }
        else
        {
            Write-Host "Rshell not installed.  Need to install rshell to upload the files using this script"
            Write-Host "https://github.com/dhylands/rshell"
        }
    Set-Location -Path "$SaveDir"
        Write-Host ""
        Write-Host "Badge $($Entry.BadgeNumber) completed of $($CSV.count)"
        Write-Host ""
        Write-Host "Connect next badge and press 'Enter' to Continue"
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Write-Host ""
        Set-Location -Path "$SaveDir"
    }
    Write-Host "Completed $($CSV.count) Badge Entries"
}

Function single
{
    Write-Host "No path to CSV file given.  Please follow the prompts below."
    Write-Host ""
    [string]$Company = Read-Host -Prompt "What is the Company Name?" 
    [string]$BadgeName = Read-Host -Prompt "What is the Badge Name?"
    [string]$Job = Read-Host -Prompt "What is the Job Name?"
    [string]$BadgeNumber = Read-Host -Prompt "What is the Badge Number?"
    $Ports = Get-WMIObject Win32_SerialPort
    if($Ports.Count -eq 1)
    {
        $ComPort = $Ports.DeviceID
    }
    elseif ($Ports.Count -gt 1)
    {
        $Ports.DeviceID
        $ComPort.ToUpper() = Read-Host -Prompt "COM Port Number (Check Device Manager)"
    }
    $SaveDir = Get-Location

    if (Test-Path -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt")
    {
        Remove-Item -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Recurse -Force
    }
    else
    {
        if (Test-Path -Path "$($SaveDir)\txt\$($BadgeNumber)")
        {
        }
        else
        {
            New-item -Path "$($SaveDir)\txt\$($BadgeNumber)" -ItemType Directory | Out-null -ErrorAction SilentlyContinue
        }
            
    }

    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "$($Company)"
    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "$($BadgeName)"
    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "Role"
    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "$($Job)"
    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "Badge #"
    Add-content -Path "$($SaveDir)\txt\$($BadgeNumber)\badge.txt" -Value "$($BadgeNumber)"
    Copy-Item -Path "C:\Users\legon\OneDrive\Documents\Powershell\Badge2040\badge.py" -Destination "$($SaveDir)\txt\$($BadgeNumber)\badge.py"
    Copy-Item -Path "C:\Users\legon\OneDrive\Documents\Powershell\Badge2040\badge-image.bin" -Destination "$($SaveDir)\txt\$($BadgeNumber)\badge-image.bin"
    $Rshell = rshell --version
    if ($Rshell -match "0.0.3*")
    {
        Set-Location -Path "$SaveDir\txt\"
        & rshell --port $COMPort --buffer 512 rsync \\$($BadgeNumber)\\ /pyboard
    }
    else
    {
        Write-Host "Rshell not installed.  Need to install rshell to upload the files using this script"
        Write-Host "https://github.com/dhylands/rshell"
    }
    Set-Location -Path "$SaveDir"
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
