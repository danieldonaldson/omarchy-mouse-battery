import QtQuick
import Quickshell.Services.UPower
import qs.Commons
import qs.Ui

// Shows the battery of connected mice straight from UPower: it updates when
// UPower does, with nothing polled. The widget collapses when no mouse
// reports a battery.
BarWidget {
  id: root
  moduleName: "io.github.danieldonaldson.mouse-battery"

  readonly property int lowThreshold: Number(setting("lowThreshold", 20))
  readonly property bool showPercentage: setting("showPercentage", true) !== false

  readonly property var mice: {
    var out = []
    var list = UPower.devices.values
    for (var i = 0; i < list.length; i++) {
      var d = list[i]
      if (d && d.type === UPowerDeviceType.Mouse && d.isPresent)
        out.push(d)
    }
    return out
  }
  readonly property bool present: mice.length > 0
  // The lowest mouse sets the number and the colour.
  readonly property int level: {
    var min = 101
    for (var i = 0; i < mice.length; i++)
      min = Math.min(min, Math.round(mice[i].percentage * 100))
    return min > 100 ? 0 : min
  }
  readonly property bool low: present && level <= lowThreshold

  // The model name comes from the device; keep a misbehaving one from
  // stretching the tooltip.
  function deviceName(d) {
    var name = String(d.model || "").trim()
    if (name === "") return strings.t("mouse.unnamed")
    return name.length > 48 ? name.slice(0, 47) + "…" : name
  }

  Translations { id: strings; directory: Qt.resolvedUrl("i18n") }

  visible: present
  implicitWidth: present ? button.implicitWidth : 0
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰍽"
    labelText: root.showPercentage && !vertical ? I18n.formatNumber(root.level) + "%" : ""
    slotSize: Style.bar.iconSlot * (root.showPercentage && !vertical ? 2 : 1)
    foreground: root.low && root.bar ? root.bar.urgent : (root.bar ? root.bar.foreground : "white")
    useActiveColor: false
    tooltipText: {
      var lines = []
      for (var i = 0; i < root.mice.length; i++)
        lines.push(strings.t("mouse.level")
          .arg(root.deviceName(root.mice[i]))
          .arg(I18n.formatNumber(Math.round(root.mice[i].percentage * 100))))
      return lines.join("\n")
    }
  }
}
