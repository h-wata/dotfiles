# How to install

[参考URL](https://askubuntu.com/questions/1034624/touchpad-gestures-in-ubuntu-18-04-lts)
[参考URL2](https://askubuntu.com/questions/789915/ubuntu-16-04-multitouch-gestures)

## command
```
git clone http://github.com/bulletmark/libinput-gestures
cd libinput-gestures
sudo make install
```


```
sudo apt install libinput-tools xdotool
```

```
sudo gpasswd -a $USER input  # Log out and back in to assign this group
```
