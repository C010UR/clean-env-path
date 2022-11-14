param (
    [Parameter(Position = 0)][string]$target
)

$env_target = [System.EnvironmentVariableTarget]::User

if ($target -eq 'machine') {
    $env_target = [System.EnvironmentVariableTarget]::Machine
} elseif ($target -eq 'process') {
    $env_target = [System.EnvironmentVariableTarget]::Process
}

$path = [Environment]::GetEnvironmentVariable("Path", $env_target).Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
$normal = @()
$duplicates = @()
$nonexistent = @()
 
foreach ($value in $path)
{
    if ($normal -notcontains $value)
    {
        if (Test-Path $value) {
            $normal += $value
        } else {
            $nonexistent += $value
        }
    }
    else
    {
        $duplicates += $value
    }
}
 
if ($duplicates -Or $nonexistent)
{
    [array]::sort($normal)
    [array]::sort($duplicates)
    [array]::sort($nonexistent)
    Write-Host "`e[32m:: New PATH entries:`e[0m"
    foreach ($value in $normal) {
        Write-Host "`e[32m+ $value`e[0m"
    }
    Write-Host "`e[31m:: Removed duplicates:`e[0m"
    foreach ($value in $duplicates) {
        Write-Host "`e[31m- $value`e[0m"
    }
    Write-Host "`e[33m:: Removed entries with wrong path:`e[0m"
    foreach ($value in $nonexistent) {
        Write-Host "`e[33m- $value`e[0m"
    }

    [Environment]::SetEnvironmentVariable("Path", $normal -join ';', $env_target)
}
else
{
    Write-Host "`e[32mNo Duplicate PATH entries found. The PATH will remain the same.`e[0m"
}
