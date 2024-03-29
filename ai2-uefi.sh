#!/bin/bash
read -p "Введите имя компьютера: " hostname
echo 'Прписываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

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

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux-zen

echo 'Устанавливаем загрузчик'
bootctl --path=/boot install
echo "default arch" > /boot/loader/loader.conf
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux-zen" >> /boot/loader/entries/arch.conf
echo "initrd /amd-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux-zen.img" >> /boot/loader/entries/arch.conf
echo "options root=/dev/sda2 rw" >> /boot/loader/entries/arch.conf

echo 'Устанавливаем пароль root'
passwd

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash igor

echo 'Устанавливаем пароль пользователя'
passwd igor

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Включим нужные службы'
systemctl enable sshd NetworkManager

echo 'Выходим из окружения chrootexit'
exit
