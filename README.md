# Mouse Battery for Omarchy

An [Omarchy](https://omarchy.org) bar widget that shows the battery level of your wireless mouse.

![Mouse battery widget on the bar](preview.png)

- Reads UPower directly, so it updates as soon as the level changes, with no polling and no commands run.
- Hides itself when no mouse is connected.
- Turns the theme's urgent colour at or below a threshold (20% by default).
- Hover for each mouse's name and level. With more than one mouse, the bar shows the lowest.

## Install

```sh
omarchy plugin add https://github.com/danieldonaldson/omarchy-mouse-battery --enable
```

## Usage

The widget appears on the right of the bar whenever a mouse that reports its battery is connected. Drag it to move it, or:

```sh
omarchy bar move io.github.danieldonaldson.mouse-battery --section right
```

## Configure

| Key | Default | |
|---|---|---|
| `showPercentage` | `true` | Off shows just the icon; the level stays in the tooltip. |
| `lowThreshold` | `20` | At or below this percentage the widget turns the urgent colour. |

```sh
omarchy bar set io.github.danieldonaldson.mouse-battery lowThreshold 15
omarchy bar set io.github.danieldonaldson.mouse-battery showPercentage false
```

## Remove

```sh
omarchy plugin remove io.github.danieldonaldson.mouse-battery
```

## Requirements

- [UPower](https://upower.freedesktop.org/), which Omarchy installs and runs by default. The widget only reads from it.
- No other dependencies, services, network access or extra privileges.

## Which mice work?

Any mouse that UPower lists with a battery. Check with:

```sh
upower -e | grep mouse
```

If that prints a line, the widget will show it. Most Bluetooth mice and Logitech Unifying/Bolt mice report their battery. Many other 2.4 GHz dongle mice, and Razer mice (which need OpenRazer), don't. Trackpads are listed as touchpads, so they aren't shown.

## License

MIT
