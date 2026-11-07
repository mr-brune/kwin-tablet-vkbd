#!/bin/sh

set_vkbd() {
    if [ "$1" = "true" ]; then
        busctl --user set-property org.kde.KWin /VirtualKeyboard \
            org.kde.kwin.VirtualKeyboard active b true
        busctl --user set-property org.kde.KWin /VirtualKeyboard \
            org.kde.kwin.VirtualKeyboard mode i 1
    else
        busctl --user set-property org.kde.KWin /VirtualKeyboard \
            org.kde.kwin.VirtualKeyboard mode i 0
    fi
}

for _ in 1 2 3 4 5; do
    state=$(busctl --user get-property org.kde.KWin /org/kde/KWin \
        org.kde.KWin.TabletModeManager tabletMode 2>/dev/null)
    if [ -n "$state" ]; then
        case "$state" in
            *"true"*) set_vkbd true ;;
            *) set_vkbd false ;;
        esac
        break
    fi
    sleep 1
done

dbus-monitor --session \
    "type=signal,interface=org.kde.KWin.TabletModeManager,member=tabletModeChanged" |
while read -r line; do
    case "$line" in
        *"boolean true"*) set_vkbd true ;;
        *"boolean false"*) set_vkbd false ;;
    esac
done
