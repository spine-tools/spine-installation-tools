#!/bin/bash
#chmod +x ~/spinetools/upgrade_spinetools.sh

# user settings: install directory, environment names
path_spinetools=$(dirname $0)
path_envs=environments
env_python=penv
# the julia settings need to be adjusted directly in the code (see further below)

# update files from git
cd $path_spinetools
cd SpineInterface.jl
git pull
cd ..
cd SpineOpt.jl
git pull
cd ..
cd Spine-Toolbox
git pull
cd ..

# activate python environment (for Spine Toolbox)
cd $path_envs
python -m venv $env_python
source $env_python/Scripts/activate
cd ..

# alternatively use a conda environment
#path_conda=~/miniconda3/etc/profile.d/conda.sh
#env_conda=cenv_dev
#source $path_conda
#conda activate $env_conda

# install python requirements
cd Spine-Toolbox
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
#python -m pip install -r dev-requirements.txt
cd ..

# activate julia environment (for SpineOpt and SpineInterface)
# update the necessary packages
# reconfigure PyCall
julia -e '
env_julia = joinpath(@__DIR__,"environments","jenv")
path_python = joinpath(@__DIR__,"environments","penv","Scripts","python")
import Pkg
Pkg.activate(env_julia)
Pkg.update()
import PyCall
ENV["PYTHON"] = path_python
Pkg.build("PyCall")
println(PyCall.pyprogramname)
'

# keep shell open for debugging
$SHELL