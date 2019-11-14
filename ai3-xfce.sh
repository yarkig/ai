echo 'Прогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf

echo 'Ставим DE, драйвера и основные программы'
sudo pacman -S gvfs network-manager-applet xf86-video-intel xorg xfce4 xfce4-goodies screenfetch pavucontrol pulseaudio vlc ttf-liberation ttf-dejavu zsh telegram-desktop chromium --noconfirm

echo 'Ставим AUR (yay) и pamac-aur'
sudo pacman -Syu --noconfirm
sh -c "$(curl -fsSL git.io/yay-install.sh)" --noconfirm
yay -S pamac-aur --noconfirm

echo 'Ставим темы и иконки'
yay -S numix-frost-themes numix-circle-icon-theme-git --noconfirm

echo 'Ставим oh-my-zsh'
yay -S oh-my-zsh-git --noconfirm
sudo sed -ie 's/robbyrussell/bureau/' /usr/share/oh-my-zsh/zshrc
cp /usr/share/oh-my-zsh/zshrc /home/igor/.zshrc
sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
sudo chsh -s /bin/zsh igor
sudo chsh -s /bin/zsh root

echo 'Автозапуск XFCE4'
sudo mkdir /etc/systemd/system/getty@tty1.service.d
echo "[Service]" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo "ExecStart=" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo "ExecStart=-/usr/bin/agetty --autologin igor --noclear %I 38400 linux" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo '[[ -f ~/.zshrc ]] && . ~/.zshrc' > /home/igor/.zprofile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/igor/.zprofile
echo "exec startxfce4" > /home/igor/.xinitrc
