read -p "Введите имя компьютера: " hostname
echo '\033[32mПрписываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo '\033[32mДобавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen

echo '\033[32mОбновим текущую локаль системы'
locale-gen

echo '\033[32mУказываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
export LANG=ru_RU.UTF-8

echo '\033[32mКонсольный шрифт и раскладка клавиатуры'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo '\033[32mСоздадим загрузочный RAM диск'
mkinitcpio -p linux

echo '\033[32mУстанавливаем загрузчик'
bootctl --path=/boot install
echo "default arch" > /boot/loader/loader.conf
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=/dev/sda3 rw" >> /boot/loader/entries/arch.conf

echo '\033[32mУстанавливаем пароль root'
passwd

echo '\033[32mДобавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash igor

echo '\033[32mУстанавливаем пароль пользователя'
passwd igor

echo '\033[32mУстанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo '\033[32mВключим нужные службы'
systemctl enable sshd NetworkManager

echo '\033[32mВыходим из окружения chrootexit'
exit
