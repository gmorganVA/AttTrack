# Install autofs
sudo apt install autofs

# Set up automatic mouting of USB flash drive
# From: https://linuxconfig.org/automatically-mount-usb-external-drive-with-autofs

## Put this in /etc/auto.master.d/ext.autofs:
# Mount external USB drive
/media/	/etc/auto.ext-usb --timeout=10,defaults,user,exec,uid=1000

## Put this in /etc/auto.ext-usb:
extUSB		-fstype=auto		:/dev/sda1

## Restart autofs
sudo systemctl restart autofs

# Set up AttTrack as a service
## Create file /lib/systemd/system/attTrack.service with content:
[Unit]
Description=AttTrack
After=multi-user.target

[Service]
Type=idle
ExecStart=/opt/AttTrack/start.sh

[Install]
WantedBy=multi-user.target

## Set up ownership
sudo chmod 644 /lib/systemd/system/attTrack.service

## Enable service
sudo systemctl enable attTrack.service
