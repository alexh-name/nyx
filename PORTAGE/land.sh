#!/bin/sh

################################
# Files that will be overridden:
#	- bashrc
#	- make.conf
#	- patches/...
#	- savedconfig/...
#	- sets/...
#
# The script will create a backup-folder 'NYXBACKUP' of the originals.
# It is due to the design of portage that I cannot put those files in distinct
# folders to prevent overriding.
#################################

mkdir /etc/portage/NYXBACKUP
cp -r /etc/portage/{bashrc,make.conf,patches,savedconfig,sets} /etc/portage/NYXBACKUP

rm -r /etc/portage/package.*/nyx/*

rsync -aPh portage/ /etc/portage/

chown -R root:portage /etc/portage
chmod -R 740 /etc/portage

mirrorselect -s5