loadkeys ru
setfont cyr-sun16

echo 'Очистка диска'
dd if=/dev/zero of=/dev/sda bs=32M status=progress

echo 'Создание разделов'
(
  echo g;

  echo n;
  echo;
  echo;
  echo +512M;
  echo t;
  echo 1;
  
  echo n;
  echo;
  echo;
  echo +2048M;
  echo t;
  echo 2;
  echo 19;

  echo n;
  echo;
  echo;
  echo;

  echo w;
) | fdisk /dev/sda

echo 'Форматирование дисков'
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda2 -L swap
mkfs.ext4  /dev/sda3

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda2

echo 'Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo 'Установка основных пакетов'
pacstrap -i /mnt base base-devel linux linux-firmware openssh mc nano gvfs networkmanager network-manager-applet xf86-video-intel xorg xfce4 xfce4-goodies screenfetch pavucontrol pulseaudio vlc ttf-liberation ttf-dejavu intel-ucode telegram-desktop chromium --noconfirm

echo 'Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo 'Входим в установленную систему'
arch-chroot /mnt sh -c "$(curl -fsSL https://git.io/Je2fc)"
