# Mouse Battery for Omarchy

An [Omarchy](https://omarchy.org) bar widget that shows the battery level of your wireless mouse.

- Reads UPower directly, so it updates as soon as the level changes, with no polling.
- Hides itself when no mouse is connected.
- Turns the theme's urgent colour at or below a threshold (20% by default).
- Hover for each mouse's name and level. With more than one mouse, the bar shows the lowest.

## Install

```sh
omarchy plugin add https://github.com/danieldonaldson/omarchy-mouse-battery --enable
```

Then drag it to where you want it on the bar.

## Settings

| Key | Default | |
|---|---|---|
| `showPercentage` | `true` | Off shows just the icon; the level stays in the tooltip. |
| `lowThreshold` | `20` | At or below this percentage the widget turns the urgent colour. |

## Which mice work?

Any mouse that UPower lists with a battery. Check with:

```sh
upower -e | grep mouse
```

If that prints a line, the widget will show it. Most Bluetooth mice and Logitech Unifying/Bolt mice report their battery; many other 2.4 GHz dongle mice, and Razer mice (which need OpenRazer), do not.

## License

MIT
