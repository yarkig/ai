loadkeys ru
setfont cyr-sun16

echo 'Очистка диска'
dd if=/dev/zero of=/dev/sda bs=32M status=progress

echo 'Создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +100M;
  
  echo n;
  echo;
  echo;
  echo;
  echo +2048M;

  echo n;
  echo p;
  echo;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

echo 'Форматирование дисков'
mkfs.ext4  /dev/sda1
mkswap /dev/sda2 -L swap
mkfs.ext4  /dev/sda3

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
mount /dev/sda3 /mnt/home

echo 'Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo 'Установка основных пакетов'
pacstrap -i /mnt base base-devel linux linux-firmware openssh mc nano gvfs networkmanager network-manager-applet xorg xorg-server xf86-video-intel xfce4 xfce4-goodies screenfetch pavucontrol pulseaudio vlc ttf-liberation ttf-dejavu chromium --noconfirm

echo 'Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo 'Входим в установленную систему'
arch-chroot /mnt sh -c "$(curl -fsSL https://git.io/fhhE5)"