WorkerScript.onMessage = function (message) {

    var pattern = message.base
    var ruleF = message.ruleF
    var ruleG = message.ruleG
    var generations = message.generations
    var x0 = 0
    var y0 = 0
    var x1 = 0
    var y1 = 0
    var x2 = 0
    var y2 = 0
    var xS = []
    var yS = []
    const pi = Math.PI
    var length = message.length
    var angle = parseInt(message.angle)

    var curAngle = 0
    for (var i = 0; i < generations; i++) {
        pattern = pattern.replace(/F/g, "0").replace(/G/g, "1").replace(
                    /0/g, ruleF).replace(/1/g, ruleG)
    }

    for (i = 0; i < pattern.length; i++) {
        if (pattern[i] === "F" || pattern[i] === "G") {
            x1 += length * Math.cos(curAngle * (pi / 180))
            xS.push(x1)
            x1 > x2 ? x2 = x1 : x1 < x0 ? x0 = x1 : {}
            y1 += length * Math.sin(curAngle * (pi / 180))
            yS.push(y1)
            y1 > y2 ? y2 = y1 : y1 < y0 ? y0 = y1 : {}
        } else if (pattern[i] === "-") {
            curAngle += angle
        } else if (pattern[i] === "+") {
            curAngle -= angle
        }
    }

    //    var hbar_length = x2 - x0
    //    var vbar_length = y2 - y0

    //                                 "hbar_length": hbar_length,
    //                                 "vbar_length": vbar_length,
    WorkerScript.sendMessage({
                                 "xS": xS,
                                 "yS": yS,
                                 "x0": x0,
                                 "y0": y0,
                                 "x2": x2,
                                 "y2": y2
                             })
}
