import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Popup {
    id: dialog
    x: -parent.x + (window.width - width) / 2
    y: -parent.y + (window.height - height) / 2
    property var colors: ["#FF0000", "#00FF00", "#0000FF", "#FFE082", "#EEEEEE", "#111111"]
    property color currentColor: "#FFE082"
    onClosed: {
        display.item.changeCol = 1
        display.item.requestPaint()
    }
    Column {
        spacing: 30
        Row {
            id: row
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater {
                model: colors
                Rectangle {
                    height: 40
                    width: 60
                    color: modelData
                    opacity: mouseArea.containsMouse ? 0.65 : 1
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            currentColor = modelData
                            redS.value = currentColor.r
                            greenS.value = currentColor.g
                            blueS.value = currentColor.b
                        }
                    }
                }
            }
        }
        Rectangle {
            height: width / 4
            width: row.width
            anchors.horizontalCenter: parent.horizontalCenter
            color: currentColor
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: currentColor.toString().toUpperCase()
        }
        Row {
            Slider {
                id: redS
                stepSize: 1 / 256
                Material.accent: "red"
                onValueChanged: currentColor.r = position
                ToolTip.visible: pressed
                ToolTip.text: Math.round(value * 255)
                Component.onCompleted: value = currentColor.r
            }
            Slider {
                id: greenS
                stepSize: 1 / 256
                Material.accent: "green"
                onValueChanged: currentColor.g = position
                ToolTip.visible: pressed
                ToolTip.text: Math.round(value * 255)
                Component.onCompleted: value = currentColor.g
            }
            Slider {
                id: blueS
                stepSize: 1 / 256
                Material.accent: "blue"
                onValueChanged: currentColor.b = position
                ToolTip.visible: pressed
                ToolTip.text: Math.round(value * 255)
                Component.onCompleted: value = currentColor.b
            }
        }
    }
}
