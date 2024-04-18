#!/bin/sh
set -e

source "$HOME/.config/environment.d/env-vars.conf"

paru -Syu --needed --noconfirm $(cat ./kde-packages)

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

# sudo hardcode-tray -a

# kdeglobals

## General

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key AllowKDEAppsToRememberWindowPositions "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key Name "Catppuccin Macchiato Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key Name --key en_GB "Catppuccin Macchiato Mauve"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key font "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key fixed "IBM Plex Mono,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key menuFont "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key smallestReadableFont "IBM Plex Sans,8,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key toolBarFont "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group WM --key activeFont "IBM Plex Sans,10,-1,5,50,0,0,0,0,0"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group General --key widgetStyle "Lightly"

## Icons

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group Icons --key Theme "Papirus-Dark" # TODO why was this not applied?

## KDE

kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key ColorScheme "Catppuccin-Macchiato-Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key LookAndFeelPackage "Catppuccin-Macchiato-Mauve"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key ScrollbarLeftClickNavigatesByPage "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key SingleClick "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kdeglobals" --group KDE --key widgetStyle "Lightly"

# kwinrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Desktops --key Number "8"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Desktops --key Rows "2"

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key blurEnabled "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key lightlyshaders_blurEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key contrastEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key slideEnabled "false"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key fadedesktopEnabled "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Plugins --key poloniumEnabled "true"

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

kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group NightColor --key Active "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group NightColor --key LatitudeFixed "53.56275303643725"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group NightColor --key LongitudeFixed "-7.888446215139425"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group NightColor --key Mode "Location"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group NightColor --key NightTemperature "4200"


kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-polonium --key FilterProcess "krunner, yakuake, kded, polkit, plasmashell, bitwarden, musicbee.exe, systemsettings"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrc" --group Script-polonium --key TimerDelay "4"

# ksplashrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/ksplashrc" --group KSplash --key Theme "Catppuccin-Macchiato-Mauve-splash"

# ksmserverrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/ksmserverrc" --group General --key loginMode "emptySession"

# kscreenlockerrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kscreenlockerrc" --group Daemon --key LockGrace "20"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kscreenlockerrc" --group Daemon --key Timeout "20"

# krunnerrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/krunnerrc" --group Plugins --key baloosearchEnabled "false"

# kcminputrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kcminputrc" --group Mouse --key X11LibInputXAccelProfileFlat "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kcminputrc" --group Mouse --key cursorTheme "Catppuccin-Macchiato-Mauve-Cursors"

# baloofilerc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kcminputrc" --group "Basic Settings" --key Indexing-Enabled "false"

# kwinrulesrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key Description "No Min Window Size"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key minsize "1,1"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key minsizerule "2"
kwriteconfig5 --file "$XDG_CONFIG_HOME/kwinrulesrc" --group "1" --key types "1"

# dolphinrc
kwriteconfig5 --file "$XDG_CONFIG_HOME/dolphinrc" --group General --key ShowFullPath "true"
kwriteconfig5 --file "$XDG_CONFIG_HOME/dolphinrc" --group DetailsMode --key PreviewSize "22"

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

# plasma-org.kde.plasma.desktop-appletsrc


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

sudo mkdir -p "/etc/sddm.conf.d/"
sudo cp "./config/sddm_kde_settings.conf" "/etc/sddm.conf.d/kde_settings.conf"
systemctl enable sddm.service
