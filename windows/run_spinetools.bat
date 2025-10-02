:: user settings: environment directory, environment names
set path_spinetools=%~dp0
set env_python=%path_spinetools%environments\penv

:: open python environment
:: the option /d changes the drive at the same time
cd /d %env_python%
call .\Scripts\activate.bat

:: open spine toolbox
spinetoolbox

:: keep cmd open for debugging
cmd /k