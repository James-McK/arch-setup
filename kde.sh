#!/bin/sh
set -e

pacman -Syu --needed --noconfirm $(cat ./kde-packages)

balooctl suspend
balooctl disable
balooctl purge

plasma-apply-desktoptheme lightly-plasma-git

# KDE theme
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd "./catppuccin-kde"
yes | ./install.sh 2 4 1
ln -s "$HOME/.local/share/icons/" "$HOME/.icons"
cd ..
rm -rf ./catppuccin-kde
# also copy cursors to /usr/share/icons to make sure sddm can use them
sudo cp -r "$HOME/.local/share/icons/Catppuccin-Macchiato-Mauve-Cursors/" "/usr/share/icons/Catppuccin-Macchiato-Mauve-Cursors/"

# folder icons
papirus-folders -C cat-macchiato-mauve

# GTK theme
git clone --recurse-submodules git@github.com:catppuccin/gtk.git catppuccin-gtk && cd "./catppuccin-gtk"
paru -S python-catppuccin
python install.py macchiato -a mauve --tweaks rimless normal -d "$XDG_DATA_HOME/themes" -l
cd ..
rm -rf catppuccin-gtk/
paru -Rs python-catppuccin

# no shadow on bar
sudo cp "./config/kde-no-shadow" "/usr/local/bin/kde-no-shadow"
sudo chmod +x "/usr/local/bin/kde-no-shadow"
mkdir -p "$HOME/.config/autostart/"
cp "./config/kde-no-shadow.desktop" "$HOME/.config/autostart/"

# kdeglobals

## General

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key AllowKDEAppsToRememberWindowPositions "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key Name --key en_GB "Catppuccin Macchiato Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key Name "Catppuccin Macchiato Mauve"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key font "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key fixed "IBM Plex Mono,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key menuFont "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key smallestReadableFont "IBM Plex Sans,8,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key toolBarFont "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key widgetStyle "Lightly"

## Icons

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group Icons --key Theme "Papirus-Dark"

## KDE

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key ColorScheme "Catppuccin-Macchiato-Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key LookAndFeelPackage "Catppuccin-Macchiato-Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key ScrollbarLeftClickNavigatesByPage "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key SingleClick "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key widgetStyle "Lightly"

# kwinrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Desktops --key Number "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Desktops --key Rows "2"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key blurEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key contrastEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key kwin4_effect_dimscreenEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key kwin4_effect_fadedesktopEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key slideEnabled "false"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group TabBox --key LayoutName "thumbnail_grid"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group TabBox --key MinimizedMode "1"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Windows --key DelayFocusInterval "0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Windows --key FocusPolicy "FocusFollowsMouse"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Windows --key NextFocusPrefersMouse "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Windows --key RollOverDesktops "true"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group org.kde.kdecoration2 --key BorderSize "None"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group org.kde.kdecoration2 --key BorderSizeAuto "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group org.kde.kdecoration2 --key library "org.kde.lightly"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group org.kde.kdecoration2 --key theme "Lightly"

## forceblur
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-forceblur --key patterns "yakuake\nurxvt\nkeepassxc\nkitty"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key forceblurEnabled "true"

## bismuth
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key enableFloatingLayout "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key enableMonocleLayout "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key floatingClass "musicbee.exe,steam,systemsettings"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key noTileBorder "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key screenGapBottom "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key screenGapLeft "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key screenGapRight "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key screenGapTop "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-bismuth --key tileLayoutGap "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key bismuthEnabled "true"

# ksplashrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/ksplashrc" --group KSplash --key theme "Catppuccin-Macchiato-Mauve-splash"

# ksmserverrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/ksmserverrc" --group General --key loginMode "emptySession"

# kscreenlockerrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kscreenlockerrc" --group Daemon --key LockGrace "20"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kscreenlockerrc" --group Daemon --key Timeout "20"

# krunnerrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/krunnerrc" --group Plugins --key baloosearchEnabled "false"

# kcminputrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kcminputrc" --group Mouse --key X11LibInputXAccelProfileFlat "true"

# baloofilerc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kcminputrc" --group "Basic Settings" --key Indexing-Enabled "false"

# plasmashellrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/plasmashellrc" --group "PlasmaViews" --group "Panel 2" --key panelOpacity "2"
kwriteconfig5 --file "$XDG_CONFIG_HOME/plasmashellrc" --group "PlasmaViews" --group "Panel 2" --group "Defaults" --key thickness "24"

# kwinrulesrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key Description "No Min Window Size"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key minsize "1,1"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key minsizerule "2"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key types "1"

# lightly config
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key alpha "15"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key corners_type "0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key dark_theme "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key disabled_for_maximized "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key outline "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key roundness "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key shadow_offset "2"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyshaders.conf" --group "General" --key squircle_ratio "12"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key kwin4_effect_lightlyshadersEnabled "true"

# lightlyrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyrc" --group Common --key OutlineCloseButton "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/lightlyrc" --group Windeco --key DrawBackgroundGradient "false"

# kglobalshortcutsrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key _k_friendly_name "Window Tiling"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key increase_master_win_count "Meta+[,Meta+],Increase Master Area Window Count"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key decrease_master_win_count "Meta+P,Meta+[,Decrease Master Area Window Count"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key decrease_window_height "Meta+#,Meta+Ctrl+K,Decrease Window Height"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key decrease_window_width "Meta+;,Meta+Ctrl+H,Decrease Window Width"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key increase_window_height "Meta+],Meta+Ctrl+J,Increase Window Height"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key increase_window_width "Meta+',Meta+Ctrl+L,Increase Window Width"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key next_layout "Meta+\\\\,Meta+\\\\,Switch to the Next Layout"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key prev_layout "Meta+|,Meta+|,Switch to the Previous Layout"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group bismuth --key toggle_window_floating "Meta+F,Meta+F,Toggle Active Window Floating"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Switch One Desktop Down" "Meta+Ctrl+Down,Meta+Ctrl+Down,Switch One Desktop Down"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Switch One Desktop Up" "Meta+Ctrl+Up,Meta+Ctrl+Up,Switch One Desktop Up"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Switch One Desktop to the Left" "Meta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Switch One Desktop to the Right" "Meta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Window One Desktop Down" "Meta+Ctrl+Shift+Down,Meta+Ctrl+Shift+Down,Window One Desktop Down"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Window One Desktop Up" "Meta+Ctrl+Shift+Up,Meta+Ctrl+Shift+Up,Window One Desktop Up"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Window One Desktop to the Left" "Meta+Ctrl+Shift+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group kwin --key "Window One Desktop to the Right" "Meta+Ctrl+Shift+Right,Meta+Ctrl+Shift+Right,Window One Desktop to the Right"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kglobalshortcutsrc" --group "org.kde.dolphin.desktop" --key _launch "Meta+D,Meta+D,Dolphin"

sudo cp "./config/sddm_kde_settings.conf" "/etc/sddm.conf.d/kde_settings.conf"
systemctl enable sddm.service
