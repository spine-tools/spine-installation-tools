#!/bin/bash
#chmod +x ~/spinetools/switch_spinetools.sh
#to run this file on Windows with 'Git for Windows', replace python3 by python and bin by Scripts

# user settings: install directory, environment names
path_spinetools=$(dirname $0)
path_envs=environments
env_python=penv
# the julia settings need to be adjusted directly in the code (see further below)

#cd $path_spinetools
# switch branches (not necessary if you use different folders for each of your installations)
#cd SpineInterface.jl
#git fetch
#git checkout -b 0.8-dev origin/0.8-dev
#cd ..
#cd SpineOpt.jl
#git fetch
#git checkout -b 0.8-dev origin/0.8-dev
#cd ..
#cd Spine-Toolbox
#git fetch
#git checkout -b 0.8-dev origin/0.8-dev
#cd ..

# reconfigure PyCall
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

# keep shell open for debugging
#$SHELL