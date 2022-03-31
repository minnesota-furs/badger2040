param
(
    $Path
)
$CSV = Import-Csv -Path "$($Path)"
$SaveDir = split-path -Path $Path -Parent
New-item -Path "$($SaveDir)\txt\" -ItemType Directory
foreach ($Entry in $CSV)
{
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.CompanyName)"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeName)"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.JobDescription)"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.JobName)"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "Badge #"
    Add-content -Path "$($SaveDir)\txt\$($Entry.BadgeNumber)_badge.txt" -Value "$($Entry.BadgeNumber)"
}
