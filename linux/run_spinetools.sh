#!/bin/bash
#chmod +x ~/spinetools/run_spinetools.sh
#to run this file on Windows with 'Git for Windows', replace python3 by python and bin by Scripts

#user settings: environment directory, environment names
path_spinetools=$(dirname $0)
env_python=environments/penv
#julia settings in julia code below

# open spine toolbox
cd $path_spinetools
source $env_python/bin/activate
spinetoolbox

#keep shell open for debugging
#$SHELL