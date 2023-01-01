#!/bin/bash
echo 'Прогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf

echo 'Ставим DE, драйвера и основные программы'
sudo pacman -S gnome neofetch go --noconfirm

echo 'Ставим AUR (yay) и pamac-aur'
sudo pacman -Syu --noconfirm
(
  echo;
) | sh -c "$(curl -fsSL git.io/yay-install.sh)" --noconfirm
yay -S pamac-aur --noconfirm

echo 'Ставим oh-my-zsh'
yay -S oh-my-zsh-git --noconfirm
sudo sed -ie 's/robbyrussell/bureau/' /usr/share/oh-my-zsh/zshrc
cp /usr/share/oh-my-zsh/zshrc /home/igor/.zshrc
sudo cp /usr/share/oh-my-zsh/zshrc /root/.zshrc
sudo chsh -s /bin/zsh igor
sudo chsh -s /bin/zsh root
