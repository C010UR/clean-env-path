# Clean-Env-Path

This script removes all duplicates and entries with wrong path or emty folders from the `PATH` environment variable.

![preview](https://user-images.githubusercontent.com/95462776/201716052-acb5bed2-6a50-4ee4-9d42-6943458a2f83.png)

Parameter `-target <target>` sets the environment target. This parameter accepts next options:

- `user` _(Default option)_
- `machine`
- `process`

## Usage

You can execute the script without downloading it _(though internet access for the powershell is required)_ using the commands below: 

#### Clean `PATH` for the user
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Command -ScriptBlock ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/C010UR/clean-env-path/main/Clean-Env-Path.ps1'))) -ArgumentList "user"
```

#### Clean `PATH` for the machine
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Command -ScriptBlock ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/C010UR/clean-env-path/main/Clean-Env-Path.ps1'))) -ArgumentList "machine"
```

#### Clean `PATH` for the process
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Command -ScriptBlock ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/C010UR/clean-env-path/main/Clean-Env-Path.ps1'))) -ArgumentList "process"
```

Or you can just use the command after downloading it

```powershell
.\Clean-Env-Path.ps1 -target machine # clean PATH in the 'machine' environment
```
