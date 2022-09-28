#! /bin/bash

#loadkeys uk

#Verify the boot mode
#ls /sys/firmware/efi/efivars

#If the above returns a directory without error,
#it's successfully booted in UEFI mode.

#timedatectl set-ntp true

#fdisk -l
#fdisk /dev/disk_to_be_partitioned

#Create partitions

#/dev/sda1 500MB = boot partition
#/dev/sda2 2GB = swap
#/dev/sda3 Remaining disk space = root partition

#mkfs.fat -F32 /dev/sda1
#mkswap /dev/sda2
#swapon /dev/sda2
#mkfs.ext4 /dev/sda3

#mount root partition
#mount /dev/sda3 /mnt

#Mount boot partition
#mount --mkdir /dev/sda1 /mnt/boot

#pacstrap /mnt base linux linux-firmware intel-ucode git nano

#genfstab -U /mnt >> /mnt/etc/fstab

#arch-chroot /mnt

#ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
#hwclock --systohc

#nano /etc/locale.gen

#Uncomment the necessary locale in /etc/locale.gen

#locale-gen

#touch /etc/hostname
#touch /etc/locale.conf
#touch vconsole.conf
#echo "LANG=en-GB.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=uk" >> /etc/vconsole.conf
#echo "arch" >> /etc/hostname
#echo "127.0.0.1     localhost" >> /etc/hosts
#echo "::1           localhost" >> /etc/hosts
#echo "127.0.1.1     arch.localdomain     arch" >> /etc/hosts

#Setting up other users and wheel group
#passwd (set root password)
#useradd -m ciaran
#passwd ciaran (set ciaran password)
#usermod -aG wheel

#pacman -S sudo 

#Give user access to sudo
#EDITOR=nano visudo
#uncomment %wheel ALL=(ALL) ALL

#Installing and configuring GRUB
#pacman -S grub efibootmgr dosfstools os-prober mtools
#mkdir /boot/EFI
#mount /dev/sda1 /boot/EFI
#grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=arch --recheck
#grub-mkconfig -o /boot/grub/grub.cfg

#Installing NetworkManager
#pacman -S networkmanager
#systemctl enable NetworkManager 

#Installing Alacritty
#pacman -S alacritty

#Exiting, unmounting and rebooting

#exit
#umount -R /mnt
#reboot

#POST INSTALL

#sudo pacman -S man firewalld gparted nautilus
#systemctl enable firewalld

#sudo pacman -S --needed base-devel
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si

#sudo pacman -S xorg-server xorg-xinit
#localectl --no-convert set-x11-keymap gb

#sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
#systemctl enable lightdm

#Double-check enabled unit files
#systemctl list-unit-files --state=enabled

#sudo pacman -S i3-gaps i3status i3lock rofi vifm

#sudo pacman -S htop neofetch

#sudo pacman -S alsa-utils 
#amixer sset Master unmute
#amixer sset Speaker unmute
#amixer sset Headphone unmute


#If installing Pulse
#sudo pacman -S pulseaudio 
#sudo pacman -S pulseaudio-alsa

#sudo pacman -S pavucontrol

#Optional pulseaudio front-end
#paru -S ncpamixer

#sudo pacman -S mpv ffmpegthumbs

#sudo pacman -S firefox

#paru -S freetube-bin
#paru -S arandr
