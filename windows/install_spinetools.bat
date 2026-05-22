REM Install Spine Toolbox in Python (penv) and SpineOpt in Julia (jenv)

mkdir environments
cd environments

python -m venv penv
call penv\Scripts\activate
python.exe -m pip install --upgrade pip
pip install spinetoolbox

julia -e "using Pkg; Pkg.activate(\"jenv\"); Pkg.add(\"SpineOpt\"); using SpineOpt"


REM Create Spine Toolbox launch script

cd ..

(
echo cd "environments"
echo call penv\Scripts\activate
echo spinetoolbox
) > run_spinetools.bat

pause
