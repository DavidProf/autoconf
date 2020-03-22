#!/bin/bash

# preparing
printf '\nAdding apt repositories\n' ;

add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" ;
add-apt-repository -y ppa:webupd8team/haguichi ;
add-apt-repository ppa:inkscape.dev/stable -y ;
add-apt-repository ppa:lutris-team/lutris -y ;

printf '\nconfig wine requirements\n' ;

dpkg --add-architecture i386 ;
wget -nc https://dl.winehq.org/wine-builds/winehq.key ;
apt-key add winehq.key ;
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main\n' ;

printf '\nupdating apt\n' ;

apt update ;

apt install unzip -y &&

unzip bag.zip ;

# install
printf '\n\n\nterminator install\n' ;

apt install terminator -y ;

printf '\n\n\nnet-tools install\n' ;

apt install net-tools -y ;

printf '\n\n\nhtop install\n' ;

apt install htop -y ;

printf '\n\n\nnode && npm && yarn install\n' ;

apt install nodejs -y && 
apt install npm -y &&
npm i -g npm@latest &&
npm i -g n &&
n stable &&
npm i -g yarn@latest ;

printf '\n\n\nvlc media player install\n' ;

snap install vlc ;

printf '\n\n\nrhythmbox install\n' ;

apt install rhythmbox -y ;

printf '\n\n\ndocker install\n' ;

apt install docker.io -y;
systemctl start docker ;
systemctl enable docker ;
apt install docker-compose -y;

groupadd docker ;
usermod -aG docker $USER ;

printf '\n\n\nkazam install\n' ;

apt install kazam -y ;

printf '\n\n\naudacity install\n' ;

apt install audacity -y ;

printf '\n\n\ninkscape install\n' ;

apt install inkscape -y ;

printf '\n\n\ngimp install\n' ;

apt install gimp -y ;

printf '\n\n\nkdenlive install\n' ;

apt install kdenlive -y ;

printf '\n\n\nvirtualbox-qt install\n' ;

apt install virtualbox-qt -y ;

printf '\n\n\nsteam-installer install\n' ;

apt install steam-installer -y ;

printf '\n\n\nbijiben install\n' ;

apt install bijiben -y ;

printf '\n\n\nobs-studio install\n' ;

apt install obs-studio -y ;

printf '\n\n\nflash player install\n' ;

apt install adobe-flashplugin browser-plugin-freshplayer-pepperflash -y ;

printf '\n\n\nexpo-cli install\n' ;

npm i -g expo-cli ;

printf '\n\n\ncode install\n' ;

apt install ./dev/code.deb -y ;

printf '\n\n\nchrome install\n' ;

apt install ./dev/chrome.deb -y ;

printf '\n\n\nhamachi install\n' ;

apt install ./deb/hamachi -y && apt install haguichi -y ;

printf '\n\n\nminecraft install\n' ;

apt install ./dev/minecraft.deb -y ;

printf '\n\n\nwine install\n' ;

apt install -y --install-recommends winehq-stable ;

printf '\n\n\nlutris install\n' ;

apt install lutris -y;

printf '\n\n\nclipgrab install\n' ;

chmod +x ./clipgrab/clipgrab.AppImage ;
cp -r ./clipgrab /opt/ ;

cp ./clipgrab/clipgrab.desktop ~/.local/share/applications/ ;

# extra config

printf '\n\n\nSetting favorites on taskbar'
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', 'chromium_chromium.desktop', 'org.gnome.Nautilus.desktop', 'rhythmbox.desktop', 'org.gnome.Software.desktop']"

printf '\n\n\nEnable seconds on clock'
gsettings set org.gnome.desktop.interface clock-show-seconds true
# set gnome shell theme
## theme
printf '\n\n\nSetting theme\n' ;
mkdir -p /usr/share/themes ;
cp -r ./appearance/themes/bluesky_dark /usr/share/themes/ ;
gsettings set org.gnome.desktop.interface gtk-theme 'bluesky_dark' ;
gsettings set org.gnome.desktop.wm.preferences theme 'bluesky_dark' ;

## icons
printf '\n\n\nSetting icons\n' ;
mkdir -p /usr/share/icons ;
cp -r ./appearance/icons/blue_icons /usr/share/icons/ ;
gsettings set org.gnome.desktop.interface icon-theme 'blue_icons' ;

## cursors
printf '\n\n\nSetting cursors\n' ;
cp -r ./appearance/cursors/vimix_cursors /usr/share/icons/ ;
gsettings set  org.gnome.desktop.interface cursor-theme 'vimix_cursors' ;

# add gnome shell plugins
printf '\n\n\ninstalling gnome shell exetensions\n' ;
cp -r ./gnome-shell-extensions/* ~/.local/share/gnome-shell/extensions/ ;

killall gnome-shell ;

## dash to dock
printf '\n\n\nextension dash to dock\n' ;
gnome-extensions enable dash-to-dock@micxgx.gmail.com ;
dconf load /org/gnome/shell/extensions/dash-to-dock/ < ./gnome-shell-extensions-conf/dash-to-dock.backup ;

## sound-output-device-chooser
printf '\n\n\nextension sound-output-device-chooser\n' ;
gnome-extensions enable sound-output-device-chooser@kgshank.net ;

# git
printf '\n\n\ngit config' ;
## git aliases
printf '\n\n\nadding git aliases' ;
git config --global alias.s 'status -sb' ;
git config --global alias.c 'commit' ;
git config --global alias.amend 'commit --amend' ;
git config --global alias.ck 'checkout' ;
git config --global alias.b 'branch' ;
git config --global alias.l 'log --pretty="format:%Cgreen%ci %Cred%h %Cblue%an %C(green)[%C(magenta)%ae%C(green)] -> %C(white)%s"' ;
git config --global alias.lg 'log --pretty="format:%Cgreen%cI %C(white)%cr%n -> %Cred%h%n -> %Cblue%an %C(green)[%C(magenta)%ae%C(green)]%n -> %C(white)%s%n    %b"' ;

# install zsh
printf '\n\n\ninstalling zsh'
apt install zsh -y;
chsh -s $(which zsh) ;
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ;

# change file and executing pulseaudio -k && alsa force-reload
printf '\n\n\nnoise removing\n'
printf '### USER CHANGES' >> /etc/pulse/default.pa ;
printf '# printf cancel' >> /etc/pulse/default.pa ;
printf 'load-module module-printf-cancel' >> /etc/pulse/default.pa ;
pulseaudio -k && alsa force-reload ;

printf '\n\nrun "pulseaudio -k && alsa force-reload" to enable noise supress\n' ;

printf '\n\n\n***\n\n\n*finished*\n\n\n***\nmaybe you should restart\n' ;