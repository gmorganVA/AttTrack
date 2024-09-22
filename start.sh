#!/bin/bash

extDriveDir='/media/extUSB'

pushd /opt/AttTrack

source .venv/bin/activate
./attTrack.py
exitCode=$?
deactivate

if [ -d "${extDriveDir}" ]; then
  mv AttTrack.log "${extDriveDir}/"
  mv *.xlsx "${extDriveDir}/"
fi

popd

if [ -f "${extDriveDir}/shutdown" ]; then
  sudo shutdown -h now
fi
