@echo off
setlocal enabledelayedexpansion

echo Preparing environment for Jenkins deployment...

:: Define SSH keys directory
set JENKINS_AGENT_KEYS_DIR=jenkins_agent_keys

:: Create SSH keys directory
echo Creating SSH keys directory for Jenkins Agent...
if not exist "%JENKINS_AGENT_KEYS_DIR%" (
    mkdir "%JENKINS_AGENT_KEYS_DIR%"
)

:: Generate SSH keys for Jenkins Agent
if not exist "%JENKINS_AGENT_KEYS_DIR%\id_rsa" (
    echo Generating SSH keys for Jenkins Agent...
    ssh-keygen -t rsa -b 4096 -f "%JENKINS_AGENT_KEYS_DIR%\id_rsa" -N ""
) else (
    echo SSH keys already exist. Skipping key generation.
)

:: Copy public key to authorized_keys
echo Configuring authorized_keys for Jenkins Agent...
copy /Y "%JENKINS_AGENT_KEYS_DIR%\id_rsa.pub" "%JENKINS_AGENT_KEYS_DIR%\authorized_keys" >nul

:: Set permissions (Windows style)
echo Setting permissions...
icacls "%JENKINS_AGENT_KEYS_DIR%\id_rsa" /inheritance:r /grant:r "%USERNAME%:R"
icacls "%JENKINS_AGENT_KEYS_DIR%\id_rsa.pub" /inheritance:r /grant:r "%USERNAME%:R"
icacls "%JENKINS_AGENT_KEYS_DIR%\authorized_keys" /inheritance:r /grant:r "%USERNAME%:R"

echo.
echo Environment setup is complete!
echo You can now run "docker-compose up -d" to start Jenkins.

endlocal
pause
