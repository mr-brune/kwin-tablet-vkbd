# kwin-tablet-vkbd

Enables the KDE Plasma Wayland virtual keyboard only in tablet mode, preventing touch keyboard popups in laptop mode.

The project is inspired by [`joshpj/kde_vkbd_toggle`](https://github.com/joshpj/kde_vkbd_toggle), but uses a POSIX shell script and the Plasma 6.7+ virtual-keyboard mode property.

## Requirements

- KDE Plasma 6.7+ on Wayland
- `systemd`, `busctl`, and `dbus-monitor`
- A working `SW_TABLET_MODE` switch exposed by `org.kde.KWin.TabletModeManager`

## Install

```sh
mkdir -p ~/.local/bin ~/.config/systemd/user
curl -fsSLo vkbd-tablet-toggle.sh https://github.com/mr-brune/kwin-tablet-vkbd/raw/main/vkbd-tablet-toggle.sh
curl -fsSLo vkbd-tablet-toggle.service https://github.com/mr-brune/kwin-tablet-vkbd/raw/main/vkbd-tablet-toggle.service
install -m 755 vkbd-tablet-toggle.sh ~/.local/bin/
install -m 644 vkbd-tablet-toggle.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now vkbd-tablet-toggle.service
```

Check the service:

```sh
journalctl --user -u vkbd-tablet-toggle.service -f
```

## Uninstall

```sh
systemctl --user disable --now vkbd-tablet-toggle.service
rm -f ~/.local/bin/vkbd-tablet-toggle.sh ~/.config/systemd/user/vkbd-tablet-toggle.service
systemctl --user daemon-reload
```

## Files

- [`vkbd-tablet-toggle.sh`](https://github.com/mr-brune/kwin-tablet-vkbd/blob/main/vkbd-tablet-toggle.sh)
- [`vkbd-tablet-toggle.service`](https://github.com/mr-brune/kwin-tablet-vkbd/blob/main/vkbd-tablet-toggle.service)
- [`LICENSE`](https://github.com/mr-brune/kwin-tablet-vkbd/blob/main/LICENSE)

## License

MIT
