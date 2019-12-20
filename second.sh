MY_DISK="/dev/nvme0n1"
MY_USER="felipe"
MY_NAME="Felipe Giacomelli"

###### mkinitcpio
mkinitcpio -p linux

###### GRUB
pacman -Syu intel-ucode grub efibootmgr --noconfirm
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $MY_DISK
ls -l /boot/efi/EFI/arch/

useradd -G wheel -s /bin/bash -m -c $MY_NAME $MY_USER
pacman -S sudo vim
echo -e "\n%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman -S gnome-desktop gnome-control-center xfce4-terminal gdm networkmanager python3 nautilus chromium git --noconfirm --needed
systemctl enable gdm NetworkManager.service

###### LOCALE
echo -e "\nen_GB.UTF-8 UTF-8" >> /etc/locale.gen
echo -e "\nen_GB ISO-8859-1" >> /etc/locale.gen
echo -e "\npt_BR.UTF-8 UTF-8  " >> /etc/locale.gen
echo -e "\npt_BR ISO-8859-1" >> /etc/locale.gen
locale-gen

touch /etc/locale.conf
echo -e "LANG=en_GB.UTF-8" >> /etc/locale.conf

###### USER
passwd $MY_USER

###### ROOT
passwd