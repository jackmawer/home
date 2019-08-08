#!/bin/sh
git clone git@github.com:jackmawer/home.git tmp/
cd tmp/
cp -rb . ~
cd ..
rm -rf tmp/