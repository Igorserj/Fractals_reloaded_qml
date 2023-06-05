import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Column {
    property alias colorDialog: colorDialog
    property alias strokeThickness: strokeThickness
    property alias length: length
    TextField {
        id: strokeThickness
        font.weight: Font.DemiBold
        anchors.right: parent.right
        text: "3"
        placeholderText: "thickness"
    }
    TextField {
        id: length
        placeholderText: "length"
        text: "100"
        font.weight: Font.DemiBold
    }
    Button {
        id: strokeColor
        font.weight: Font.DemiBold
        anchors.right: parent.right
        text: "color"
        highlighted: true
        onClicked: colorDialog.open()
    }

    ColorDialog {
        id: colorDialog
    }
}
