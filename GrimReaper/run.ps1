# Input bindings are passed in via param block.
param($Timer)

# Write an information log with the current time.
Write-Host "The grim reaper arises to find those for whom death tolls ☠️"

# Query resource groups using both naming convention and/or tag-based
$toll = @()
$toll += Get-AzResourceGroup | Where-Object ResourceGroupName -like 'deleteme*'
$toll += Get-AzResourceGroup | Where-Object ResourceGroupName -like 'd-*'
$toll += Get-AzResourceGroup -Tag @{"keep-alive"="false"}

# Just adding some more logging output
if ($toll.Count -gt 0)
{
    Write-Host "Found $($toll.Count) items...bring out your dead..."
}
else 
{
    Write-Host "The village was spared this day...nothing to see here."
}

# Iterate through each found ResourceGroup and queue it up as a force delete
Foreach ($g in $toll)
{
    Write-Host "Goodbye $($g.ResourceGroupName) 🔔..."
    Remove-AzResourceGroup -Name $g.ResourceGroupName -Force -AsJob
    Write-Host "⚰️"
}

# Fin
Write-Host "🌙 The reaper returns to his resting until death tolls again..."