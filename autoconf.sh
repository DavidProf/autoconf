#!/bin/bash

# get password
echo -e "Type your PASSWORD";
read -s USERPWD

if [ "$USERPWD" == "" ] ; then
    echo "NO PASSWORD" ;
    exit 1 ;
fi

# preparing
echo -e '\n\n\n________________________\n' ;
printf 'Adding apt repositories' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" ;
echo $USERPWD | sudo -S add-apt-repository -y ppa:webupd8team/haguichi ;
echo $USERPWD | sudo -S add-apt-repository ppa:inkscape.dev/stable -y ;
echo $USERPWD | sudo -S add-apt-repository ppa:lutris-team/lutris -y ;

echo -e '\n\n\n________________________\n' ;
echo 'config wine requirements' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S dpkg --add-architecture i386 ;
wget -nc https://dl.winehq.org/wine-builds/winehq.key ;
echo $USERPWD | sudo -S apt-key add winehq.key ;
echo $USERPWD | sudo -S apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' ;

echo -e '\n\n\n________________________\n' ;
echo 'downloading debs & appimages & icons & themes' ;
echo -e '\n________________________' ;

wget -O ./code.deb 'https://az764295.vo.msecnd.net/stable/26076a4de974ead31f97692a0d32f90d735645c0/code_1.41.1-1576681836_amd64.deb' ;
wget -O ./chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' ;
wget -O ./hamachi.deb 'https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb' ;

wget -O ./clipgrab.appimage 'https://download.clipgrab.org/ClipGrab-3.8.14-x86_64.AppImage' ;
wget -O ./clipgrab.ico 'https://clipgrab.de/favicon.ico';

wget -O ./BlueSky-Dark.tar.xz 'https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1OTg5ODI3MDciLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjcyMDkxODMwMTJkYzU3Y2NmYTIxYzMzMjA0Y2M1Y2RjMGEwMDVjZjU0YjdhMDcxYTRlNDg3ZTRmZTg4ODg4MWQ4MGJkZDY0MGU1N2U1ZjllZTJkYmVjNTQ1ZjVhZDM2MGZiZDZiZDEwYmExZGM0M2VlNDMyMjRjYjkwNmFiMDZkIiwidCI6MTU5OTUwMDY0NCwic3RmcCI6Ijc1NWZhZWI1YWViMjhlNjBkYmI4YzE4NmNmZjdlMTM5Iiwic3RpcCI6IjI4MDQ6NDMxOmM3ZjU6MzBiNzo0MWQzOjY4MTY6NDMyOTo3OTc0In0.uK8nOlQF99N8kqsiwYTZUEVgrmGnTw3GC0w6lZmL-Z0/BlueSky-Dark.tar.xz' ;
wget -O ./icons.tar.gz 'https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NTQxNjQ0NzUiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImZmNjhiYzg1OTM0Y2FlYTM3ZmZmODJiOGYzNDY3N2M0YmY0YzBmNjZmMDk0ZGY5MDhhMDk2YWRjMTQ2ZjRjZTcwMjdiOGQxMWUzZmNjYzIwYWYzYjIxYWQ4MDJkYjk0ZTk1M2JkZDQwYjMzYWI1NTAwYmI5ZDg0NGFmZjA1NDljIiwidCI6MTU5OTUwMTIyMSwic3RmcCI6Ijc1NWZhZWI1YWViMjhlNjBkYmI4YzE4NmNmZjdlMTM5Iiwic3RpcCI6IjI4MDQ6NDMxOmM3ZjU6MzBiNzo0MWQzOjY4MTY6NDMyOTo3OTc0In0.wZzY6cOK0_OBfezCRKvs7l6bDPHCRnlZtLwRm2GHTCA/icons.tar.gz';
wget -O ./01-Vimix-cursors.tar.xz 'https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1ODI0NDIyNzYiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjhkMTI4OGZkNmFmNzdkMDVjYjU2Zjk0Y2IzMTAzMmM4ODc5ZmQyYTQxODRhOWFhOWVlNGJmZjY1MWIzNGMzNGIzZGRmZDMxOTdkMTYzOWQ1OTQ2OTRhNTY0MTJkODMzZTJiMzk5ZTVjN2Y3Y2VmYmYwZDllNGQwNjIwNGViYjk2IiwidCI6MTU5OTUwMTQ3OSwic3RmcCI6Ijc1NWZhZWI1YWViMjhlNjBkYmI4YzE4NmNmZjdlMTM5Iiwic3RpcCI6IjI4MDQ6NDMxOmM3ZjU6MzBiNzo0MWQzOjY4MTY6NDMyOTo3OTc0In0.vipGnDHmssVp6d1buWfwmbueQcOL7nyXdD4Z6TUCZdk/01-Vimix-cursors.tar.xz' ;

echo -e '\n\n\n________________________\n' ;
echo 'updating apt' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt update -y ;

echo $USERPWD | sudo -S chmod +x -R ./ ;

# install apps
echo -e '\n\n\n________________________\n' ;
echo 'terminator install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install terminator -y ;

echo -e '\n\n\n________________________\n' ;
echo 'net-tools install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install net-tools -y ;

echo -e '\n\n\n________________________\n' ;
echo 'htop install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install htop -y ;

echo -e '\n\n\n________________________\n' ;
echo 'node && npm && yarn install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install nodejs -y && 
echo $USERPWD | sudo -S apt install npm -y &&
echo $USERPWD | sudo -S npm i -g npm@latest &&
echo $USERPWD | sudo -S npx n stable &&
echo $USERPWD | sudo -S npm i -g yarn@latest ;

echo -e '\n\n\n________________________\n' ;
echo 'vlc media player install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S snap install vlc ;

echo -e '\n\n\n________________________\n' ;
echo 'rhythmbox install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install rhythmbox -y ;

echo -e '\n\n\n________________________\n' ;
echo 'docker install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install docker.io -y;
systemctl start docker ;
systemctl enable docker ;
echo $USERPWD | sudo -S apt install docker-compose -y;

echo $USERPWD | sudo -S groupadd docker ;
echo $USERPWD | sudo -S usermod -aG docker $USER ;

echo -e '\n\n\n________________________\n' ;
echo 'kazam install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install kazam -y ;

echo -e '\n\n\n________________________\n' ;
echo 'audacity install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install audacity -y ;

echo -e '\n\n\n________________________\n' ;
echo 'inkscape install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install inkscape -y ;

echo -e '\n\n\n________________________\n' ;
echo 'gimp install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install gimp -y ;

echo -e '\n\n\n________________________\n' ;
echo 'kdenlive install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install kdenlive -y ;

echo -e '\n\n\n________________________\n' ;
echo 'virtualbox-qt install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install virtualbox-qt -y ;

echo -e '\n\n\n________________________\n' ;
echo 'steam-installer install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install steam-installer -y ;

echo -e '\n\n\n________________________\n' ;
echo 'obs-studio install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install obs-studio -y ;

echo -e '\n\n\n________________________\n' ;
echo 'flash player install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install adobe-flashplugin browser-plugin-freshplayer-pepperflash -y ;

echo -e '\n\n\n________________________\n' ;
echo 'code install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install ./code.deb -y ;

echo -e '\n\n\n________________________\n' ;
echo 'chrome install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install ./chrome.deb -y ;

echo -e '\n\n\n________________________\n' ;
echo 'hamachi install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install ./hamachi.deb -y && echo $USERPWD | sudo -S apt install haguichi -y ;

echo -e '\n\n\n________________________\n' ;
echo 'wine install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install -y --install-recommends winehq-stable ;

echo -e '\n\n\n________________________\n' ;
echo 'lutris install' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install lutris -y;

echo -e '\n\n\n________________________\n' ;
echo 'clipgrab install' ;
echo -e '\n________________________' ;

echo $'[Desktop Entry]\nEncoding=UTF-8\nExec=/opt/clipgrab/clipgrab.appimage\nName=ClipGrab\nGenericName=CliptGrab\nType=Application\nTerminal=false\nStartupNotify=false\nType=Application\nIcon=/opt/clipgrab/clipgrab.ico\nCategories=Utility' > clipgrab.desktop
echo $USERPWD | sudo -S chmod +x ./clipgrab.appimage ;
echo $USERPWD | sudo -S chmod +x ./clipgrab.desktop ;
echo $USERPWD | sudo -S mkdir -p /opt/clipgrab ;
echo $USERPWD | sudo -S cp ./clipgrab.appimage /opt/clipgrab ;
echo $USERPWD | sudo -S cp ./clipgrab.ico /opt/clipgrab ;

cp ./clipgrab.desktop ~/.local/share/applications/ ;

# extra config

echo -e '\n\n\n________________________\n' ;
echo 'Setting favorites on taskbar' ;
echo -e '\n________________________' ;

gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'rhythmbox.desktop', 'org.gnome.Software.desktop']" ;

echo -e '\n\n\n________________________\n' ;
echo 'Enable seconds on clock' ;
echo -e '\n________________________' ;

gsettings set org.gnome.desktop.interface clock-show-seconds true
# set gnome shell theme
## theme
echo -e '\n\n\n________________________\n' ;
echo 'Setting theme' ;
echo -e '\n________________________' ;

tar -xf BlueSky-Dark.tar.xz ;
echo $USERPWD | sudo -S mkdir -p /usr/share/themes ;
echo $USERPWD | sudo -S mv ./BlueSky-Dark /usr/share/themes/ ;

killall gnome-shell ;

gsettings set org.gnome.desktop.interface gtk-theme 'BlueSky-Dark' ;
gsettings set org.gnome.desktop.wm.preferences theme 'BlueSky-Dark' ;

## icons
echo -e '\n\n\n________________________\n' ;
echo 'Setting icons' ;
echo -e '\n________________________' ;

tar -xzf icons.tar.gz ;
echo $USERPWD | sudo -S mkdir -p /usr/share/icons ;
echo $USERPWD | sudo -S mv ./icons /usr/share/icons/ ;

killall gnome-shell ;

gsettings set org.gnome.desktop.interface icon-theme 'icons' ;

## cursors
echo -e '\n\n\n________________________\n' ;
echo 'Setting cursors' ;
echo -e '\n________________________' ;

tar -xf 01-Vimix-cursors.tar.xz
echo $USERPWD | sudo -S cp -r ./Vimix-cursors /usr/share/icons/ ;

killall gnome-shell ;

gsettings set  org.gnome.desktop.interface cursor-theme 'Vimix-cursors' ;

# add gnome shell plugins
echo -e '\n\n\n________________________\n' ;
echo 'installing gnome shell exetensions' ;
echo -e '\n________________________' ;

mkdir -p ~/.local/share/gnome-shell/extensions/ ;
cp -r ./gnome-shell-extensions/* ~/.local/share/gnome-shell/extensions/ ;

killall gnome-shell ;

## dash to dock
echo -e '\n\n\n________________________\n' ;
echo 'extension dash to dock' ;
echo -e '\n________________________' ;

git clone https://github.com/micheleg/dash-to-dock.git ;
cd dash-to-dock ;
make ;
make install ;

killall gnome-shell ;

gnome-extensions enable dash-to-dock@micxgx.gmail.com ;


## sound-output-device-chooser
echo -e '\n\n\n________________________\n' ;
echo 'extension sound-output-device-chooser' ;
echo -e '\n________________________' ;

git clone https://github.com/kgshank/gse-sound-output-device-chooser.git ;
cp --recursive gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net ~/.local/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net ;

killall gnome-shell ;

gnome-extensions enable sound-output-device-chooser@kgshank.net ;

# git
echo -e '\n\n\n________________________\n' ;
echo 'git config' ;
echo -e '\n________________________' ;

echo $USERPWD | sudo -S apt install git ;

## git aliases
echo -e '\n\n\n________________________\n' ;
echo 'adding git aliases' ;
echo -e '\n________________________' ;

git config --global alias.s 'status -sb' ;
git config --global alias.c 'commit' ;
git config --global alias.amend 'commit --amend' ;
git config --global alias.ck 'checkout' ;
git config --global alias.b 'branch' ;
git config --global alias.l 'log --pretty="format:%Cgreen%ci %Cred%h %Cblue%an %C(green)[%C(magenta)%ae%C(green)] -> %C(white)%s"' ;
git config --global alias.lg 'log --pretty="format:%Cgreen%cI %C(white)%cr%n -> %Cred%h%n -> %Cblue%an %C(green)[%C(magenta)%ae%C(green)]%n -> %C(white)%s%n    %b"' ;

# change file and executing pulseaudio -k && alsa force-reload
echo -e '\n\n\n________________________\n' ;
echo 'noise removing' ;
echo -e '\n________________________' ;

echo -e '\n### USER CHANGES' | sudo tee -a /etc/pulse/default.pa ;
echo '# echo cancel' | sudo tee -a /etc/pulse/default.pa ;
echo 'load-module module-echo-cancel  source_name=unknown  source_properties=device.description=Unknown' | sudo tee -a /etc/pulse/default.pa ;
echo 'set-default-source unknown' | sudo tee -a /etc/pulse/default.pa ;
pulseaudio -k && echo $USERPWD | sudo -S alsa force-reload ;

printf '\n\nrun "pulseaudio -k && alsa force-reload" to enable noise supress\n' ;

printf '\n\n\n***\n\n\n*finished*\n\n\n***\nmaybe you should restart\n' ;