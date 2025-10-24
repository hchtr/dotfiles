#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

read -rp "(?) Install base packages (0 = no, 1 = yes): " INSTALL_BASE
read -rp "(?) Install SDL build dependencies (0 = no, 1 = yes): " INSTALL_SDL
read -rp "(?) Install VBox Linux Guest Additions [WARNING: Insert CD first] (0 = no, 1 = yes): " INSTALL_VBOX

if [ "$INSTALL_BASE" = "1" ]; then
  echo "(...) Installing base packages"
  sudo apt update -qq >/dev/null 2>&1
  sudo apt install -y -qq \
    xorg i3 vim git pulseaudio alsa-utils pavucontrol rofi \
    tree zip unzip cmake build-essential tmux feh htop >/dev/null 2>&1
fi

if [ "$INSTALL_SDL" = "1" ]; then
  echo "(...) Installing SDL build dependencies"
  sudo apt update -qq >/dev/null 2>&1
  sudo apt install -y -qq \
    build-essential git make pkg-config cmake ninja-build gnome-desktop-testing \
    libasound2-dev libpulse-dev libaudio-dev libfribidi-dev libjack-dev libsndio-dev \
    libx11-dev libxext-dev libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev \
    libxss-dev libxtst-dev libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev \
    libgles2-mesa-dev libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev \
    libpipewire-0.3-dev libwayland-dev libdecor-0-dev liburing-dev >/dev/null 2>&1
fi

if [ "$INSTALL_VBOX" = "1" ]; then
  echo "(...) Installing VBox Linux Guest Additions"
  if sudo mount /dev/cdrom /mnt >/dev/null 2>&1; then
    if sudo sh /mnt/VBoxLinuxAdditions.run >/dev/null 2>&1; then
      echo "(!) Done installing VBox Linux Guest Additions"
    else
      echo "(X) Failed installing VBox Linux Guest Additions"
    fi
    sudo umount /mnt >/dev/null 2>&1
  else
    echo "(X) Insert CD image first"
  fi
fi

rm -f "$HOME/.bash_profile"
ln -s "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

mkdir -p "$HOME/.config/i3"
for file in "$DOTFILES_DIR/.config/i3/"*; do
  filename=$(basename "$file")
  rm -f "$HOME/.config/i3/$filename"
  ln -s "$file" "$HOME/.config/i3/$filename"
done

mkdir -p "$HOME/.config/i3status"
for file in "$DOTFILES_DIR/.config/i3status/"*; do
  filename=$(basename "$file")
  rm -f "$HOME/.config/i3status/$filename"
  ln -s "$file" "$HOME/.config/i3status/$filename"
done

for file in .fehbg .tmux.conf .vimrc .xinitrc .Xresources; do
  rm -f "$HOME/$file"
  ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
done

echo "(!) Dotfiles setup complete"
