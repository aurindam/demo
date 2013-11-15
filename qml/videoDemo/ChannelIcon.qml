import QtQuick 2.0

Background {
    id: root

    property alias iconSource: icon.source

    Image {
        id: icon
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
}
