MY_DISK="/dev/nvme0n1"
MY_USER="felipe"
MY_NAME="Felipe Giacomelli"

set -e

###### GRUB
pacman -Syu intel-ucode grub efibootmgr --noconfirm --needed
mkdir /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $MY_DISK
ls -l /boot/efi/EFI/arch/

###### SUDO
useradd -G wheel -s /bin/bash -m -c "$MY_NAME" $MY_USER
pacman -S sudo vim --noconfirm
echo -e "\n%wheel ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers

###### BASIC
pacman -S gnome-desktop gnome-control-center xfce4-terminal gdm networkmanager python3 nautilus chromium git --noconfirm --needed
echo -e "\nWaylandEnable=false\n" >> /etc/gdm/custom.conf
systemctl enable gdm NetworkManager.service

###### LOCALE
echo -e "\nen_GB.UTF-8 UTF-8" >> /etc/locale.gen
echo -e "\nen_GB ISO-8859-1" >> /etc/locale.gen
echo -e "\npt_BR.UTF-8 UTF-8  " >> /etc/locale.gen
echo -e "\npt_BR ISO-8859-1" >> /etc/locale.gen
locale-gen

touch /etc/locale.conf
echo -e "LANG=en_GB.UTF-8" >> /etc/locale.conf

touch /etc/vconsole.conf
echo -e "KEYMAP=br-abnt2" >> /etc/vconsole.conf

###### USER
echo -e "\n$MY_USER password: "
passwd $MY_USER

###### ROOT
echo -e "\nroot password: "
passwd

exit
umount -R /mnt
