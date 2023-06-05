import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Column {
    property alias rot: rot
    property alias base: base
    property alias ruleF: ruleF
    property alias ruleG: ruleG
    property alias generations: generations
    property alias generateButtonText: generateButton.text
    TextField {
        id: base
        font.weight: Font.DemiBold
        placeholderText: "start"
    }
    TextField {
        id: ruleF
        font.weight: Font.DemiBold
        placeholderText: "F"
    }
    TextField {
        id: ruleG
        font.weight: Font.DemiBold
        placeholderText: "G"
    }
    TextField {
        id: generations

        placeholderText: "n"
        text: "3"
        font.weight: Font.DemiBold
    }
    TextField {
        id: rot
        font.weight: Font.DemiBold
        placeholderText: "angle"
        text: "90"
    }
    Row {
        Label {
            text: "scale"
            verticalAlignment: "AlignVCenter"
            height: scaling.height
        }
        Slider {
            id: scaling
            from: 0
            to: 2
            value: 1
            stepSize: 0.01
            ToolTip.visible: pressed
            ToolTip.text: Math.round(value * 100) / 100
            onValueChanged: {
                scripts.scaling = Math.round(scaling.value * 100) / 100
                        !!display.item ? display.item.requestPaint() : {}
            }
        }
    }
    Button {
        id: generateButton
        text: "Generate"
        highlighted: true
        onClicked: ui.generate()
    }
}
