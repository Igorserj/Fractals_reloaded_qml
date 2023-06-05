import QtQuick 2.15
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvas
    renderStrategy: Canvas.Cooperative
    renderTarget: Canvas.FramebufferObject
    antialiasing: true
    smooth: true
    clip: false
    property int changeCol: 0
    onPaint: {
        loading.visible = true
        changeCol === 0 ? painting() : changeColor()
        //        function invert(color) {
        //            var a = color.replace("#", "").split('')
        //            var b = []
        //            for (var i = 0; i < a.length; i++) {
        //                b.push((15 - parseInt(a[i], 16)).toString(16))
        //                console.log(b)
        //            }
        //            b.unshift('#')
        //            return b.join('')
        //        }
    }
    onPainted: {
        loading.visible = false
    }

    function changeColor() {
        var xS = scripts.xS
        var yS = scripts.yS
        var x0 = -scripts.x0 - ui.hbar.position * ui.hbar.length
        var y0 = -scripts.y0 - ui.vbar.position * ui.vbar.length
        var scaling = scripts.scaling
        //        canvas.renderStrategy = scaling < 0.1 ? Canvas.Immediate : Canvas.Cooperative
        var context = getContext("2d")
        context.reset()
        context.scale(scaling, scaling)
        context.beginPath()
        for (var i = 0; i < xS.length; i++) {
            context.lineTo(xS[i] + x0, yS[i] + y0)
        }
        context.strokeStyle = rp.colorDialog.currentColor
        context.lineWidth = rp.strokeThickness.text
        context.stroke()
        changeCol = 0
    }
    function painting() {
        var context = getContext("2d")
        context.reset()
        var scaling = scripts.scaling
        context.scale(scaling, scaling)
        var xS = scripts.xS
        var yS = scripts.yS

        var x0 = scripts.x0
        var y0 = scripts.y0
        var x2 = scripts.x2
        var y2 = scripts.y2
        ui.hbar.length = x2 - x0
        ui.hbar.size = (window.width / ((x2 - x0) * scaling))
        ui.vbar.length = y2 - y0
        ui.vbar.size = (window.height - header.height) / ((y2 - y0) * scaling)
        if (ui.hbar.size >= 1) {
            ui.hbar.position = 0
        }
        if (ui.vbar.size >= 1) {
            ui.vbar.position = 0
        }

        x0 = -x0 - ui.hbar.position * ui.hbar.length
        y0 = -y0 - ui.vbar.position * ui.vbar.length
        const pi = Math.PI
        var length = rp.length.text
        var angle = parseInt(lp.rot.text)
        var curAngle = 0
        context.beginPath()

        context.lineTo(x0, y0)

        for (var i = 0; i < xS.length; i++) {
            context.lineTo(xS[i] + x0, yS[i] + y0)
        }

        context.lineWidth = rp.strokeThickness.text
        context.strokeStyle = rp.colorDialog.currentColor
        context.stroke()
        console.log("finish")
    }
}
