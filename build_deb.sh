#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo $SCRIPT_DIR
mkdir -p omnitech_cfg_3.6.0-1.0_arm64/opt/dsf/tech_config && cd omnitech_cfg_3.6.0-1.0_arm64/opt/dsf/tech_config
#pyinstaller $SCRIPT_DIR/../src/middleware_omnode.py --onedir -y
#cp -r dist/middleware_omnode/* .
#rm -r build dist middleware_omnode.spec

cp -r $SCRIPT_DIR/src/* .
cd $SCRIPT_DIR
#mkdir -p lib/systemd/system
#cp ../rfid_middleware.service lib/systemd/system/

#mkdir -p home/pro/.cache/rfid
#touch home/pro/.cache/rfid/filaments.db

cd omnitech_cfg_3.6.0-1.0_arm64
DIR_NAME=$(basename $PWD)
echo $DIR_NAME
cd ..

dpkg-deb --build --root-owner-group $DIR_NAME 

cd $SCRIPT_DIR
rm -r omnitech_cfg_3.6.0-1.0_arm64/opt
