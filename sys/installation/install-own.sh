# Name:     Installations-Skript (Auszug)
# Autor:    DSIW <dsiw@privatdemail.net>
# Blog:     http://dsiw.worpress.com
# Version:  2011-04-05
# Beschreibung: Dieses Skript enthaelt alle Pakete, die der Autor installiert hat. Dazu benutze er ein eigenes Skript, das die Pakete dieser Datei hinzufuegte.

# Media
# themes
sudo aptitude -y install gnome-themes-extras gnome-themes-ubuntu community-themes
# backgrounds
#sudo aptitude -y install ubuntu-wallpapers gutsy-wallpapers feisty-wallpapers edgy-wallpapers
#sudo aptitude -y install gnome-backgrounds peace-wallpapers tropic-wallpapers edgy-community-wallpapers

# Codecs
sudo aptitude -y install libxvidcore4 gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-plugins-ugly gstreamer0.10-plugins-ugly-multiverse gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse gstreamer0.10-ffmpeg gstreamer0.10-pitfdll 
sudo aptitude -y install libdvdread4

# LaTeX
sudo aptitude -y install texlive texlive-doc-de texlive-latex-extra texlive-lang-german latex-ucs latex-beamer
sudo aptitude -y install gedit-latex-plugin
