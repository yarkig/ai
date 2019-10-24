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
mkfs.ext4  /dev/sda2

echo 'Монтирование дисков'
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
mount /dev/sda2 /mnt/home

echo 'Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo 'Установка основных пакетов'
pacstrap -i /mnt base base-devel linux linux-firmware openssh mc nano networkmanager network-manager-applet --noconfirm

echo 'Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo 'Входим в установленную систему'
arch-chroot /mnt sh -c "$(curl -fsSL git.io/fhhQj)"
