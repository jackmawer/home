#!/bin/sh
git clone https://github.com/jackmawer/home.git tmp/
cd tmp/
cp -rb . ~
cd ..
rm -rf tmp/
