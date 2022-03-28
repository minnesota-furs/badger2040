param
(
    $Path
)
$CSV = Import-Csv -Path "$($Path)"
$SaveDir = split-path -Path $Path -Parent
New-item -Path "$($SaveDir)\txt\" -ItemType Directory
foreach ($Entry in $CSV)
{
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Furry Migration 2022"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeName)"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Role"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Rocket Engineer"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Badge #"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeNumber)"
}
