#!/bin/sh

echo "Linking vimrc"
ln -sfr .vimrc $HOME/.vimrc
echo "Linking zshrc"
ln -sfr .zshrc $HOME/.zshrc
echo "Linking waybar files"
ln -sfr waybar/bouquet.css $HOME/.config/waybar/bouquet.css
ln -sfr waybar/mocha.css $HOME/.config/waybar/mocha.css
ln -sfr waybar/style.css $HOME/.config/waybar/style.css
ln -sfr waybar/config $HOME/.config/waybar/config
echo "Linking foot.ini"
ln -srf foot/foot.ini $HOME/.config/foot/foot.ini
echo "setting up vim colorscheme"
mkdir -p $HOME/.vim/colors
ln -srf bouquet.vim $HOME/.vim/colors/bouquet.vim
echo "setting up rofi config"
ln -srf rofi/hurricane.jpg $HOME/.config/rofi/images/hurricane.jpg
ln -srf rofi/style-10.rasi $HOME/.config/rofi/launchers/type-7/style-10.rasi
