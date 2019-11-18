echo '\033[32mПрогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf

echo '\033[32mСтавим DE, драйвера и основные программы'
sudo pacman -S gvfs network-manager-applet xf86-video-intel xorg xfce4 xfce4-goodies screenfetch pavucontrol pulseaudio vlc ttf-liberation ttf-dejavu zsh telegram-desktop chromium xdg-user-dirs --noconfirm

echo '\033[32mСтавим AUR (yay) и pamac-aur'
sudo pacman -Syu --noconfirm
(
  echo;
) | sh -c "$(curl -fsSL git.io/yay-install.sh)" --noconfirm
yay -S pamac-aur --noconfirm

echo '\033[32mСтавим темы и иконки'
yay -S numix-frost-themes numix-circle-icon-theme-git --noconfirm

echo '\033[32mСтавим oh-my-zsh'
yay -S oh-my-zsh-git --noconfirm
sudo sed -ie 's/robbyrussell/bureau/' /usr/share/oh-my-zsh/zshrc
cp /usr/share/oh-my-zsh/zshrc /home/igor/.zshrc
sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
sudo chsh -s /bin/zsh igor
sudo chsh -s /bin/zsh root

echo '\033[32mАвтозапуск XFCE4'
sudo mkdir /etc/systemd/system/getty@tty1.service.d
echo "[Service]" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo "ExecStart=" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo "ExecStart=-/usr/bin/agetty --autologin igor --noclear %I 38400 linux" | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
echo '[[ -f ~/.zshrc ]] && . ~/.zshrc' > /home/igor/.zprofile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/igor/.zprofile
echo "exec startxfce4" > /home/igor/.xinitrc

echo '\033[32mСоздаем пользовательские директории'
xdg-user-dirs-update

echo '\033[32mУстанавливаем конфиг XFCE4'
wget git.io/ai-conf.tar.gz
wget git.io/ai-wp.tar.gz
sudo rm -rf ~/.config
sudo tar -xzf ai-conf.tar.gz -C ~/
sudo tar -xzf ai-wp.tar.gz -C ~/
sudo rm -rf ~/ai-conf.tar.gz
sudo rm -rf ~/ai-wp.tar.gz
