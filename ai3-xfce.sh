echo 'Прогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf

echo 'Ставим DE, драйвера и основные программы'
sudo pacman -S gnome screenfetch vlc ttf-liberation ttf-dejavu zsh papirus-icon-theme --noconfirm

echo 'Ставим AUR (yay) и pamac-aur'
sudo pacman -Syu --noconfirm
(
  echo;
) | sh -c "$(curl -fsSL git.io/yay-install.sh)" --noconfirm
yay -S pamac-aur --noconfirm

echo 'Ставим темы и расширения для Gnome'
yay -S matcha-gtk-theme gnome-shell-extension-dash-to-panel gnome-shell-extension-arc-menu --noconfirm
wget gitlab.com/rastersoft/desktop-icons-ng/-/archive/master/desktop-icons-ng-master.tar.gz
tar -xzf desktop-icons-ng-master.tar.gz
sh ~/desktop-icons-ng-master/local_install.sh

echo 'Ставим oh-my-zsh'
yay -S oh-my-zsh-git --noconfirm
sudo sed -ie 's/robbyrussell/bureau/' /usr/share/oh-my-zsh/zshrc
cp /usr/share/oh-my-zsh/zshrc /home/igor/.zshrc
sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
sudo chsh -s /bin/zsh igor
sudo chsh -s /bin/zsh root

#echo 'Устанавливаем конфиг Gnome'
#wget git.io/ai-conf.tar.gz git.io/ai-wp.tar.gz
#sudo rm -rf ~/.config ~/Общедоступные ~/Видео ~/Музыка ~/Шаблоны
#sudo tar -xzf ai-conf.tar.gz -C ~/
#sudo tar -xzf ai-wp.tar.gz -C ~/
#sudo rm -rf ~/ai-conf.tar.gz ~/ai-wp.tar.gz
