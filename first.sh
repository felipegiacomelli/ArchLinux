MY_DISK="/dev/nvme0n1"
MY_EFI="/dev/nvme0n1p2"
MY_PART="/dev/nvme0n1p5"

set -e

###### SETUP
mkfs.ext4 -L "Arch Linux" $MY_PART
mount $MY_PART /mnt
pacstrap /mnt base linux linux-firmware

###### MOUNT
mkdir -p /mnt/boot/efi
mount $MY_EFI /mnt/boot/efi
genfstab -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

wget https://raw.githubusercontent.com/felipegiacomelli/ArchLinux/master/second.sh
chmod +x second.sh
mv second.sh /mnt

echo -e "\narch-chroot /mnt"
