#!/bin/bash
loadkeys ru
setfont cyr-sun16

echo 'Очистка диска'
wipefs --all --force /dev/sda /dev/sda1 /dev/sda2
dd if=/dev/zero of=/dev/sda bs=512 count=1

echo 'Создание разделов'
(
  echo o;
  echo Y;

  echo n;
  echo;
  echo;
  echo +200M;
  echo EF00;

  echo n;
  echo;
  echo;
  echo;
  echo;

  echo w;
  echo Y;
) | gdisk /dev/sda

echo 'Форматирование дисков'
mkfs.vfat -F32 /dev/sda1
mkfs.btrfs  /dev/sda2

echo 'Монтирование дисков'
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot

echo 'Прогресс-бар в виде Пакмана, пожирающего пилюли'
sudo sed -ie '/^# Misc options/a ILoveCandy' /etc/pacman.conf
sudo sed -ie '/^# Misc options/a ParallelDownloads = 5' /etc/pacman.conf

echo 'Установка основных пакетов'
pacstrap -i /mnt base base-devel linux-zen linux-firmware mc nano openssh networkmanager amd-ucode --noconfirm

echo 'Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo 'Входим в установленную систему'
arch-chroot /mnt sh -c "$(curl -fsSL raw.githubusercontent.com/yarkig/ai/master/ai2-uefi.sh)"
