import QtQuick 2.0
import QtQuick.Controls 1.0

Label {
    color: "white"
    text: startTime + "  " + programName
    elide: Text.ElideRight
    renderType: Text.QtRendering
}

