import QtQuick 2.15

Item {
    property alias contextCalc: contextCalc
    property double x0: 0
    property double y0: 0
    property double x2: 0
    property double y2: 0
    property double scaling: 1
    property var xS: []
    property var yS: []
    WorkerScript {
        id: contextCalc
        source: "calculations.mjs"
        onMessage: {
            x0 = messageObject.x0
            y0 = messageObject.y0
            x2 = messageObject.x2
            y2 = messageObject.y2
            xS = messageObject.xS
            yS = messageObject.yS
            ui.display.sourceComponent = ui.displayComponent
        }
    }
}
