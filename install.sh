#!/bin/bash

#update
sudo pacman -Syu

#install base packages
sudo pacman -S --noconfirm nvidia-open pipewire pipewire-pulse wireplumber pavucontrol kitty wofi waybar ttf-fira-code zsh

#install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#add in neovim config
git clone https://github.com/caldeira04/init.lua.git ~/.config/nvim

#enable sound services
systemctl --user enable pipewire pipewire-pulse wireplumber pavucontrol
systemctl --user restart pipewire pipewire-pulse wireplumber pavucontrol

#install yay repo apps
yay -S --noconfirm hyprland-meta-git zen-browser-bin

#configurate nvidia vars
sudo cp -r modprobe.d /etc/ && sudo cp mkinitcpio.conf /etc/
sudo mkinitcpio -P

#copy hyprland and kitty default configs
cp hyprland.conf ~/.config/hypr/
cp kitty.conf ~/.config/kitty

#configurate zshell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

#install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
exec zsh
nvm install 22
exit

reboot
