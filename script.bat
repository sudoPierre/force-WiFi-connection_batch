@echo off
setlocal

:: create a temporary directory to stock the XML profil
set "temp_file=C:\Users\%USERNAME%\Documents\tmp_%date:~0,2%%date:~3,2%%date:~6,4%%time:~0,2%%time:~3,2%"
set "temp_file=%temp_file: =0%"
mkdir "%temp_file%"

:: Wifi SSID and Password (modify access point with your SSID and password with your password)
set "wifi_ssid=access point"
set "wifi_pass=password"
set "profile_file=%temp_file%\wifi_profile.xml"

:: Create the XML profil
(
    echo ^<?xml version="1.0"^?^>
    echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
    echo     ^<name^>%wifi_ssid%^</name^>
    echo     ^<SSIDConfig^>
    echo         ^<SSID^>
    echo             ^<name^>%wifi_ssid%^</name^>
    echo         ^</SSID^>
    echo     ^</SSIDConfig^>
    echo     ^<connectionType^>ESS^</connectionType^>
    echo     ^<connectionMode^>auto^</connectionMode^>
    echo     ^<MSM^>
    echo         ^<security^>
    echo             ^<authEncryption^>
    echo                 ^<authentication^>WPA2PSK^</authentication^>
    echo                 ^<encryption^>AES^</encryption^>
    echo                 ^<useOneX^>false^</useOneX^>
    echo             ^</authEncryption^>
    echo             ^<sharedKey^>
    echo                 ^<keyType^>passPhrase^</keyType^>
    echo                 ^<protected^>false^</protected^>
    echo                 ^<keyMaterial^>%wifi_pass%^</keyMaterial^>
    echo             ^</sharedKey^>
    echo         ^</security^>
    echo     ^</MSM^>
    echo     ^<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"^>
    echo         ^<enableRandomization^>false^</enableRandomization^>
    echo     ^</MacRandomization^>
    echo ^</WLANProfile^>
) > "%temp_file%\wifi_profile.xml"

:: Check if already connected to that SSID
netsh wlan show interfaces | findstr /i "SSID" | findstr /i "%wifi_ssid%" >nul
if %errorlevel%==0 (
    echo Already connected to %wifi_ssid%.
    goto :end
)

:: Import XML profil
netsh wlan add profile filename="%temp_file%\wifi_profile.xml" >nul
timeout /t 5 >nul

:: WiFi connection attempt
echo Connection attempt to %wifi_ssid%...
netsh wlan connect name="%wifi_ssid%" >nul

:: Waiting 5 seconds for stabilization
timeout /t 5 >nul

:: Check again if already connected to that SSID
netsh wlan show interfaces | findstr /i "SSID" | findstr /i "%wifi_ssid%" >nul
if %errorlevel%==0 (
    echo Successfully connected to %wifi_ssid%.
    goto :end
) else (
    echo Erreur : Unable to connect to %wifi_ssid%.
    echo Verify if %wifi_ssid% is reachable and try again.
    goto :end
)

:end

:: Deleting the XML file and temporary directory
del "%temp_file%\wifi_profile.xml"
rmdir "%temp_file%"
endlocal
timeout /t 3 >nul