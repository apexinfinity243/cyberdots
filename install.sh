#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

PKGS=(hyprland hyprlock hypridle waybar kitty rofi swaync swaybg grim slurp
      wl-clipboard brightnessctl playerctl pavucontrol network-manager-applet
      hyprpolkitagent xdg-desktop-portal-hyprland qt5-wayland qt6-wayland
      ttf-jetbrains-mono-nerd pipewire pipewire-pulse wireplumber)

sudo pacman -S --needed "${PKGS[@]}"

mkdir -p "$HOME/.config"
BK="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
for d in hypr waybar kitty rofi swaync; do
  t="$HOME/.config/$d"
  if [ -e "$t" ] && [ ! -L "$t" ]; then mkdir -p "$BK"; mv "$t" "$BK/"; fi
  ln -sfn "$DIR/$d" "$t"
  echo "→ $t"
done
echo "OK. Anciennes configs (si présentes) : $BK"
echo "Relance Hyprland (SUPER+SHIFT+E puis relogin)."
