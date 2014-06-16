#!/bin/sh

################################
# This script put the freshly 
# pulled configs and tools
# in place and starts an
# update routine with portage.
#################################

mkdir /etc/portage/NYXupdateBACKUP
cp -r /etc/portage/{bashrc,make.conf,patches,savedconfig,sets} /etc/portage/NYXupdateBACKUP

rm -r /etc/portage/package.*/nyx/*
rm -r /etc/portage/env/nyx/*

rsync -aPh portage/ /etc/portage/

chown -R root:portage /etc/portage
chmod -R 750 /etc/portage

mkdir /var/lib/portage/NYXupdateBACKUP
mv /var/lib/portage/world /var/lib/portage/NYXupdateBACKUP/
cp world /var/lib/portage/

chown root:portage /var/lib/portage/world
chmod 640 /var/lib/portage/world

mirrorselect -s5

layman -S
emerge-webrsync \
&& eix-update

(emerge -uK sys-apps/portage \
&&  emerge --quiet-build --keep-going --with-bdeps=y -uDNK $@ @world @system \
&&  dispatch-conf \
&&  env-update && source /etc/profile) \
&& (emerge --depclean \
&&  (emerge --quiet-build --keep-going -avK @preserved-rebuild && revdep-rebuild -ip) \
&&  env-update && source /etc/profile) \
&& (eclean distfiles \
;   emaint --check world \
;   glsa-check -t all \
;   makewhatis -u)
