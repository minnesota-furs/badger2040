Param(
    [Parameter(HelpMessage = "What is the path to the CSV file with all the badge names and numbers?")]
    [string]$Path,
    [Parameter(HelpMessage = "What Company should be listed?")]
    [string]$Company = "Furry Migration 2022",
    [Parameter(HelpMessage = "What job title should be given?")]
    [string]$Job = "Rocket Scientist"
)
$CSV = Import-Csv -Path "$($Path)"
$SaveDir = split-path -Path $Path -Parent

if (Test-Path -Path "$($SaveDir)\txt\")
{
    Remove-Item -Path "$($SaveDir)\txt\" -Recurse -Force
    New-item -Path "$($SaveDir)\txt\" -ItemType Directory | Out-null
}
else
{
    New-item -Path "$($SaveDir)\txt\" -ItemType Directory
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
