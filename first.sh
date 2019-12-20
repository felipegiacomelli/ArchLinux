MY_DISK="/dev/nvme0n1"
MY_EFI="/dev/nvme0n1p2"
MY_PART="/dev/nvme0n1p5"

###### SETUP
mkfs.ext4 -L "Arch Linux" $MY_PART
mount $MY_PART /mnt
pacstrap /mnt base linux linux-firmware

###### MOUNT
mkdir -p /mnt/boot/efi
gdisk -l /dev/sda
mount $MY_EFI /mnt/boot/efi
genfstab -p /mnt >> /mnt/etc/fstab
