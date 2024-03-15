# Set Execution Policy and Security Protocol
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Configure WinRM
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
winrm set winrm/config @{MaxEnvelopeSizekb="8000"}

# Configure Firewall for WinRM
netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow

# Placeholder for Administrator Password Setup
# $adminPassword = "YourAdminPassword"
# Consider security implications and the container context

# Placeholder for User Creation and Role Assignment
# $userName = "YourUserName"
# $userPassword = "YourUserPassword"
# Consider the containerized environment limitations

# Download and Execute the UiPath Robot Installation Script
$temp = "C:\scripts"
$link = "https://raw.githubusercontent.com/UiPath/Infrastructure/master/Setup/Install-UiRobot.ps1"
$file = "Install-UiRobot.ps1"
New-Item -Path $temp -ItemType directory
Set-Location -Path $temp
Invoke-WebRequest -Uri $link -OutFile $file
# Modify below command as per your actual parameters
& "C:\scripts\Install-UiRobot.ps1" -orchestratorUrl "YourOrchestratorUrl" -Tennant "YourTenant" -orchAdmin "YourOrchAdmin" -orchPassword "YourOrchPassword" -adminUsername "YourAdminUsername" -machinePassword "YourMachinePassword" -machineName "YourMachineName" -HostingType "Standard" -RobotType "YourRobotType" -credType "Default"
Remove-Item -LiteralPath "C:\scripts" -Force -Recurse
