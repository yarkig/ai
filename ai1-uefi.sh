loadkeys ru
setfont cyr-sun16

echo '\033[32mОчистка диска'
dd if=/dev/zero of=/dev/sda bs=32M status=progress

echo '\033[32mСоздание разделов'
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

echo '\033[32mФорматирование дисков'
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda2 -L swap
mkfs.ext4  /dev/sda3

echo '\033[32mМонтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda2

echo '\033[32mВыбор зеркал для загрузки. Ставим зеркало от Яндекс на первое место'
sed -ie '1 iServer = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch' /etc/pacman.d/mirrorlist

echo '\033[32mПрогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf

echo '\033[32mУстановка основных пакетов'
pacstrap -i /mnt base base-devel linux linux-firmware mc nano openssh networkmanager intel-ucode --noconfirm

echo '\033[32mНастройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo '\033[32mВходим в установленную систему'
arch-chroot /mnt sh -c "$(curl -fsSL git.io/ai2-uefi.sh)"
