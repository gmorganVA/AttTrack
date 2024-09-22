# AttTrack

Attendance tracking from scanning QR code on Trail Life badges using a USB attached reader attached to a Raspberry Pi or similar computer running Linux.  Logs and spreadsheet are copied to a USB flash drive after a shutdown QR code is scanned.  Use [TLCAttendance](https://github.com/gmorganVA/TLCAttendance) to update [Trail Life Connect](https://www.traillifeconnect.com/).

## Notes
- Currently uses a LED attached to GPIO 27 to indicate status.  Looking to connect a small, low power display to show more use friendly status.
- Using [Sonew Hands-free QR Barcode Scanner Wired Omnidirectional Automatic Barcode Reader](https://a.co/d/9T77YGB)
- Add an empty file named "shutdown" to your flash drive to enable auto shutdown when special QR code is scanned
- Special shutdown QR code in [Shutdown QR Code](948NinjaDown.pdf) ;-)

## Setup on Linux

- Install autofs ```sudo apt install autofs```
- Set up automatic mouting of USB flash drive
  - From: https://linuxconfig.org/automatically-mount-usb-external-drive-with-autofs
  - Put this in /etc/auto.master.d/ext.autofs:
  ```shell
  # Mount external USB drive
  /media/	/etc/auto.ext-usb --timeout=10,defaults,user,exec,uid=1000
  ```
  - Put this in /etc/auto.ext-usb:
  ```shell
  extUSB		-fstype=auto		:/dev/sda1
  ```
  - Restart autofs: ```sudo systemctl restart autofs```
- Set up AttTrack as a service
  - Create file /lib/systemd/system/attTrack.service with content:
  ```shell
  [Unit]
  Description=AttTrack
  After=multi-user.target

  [Service]
  Type=idle
  ExecStart=/opt/AttTrack/start.sh

  [Install]
  WantedBy=multi-user.target
  ```
  - Set up ownership: ```sudo chmod 644 /lib/systemd/system/attTrack.service```
  - Enable service: ```sudo systemctl enable attTrack.service```
- Copy code from this repo to third party apps directory: ```/opt/AttTrack```
- Set up code
```shell
pushd /opt/AttTrack
chmod +x start.sh
chmod +x attTrack.py
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
deactivate
```
