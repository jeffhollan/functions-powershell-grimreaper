# Input bindings are passed in via param block.
param($Timer)

# Write an information log with the current time.
Write-Host "The grim reaper arises to find those for whom death tolls ☠️"

$toll = @()
$toll += Get-AzResourceGroup | Where-Object ResourceGroupName -like 'deleteme*'
$toll += Get-AzResourceGroup | Where-Object ResourceGroupName -like 'd-*'
$toll += Get-AzResourceGroup -Tag @{"keep-alive"="false"}

Foreach ($g in $toll)
{
    Write-Host "Goodbye $($g.ResourceGroupName) 🔔..."
    Remove-AzResourceGroup -Name $g.ResourceGroupName -Force -AsJob
    Write-Host "⚰️"
}

Write-Host "🌙 The reaper returns to his resting until death tolls again..."