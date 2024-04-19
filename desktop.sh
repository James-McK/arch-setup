#!/bin/sh
set -e

# constant audio to fix issues when stopping/starting
mkdir -p "$HOME/.config/systemd/user/"
cp "./config/fiio-k3-fix.service" "$HOME/.config/systemd/user/"
systemctl --user enable --now fiio-k3-fix

# syncthing - devices
syncthing cli config devices add --device-id FPVUK6F-OIHAEEV-L3API4Q-WSLAPXF-H3RH32R-AOD2FTX-QPYEAJH-NDE7XAG --name mangrove
syncthing cli config devices add --device-id TFQC2KT-JLA5V6L-F3YTIJQ-7JTWQFQ-YTELKEA-DV6WYVB-TNXH2CZ-ODIQXAJ --name cherry-win
syncthing cli config devices add --device-id C4TOZTS-MEC5ICV-LHF7UCZ-JT57ORG-OF66H4X-XGGC7UA-TEVIFVR-GRLXRAS --name cherry