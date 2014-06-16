#!/bin/sh

################################
# The file just invokes a pull
# and starts sync.sh after that
#################################

git pull
sh sync.sh
