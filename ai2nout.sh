#!/bin/bash

echo 'Прписываем имя компьютера'
echo "home2" > /etc/hostname
# ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo 'Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
export LANG=ru_RU.UTF-8

echo 'Консольный шрифт и раскладка клавиатуры'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Настройка сети'
systemctl enable dhcpcd@enp1s0f1.service

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo 'Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Устанавливаем пароль root'
passwd

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash igor

echo 'Устанавливаем пароль пользователя'
passwd igor

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Включим ssh:'
systemctl enable sshd

echo 'Выходим из окружения chrootexit'
exit
