#!/bin/sh

################################
# Files that will be overridden:
#	- bashrc
#	- patches/...
#	- savedconfig/...
#	- sets/...
#
# It is due to the design of portage that I cannot put those files in distinct
# folders to prevent overriding.
#################################

rm -r /etc/portage/package.*/nyx/*

rsync -aPh portage/ /etc/portage/
