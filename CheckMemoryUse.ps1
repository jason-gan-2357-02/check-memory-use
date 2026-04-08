$ComputerName = $env:COMPUTERNAME

Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host "Computer Name: $ComputerName" -ForegroundColor Cyan
Write-Host "Process List (Top 10)" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan

$ProcessList = Get-Process | Select-Object Name, @{Name="MemMb"; Expression={[Math]::Round($_.WorkingSet / 1MB, 2)}} | Sort-Object MemMb -Descending | Select-Object -First 10

foreach ($Process in $ProcessList) {
    $Name = $Process.Name
	$Mem = $Process.MemMb
    Write-Host "$Name is using $Mem MB" -ForegroundColor Green
}

$FinalOutput = [PSCustomObject]@{
    ComputerName = $ComputerName
    ProcessList    = $ProcessList
}

$FinalOutput | ConvertTo-Json -Depth 2 | Out-File "MemoryUse.json"

Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host "Report saved to MemoryUse.json" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan
