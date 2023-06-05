import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

ApplicationWindow {
    id: window
    property double prevWidth: width
    property double prevHeight: height
    property double prevX: x
    property double prevY: y
    width: 1280
    height: 720
    visible: true
    Material.theme: Material.Dark
    color: window.width === Screen.desktopAvailableWidth ? (minimization.running
                                                            || normalization.running) ? "transparent" : Material.theme === Material.Light ? "#DDDDDD" : "#292929" : "transparent"
    Material.accent: Material.Pink
    Material.foreground: Material.Pink
    Material.primary: Material.Pink
    flags: Qt.Window | Qt.FramelessWindowHint
    title: qsTr("Fractals")
    onVisibilityChanged: visibility === 2 ? normalization.running = true : {}

    Rectangle {
        id: bg
        y: header.height
        x: (window.width - width) / 2
        height: parent.height - header.height - 10
        width: parent.width - 10
        color: Material.theme === Material.Light ? "white" : "#292929"
        state: "default"
    }

    Rectangle {
        id: header
        width: window.width
        color: "#E91E63"
        height: 50
        z: 3
        MouseArea {
            anchors.fill: parent
            property var clickPos: "1,1"

            onPressed: {
                clickPos = Qt.point(mouse.x, mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                window.x += delta.x
                window.y += delta.y
            }
            onDoubleClicked: square.click()
        }
        RowLayout {
            anchors.fill: parent
            layoutDirection: "RightToLeft"
            ToolButton {
                text: "⨯"
                Material.foreground: "white"
                font.weight: "DemiBold"
                onClicked: Qt.quit()
            }
            ToolButton {
                id: square
                text: "□"
                Material.foreground: "white"
                font.weight: "DemiBold"
                onClicked: click()
                function click() {
                    ui.display.sourceComponent = undefined
                    if (window.height === Screen.desktopAvailableHeight
                            && window.width === Screen.desktopAvailableWidth)
                        normalization2.running = true
                    else
                        maximization.running = true
                }
            }
            ToolButton {
                text: "–"
                Material.foreground: "white"
                font.weight: "DemiBold"
                onClicked: minimization.running = true // window.showMinimized()
            }
            ToolButton {
                text: window.Material.theme === Material.Dark ? "○" : "◉"
                Material.foreground: "white"
                font.weight: "DemiBold"
                onClicked: {
                    window.Material.theme === Material.Dark ? window.Material.theme = Material.Light : window.Material.theme = Material.Dark
                }
            }

            Label {
                Material.foreground: "white"
                font.weight: "DemiBold"
                text: "Fractals"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }
    DropShadow {
        anchors.fill: header
        source: header
        z: header.z - 1
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }
    Rectangle {
        id: uiRect
        z: 2
        anchors.fill: bg
        color: "transparent"
        UserInterface {
            id: ui
            anchors.fill: parent
        }
    }

    Scripts {
        id: scripts
    }

    SequentialAnimation {
        id: minimization
        PropertyAnimation {
            target: bg
            property: "y"
            to: -bg.height
            duration: 1000
        }
        PropertyAnimation {
            target: header
            property: "width"
            to: 0
            duration: 500
        }
        ScriptAction {
            script: window.showMinimized()
        }
    }
    SequentialAnimation {
        id: normalization
        PropertyAnimation {
            target: header
            property: "width"
            to: window.width
            duration: 500
        }
        PropertyAnimation {
            target: bg
            property: "y"
            to: header.height
            duration: 1000
        }
        ScriptAction {
            script: bg.state = "default"
        }
    }
    SequentialAnimation {
        id: maximization
        ScriptAction {
            script: {
                prevHeight = window.height
                prevWidth = window.width
                prevX = window.x
                prevY = window.y
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: window
                property: "x"
                to: 0
                duration: 500
                easing.type: "InQuad"
            }
            PropertyAnimation {
                target: window
                property: "y"
                to: 0
                duration: 500
                easing.type: "InQuad"
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: window
                property: "height"
                to: Screen.desktopAvailableHeight
                duration: 1000
                easing.type: "InOutQuad"
            }
            PropertyAnimation {
                target: window
                property: "width"
                to: Screen.desktopAvailableWidth
                duration: 1000
                easing.type: "InOutQuad"
            }
        }
        ScriptAction {
            script: ui.generate()
        }
    }
    SequentialAnimation {
        id: normalization2
        ParallelAnimation {
            PropertyAnimation {
                target: window
                property: "height"
                to: prevHeight
                duration: 1000
                easing.type: "InOutQuad"
            }
            PropertyAnimation {
                target: window
                property: "width"
                to: prevWidth
                duration: 1000
                easing.type: "InOutQuad"
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: window
                property: "x"
                to: prevX
                duration: 500
                easing.type: "InQuad"
            }
            PropertyAnimation {
                target: window
                property: "y"
                to: prevY
                duration: 500
                easing.type: "InQuad"
            }
        }
        ScriptAction {
            script: ui.generate()
        }
    }
}
