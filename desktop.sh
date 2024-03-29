#!/bin/sh
set -e

# constant audio to fix issues when stopping/starting
mkdir -p .config/systemd/user/
cp "./config/fiio-k3-fix.service" "$HOME/.config/systemd/user/"
.config/systemd/user/fiio-k3-fix.service

# syncthing - devices
syncthing cli config devices add --device-id KKYBFUF-45PZX63-5INJFI2-YAWLHGI-D63E3SN-5REEN4C-5UZF2BL-WF5UWAC --name hazel
syncthing cli config devices add --device-id WXUPQ65-XTVKWGV-FRKVLNV-YIS6CRY-BHS5MTL-UDCL3DR-W4QLMV5-35OQCQD --name spruce

# librewolf pwas for firefox
ln -s ~/.mozilla/native-messaging-hosts ~/.librewolf/native-messaging-hosts
sudo ln -s /usr/lib/mozilla/native-messaging-hosts /usr/lib/librewolf/native-messaging-hosts

sh "./nvidia.sh"
