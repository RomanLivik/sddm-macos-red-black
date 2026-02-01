<img width="1920" height="1080" alt="Вставленное изображение" src="https://github.com/user-attachments/assets/570def75-edfc-4e85-8a4f-532a9b014100" />

# Red&Black sddm theme for arch with hyprland.
## !!!WARNING!!! <============ YOU MUST READ IT
* Your avatar may move out due to the difference in the size of the monitors. The place where the avatar's size and position on the screen are edited is marked in the code with comments in capital letters.
* Your avatar must be added to the theme manually. I left a command for this from below
* This theme only for alone user in your PC

## Installation
```
git clone https://github.com/RomanLivik/sddm-macos-red-black.git
sudo cp -r sddm-macos-red-black /usr/share/sddm/themes
```
### !!! After that you need to go to /etc/ and add to the sddm.conf:
```
[Theme]
Current=sddm-macos-red-black
```
### !!! Then you need to go to /etc/sddm.conf.d and add to the sddm.conf (yes, you need to do the same thing in /etc/sddm.conf.d):
```
[Theme]
Current=sddm-macos-red-black
```
### If you have not got sddm.conf.d in /etc/:
```
cd /etc/
mkdir sddm.conf.d
```
My friend helped me develop this theme. His github: https://github.com/exxtnd
