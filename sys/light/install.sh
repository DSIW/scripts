#!/bin/bash
mkdir -p ~/.icons
echo "Kopiere Bild nach '~/.icons/'..."
cp light.png ~/.icons/

echo "Installation des Pakets 'nvclock'"
sudo apt-get install nvclock

echo "Kopiere Desktop-Datei..."
sudo cp light.desktop /usr/share/applications/
echo "Oeffne Nautilus..."
nautilus /usr/share/applications/
echo "> Bitte ziehe Sie nun die Desktop-Datei Backlight (light.desktop) in ihr Unity-Panel."
zenity --info --text="Bitte ziehe Sie nun die Desktop-Datei Backlight (light.desktop) in ihr Unity-Panel."
echo "Installationskript fertiggestellt."
