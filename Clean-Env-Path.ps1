param (
    [Parameter(Position = 0)][string]$target
)

$env_target = [System.EnvironmentVariableTarget]::User

if ($target -eq 'machine') {
    $env_target = [System.EnvironmentVariableTarget]::Machine
}
elseif ($target -eq 'process') {
    $env_target = [System.EnvironmentVariableTarget]::Process
}

$path = [Environment]::GetEnvironmentVariable("Path", $env_target).Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
$normal = @()
$duplicates = @()
$nonexistent = @()
 
foreach ($value in $path) {
    if ($normal -notcontains $value.TrimEnd('\')) {
        if ((Test-Path $value) -and (Test-Path "$value\*")) {
            $normal += $value.TrimEnd('\')
        }
        else {
            $nonexistent += $value
        }
    }
    else {
        $duplicates += $value
    }
}

[array]::sort($normal)
Write-Host "`e[32m:: PATH entries:`e[0m"
foreach ($value in $normal) {
    Write-Host "`e[32m+`e[0m $value"
}
if ($duplicates) {
    [array]::sort($duplicates)
    Write-Host "`e[31m:: Removed duplicates:`e[0m"
    foreach ($value in $duplicates) {
        Write-Host "`e[31m-`e[0m $value"
    }
}
if ($nonexistent) {
    [array]::sort($nonexistent)
    Write-Host "`e[33m:: Removed entries with nonexistent path:`e[0m"
    foreach ($value in $nonexistent) {
        Write-Host "`e[33m-`e[0m $value"
    }
}

[Environment]::SetEnvironmentVariable("Path", $normal -join ';', $env_target)