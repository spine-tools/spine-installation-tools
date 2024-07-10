#!/bin/bash
#chmod +x ~/spinetools/install_spinetools.sh
# check whether python, git and julia are installed; python3 may be needed to changed to python depending on your system
python3 --version
git --version
julia --version

# user settings: install directory, environment names
path_spinetools=$(dirname $0)
path_envs=environments
env_python=penv
# the julia settings need to be adjusted directly in the code (see further below)

# download files from git
cd $path_spinetools
git clone https://github.com/spine-tools/Spine-Toolbox.git
git clone https://github.com/spine-tools/SpineInterface.jl.git
git clone https://github.com/spine-tools/SpineOpt.jl.git

# branch
#cd SpineInterface.jl
#git fetch
#git checkout -b 0.8-dev origin/0.8-dev
#cd ..
#cd SpineOpt.jl
#git fetch
#git checkout tags/v0.8.1 -b v081
#cd ..
#cd Spine-Toolbox
#git fetch
#git checkout tags/0.7.4 -b v074
#cd ..

# create python environment (for spine toolbox)
mkdir $path_envs
cd $path_envs
python3 -m venv $env_python
source $env_python/bin/activate
which python
cd ..

# alternatively use a conda environment
#path_conda=~/miniconda3/etc/profile.d/conda.sh
#env_conda=cenv_dev
#source $path_conda
#conda create --name $env_conda python=3.9 -y
#conda activate $env_conda

# install python requirements
cd Spine-Toolbox
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
#python3 -m pip install -r dev-requirements.txt
cd ..

# install SpineInterface
cd SpineInterface.jl
julia -e '
env_julia = joinpath(dirname(@__DIR__),"environments","jenv")
path_spineinterface = joinpath(@__DIR__)
import Pkg
Pkg.activate(env_julia)
Pkg.instantiate()
Pkg.develop(path=path_spineinterface)
'
cd ..

# install SpineOpt
cd SpineOpt.jl
julia -e '
env_julia = joinpath(dirname(@__DIR__),"environments","jenv")
path_spineopt = joinpath(@__DIR__)
import Pkg
Pkg.activate(env_julia)
Pkg.instantiate()
Pkg.develop(path=path_spineopt)
'
cd ..

# Configure PyCall
julia -e '
env_julia = joinpath(@__DIR__,"environments","jenv")
path_python = joinpath(@__DIR__,"environments","penv","bin","python3")
import Pkg
Pkg.activate(env_julia)
import PyCall
ENV["PYTHON"] = path_python
Pkg.build("PyCall")
println(PyCall.pyprogramname)
'

# manually add julia environment to settings in spine toolbox
spinetoolbox

# install spineopt plugins as well

# alternatively keep shell open for debugging
$SHELL