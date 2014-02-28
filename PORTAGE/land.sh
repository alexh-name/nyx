#!/bin/sh

rm -r /etc/portage/package.*/nyx/*

rsync -aPh portage/ /etc/portage/
