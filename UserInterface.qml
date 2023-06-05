import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Item {
    property alias display: display
    property alias displayComponent: displayComponent
    property alias hbar: hbar
    property alias vbar: vbar

    Loader {
        id: display
        asynchronous: true
        height: parent.height
        width: parent.width
    }
    ScrollBar {
        id: vbar
        property int length: 1
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        visible: display.status === Loader.Ready
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        position: 0
        onPositionChanged: display.item.requestPaint()
    }

    ScrollBar {
        id: hbar
        property int length: 1
        hoverEnabled: true
        active: hovered || pressed
        visible: display.status === Loader.Ready
        orientation: Qt.Horizontal
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        position: 0
        onPositionChanged: display.item.requestPaint()
    }
    Component {
        id: displayComponent
        Display {}
    }
    BusyIndicator {
        id: loading
        visible: false
        anchors.centerIn: parent
    }
    LeftPage {
        id: lp
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
    }
    RightPage {
        id: rp
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
    }
    function generate() {
        loading.visible = true
        display.sourceComponent = undefined
        scripts.contextCalc.sendMessage({
                                            "base": lp.base.text,
                                            "ruleF": lp.ruleF.text,
                                            "ruleG": lp.ruleG.text,
                                            "generations": lp.generations.text,
                                            "length": rp.length.text,
                                            "angle": lp.rot.text
                                        })
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

