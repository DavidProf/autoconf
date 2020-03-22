#!/bin/bash

cd ~/ ;

# preparing
echo '\nAdding apt repositories' ;

add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" ;
add-apt-repository -y ppa:webupd8team/haguichi ;
add-apt-repository ppa:inkscape.dev/stable -y ;
add-apt-repository ppa:lutris-team/lutris -y ;

echo '\nconfig wine requirements' ;

dpkg --add-architecture i386 ;
wget -nc https://dl.winehq.org/wine-builds/winehq.key ;
apt-key add winehq.key ;
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' ;

echo '\nupdating apt' ;

apt update ;

apt install unzip &&

unzip bag.zip ;

# install
echo '\n\n\nterminator install' ;

apt install terminator ;

echo '\n\n\nnet-tools install' ;

apt install net-tools ;

echo '\n\n\nhtop install' ;

apt install htop ;

echo '\n\n\node && npm && yarn install' ;

apt install nodejs -y && 
apt install npm -y &&
npm i -g npm@latest &&
npm i -g n &&
n stable &&
npm i -g yarn@latest ;

echo '\n\n\ndocker install' ;

apt install docker.io -y;
systemctl start docker ;
systemctl enable docker ;
apt install docker-compose -y;

groupadd docker ;
usermode -aG docker $USER ;

echo '\n\n\nkazam install' ;

apt install kazam -y ;

echo '\n\n\naudacity install' ;

apt install audacity -y ;

echo '\n\n\ninkscape install' ;

apt install inkscape -y ;

echo '\n\n\ngimp install' ;

apt install gimp -y ;

echo '\n\n\nkdenlive install' ;

apt install kdenlive -y ;

echo '\n\n\nvirtualbox-qt install' ;

apt install virtualbox-qt -y ;

echo '\n\n\nsteam-installer install' ;

apt install steam-installer -y ;

echo '\n\n\nbijiben install' ;

apt install bijiben -y ;

echo '\n\n\nobs-studio install' ;

apt install obs-studio -y ;

echo '\n\n\nflash player install' ;

apt install adobe-flashplugin browser-plugin-freshplayer-pepperflash ;

echo '\n\n\nexpo-cli install' ;

npm i -g expo-cli ;

echo '\n\n\ncode install' ;

apt install ./dev/code.deb -y ;

echo '\n\n\nchrome install' ;

apt install ./dev/chrome.deb -y ;

echo '\n\n\nhamachi install' ;

apt install ./deb/hamachi -y && apt install haguichi -y ;

echo '\n\n\nminecraft install' ;

apt install ./dev/minecraft.deb -y ;

echo '\n\n\nwine install' ;

apt install -y --install-recommends winehq-stable ;

echo '\n\n\nlutris install' ;

apt install lutris -y;

echo '\n\n\nclipgrab install' ;

chmod +x ./clipgrab/clipgrab.AppImage ;
cp -r ./clipgrab /opt/ ;

cp ./clipgrab/clipgrab.desktop ~/.local/share/applications/ ;

# extra config

echo '\n\n\nSetting favorites on taskbar'
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', 'chromium_chromium.desktop', 'org.gnome.Nautilus.desktop', 'rhythmbox.desktop', 'org.gnome.Software.desktop']"

echo '\n\n\nEnable seconds on clock'
gsettings set org.gnome.desktop.interface clock-show-seconds true
# set gnome shell theme
## theme
echo '\n\n\nSetting theme' ;
mkdir -p /usr/share/themes ;
cp -r ./appearance/themes/bluesky_dark /usr/share/themes/ ;
gsettings set org.gnome.desktop.interface gtk-theme 'bluesky_dark' ;
gsettings set org.gnome.desktop.wm.preferences theme 'bluesky_dark' ;

## icons
echo '\n\n\nSetting icons' ;
mkdir -p /usr/share/icons ;
cp -r ./appearance/icons/blue_icons /usr/share/icons/ ;
gsettings set org.gnome.desktop.interface icon-theme 'blue_icons' ;

## cursors
echo '\n\n\nSetting cursors' ;
cp -r ./appearance/cursors/vimix_cursors /usr/share/icons/ ;
gsettings set  org.gnome.desktop.interface cursor-theme 'vimix_cursors' ;

# add gnome shell plugins
echo '\n\n\ninstalling gnome shell exetensions'
cp -r ./gnome-shell-extensions/* ~/.local/share/gnome-shell/extensions/

## dash to dock
echo '\n\n\nextension dash to dock' ;
gnome-extensions enable dash-to-dock@micxgx.gmail.com ;
dconf load /org/gnome/shell/extensions/dash-to-dock/ < ./gnome-shell-extensions-conf/dash-to-dock.backup ;

## sound-output-device-chooser
echo '\n\n\nextension dash to dock' ;
gnome-extensions enable sound-output-device-chooser@kgshank.net ;

# git
echo '\n\n\ngit config' ;
## git aliases
echo '\n\n\nadding git aliases' ;
git config --global alias.s 'status -sb' ;
git config --global alias.c 'commit' ;
git config --global alias.amend 'commit --amend' ;
git config --global alias.ck 'checkout' ;
git config --global alias.b 'branch' ;
git config --global alias.l 'log --pretty="format:%Cgreen%ci %Cred%h %Cblue%an %C(green)[%C(magenta)%ae%C(green)] -> %C(white)%s"' ;
git config --global alias.lg 'log --pretty="format:%Cgreen%cI %C(white)%cr%n -> %Cred%h%n -> %Cblue%an %C(green)[%C(magenta)%ae%C(green)]%n -> %C(white)%s%n    %b"'

# install zsh
echo '\n\n\ninstalling zsh'
apt install zsh -y;
chsh -s $(which zsh) ;
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ;

# change file and executing pulseaudio -k && alsa force-reload
echo '\n\n\nnoise removing'
echo '### USER CHANGES' >> /etc/pulse/default.pa ;
echo '# echo cancel' >> /etc/pulse/default.pa ;
echo 'load-module module-echo-cancel' >> /etc/pulse/default.pa ;
pulseaudio -k && alsa force-reload ;

echo 'run "pulseaudio -k && alsa force-reload" to enable noise supress' ;

echo '\n\n\n***\n\n\n*finished*\n\n\n***\nmaybe you should restart'