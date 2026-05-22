::if python is not recognised by the system, you need to add it to the PATH
::this file is specifically for the computers in RTU, you may need to make adjustments for your own system

rem reg add HKCU\Environment /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\Program Files\Python313;C:\Program Files\Python313\Scripts" /f
reg add HKCU\Environment /v PATH /t REG_EXPAND_SZ /d "C:\Program Files\Python313;C:\Program Files\Python313\Scripts;%PATH%" /f


pause