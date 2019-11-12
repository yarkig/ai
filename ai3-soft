#echo 'Прогресс-бар в виде Пакмана, пожирающего пилюли'
#sudo echo "ILoveCandy" >> /etc/pacman.conf

echo 'Ставим DE, драйвера и основные программы'
sudo pacman -S gvfs network-manager-applet xf86-video-intel xorg xfce4 xfce4-goodies screenfetch pavucontrol pulseaudio vlc ttf-liberation ttf-dejavu zsh telegram-desktop chromium --noconfirm

echo 'Ставим AUR (yay)'
sudo pacman -Syu --noconfirm
sh -c "$(curl -fsSL git.io/yay-install.sh)" --noconfirm

echo 'Ставим темы и иконки'
yay -S numix-frost-themes numix-circle-icon-theme-git --noconfirm

echo 'Ставим oh-my-zsh'
yay -S oh-my-zsh-git --noconfirm
cp /usr/share/oh-my-zsh/zshrc /home/igor/.zshrc
sudo chsh -s /bin/zsh igor
sudo chsh -s /bin/zsh root

echo 'Автозапуск XFCE4'
sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo echo "[Service]" > /etc/systemd/system/getty@tty1.service.d/override.conf
sudo echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
sudo echo "ExecStart=-/usr/bin/agetty --autologin igor --noclear %I 38400 linux" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo '[[ -f ~/.zshrc ]] && . ~/.zshrc' > /home/igor/.zprofile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/igor/.zprofile
echo "exec startxfce4" > /home/igor/.xinitrc
