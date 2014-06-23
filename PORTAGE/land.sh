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
rm -r /etc/portage/env/nyx/*
rm -r /etc/portage/sets/*

rsync -aPh portage/ /etc/portage/

chown -R root:portage /etc/portage
chmod -R 750 /etc/portage

mkdir /var/lib/portage/NYXBACKUP
cp /var/lib/portage/world /var/lib/portage/NYXBACKUP/
cp /var/lib/portage/world_sets /var/lib/portage/NYXBACKUP/
> /var/lib/portage/world
> /var/lib/portage/world_sets

chown root:portage /var/lib/portage/world
chmod 640 /var/lib/portage/world

mirrorselect -s5

layman -f -o https://git.cosmofox.net/nyxOverlay/plain/repository.xml -a nyxOverlay
layman -f -o https://raw.github.com/fr0stycl34r/gentoo-overlay-tox/master/repository.xml -a tox-overlay
layman -S
emerge-webrsync
