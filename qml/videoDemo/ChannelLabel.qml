import QtQuick 2.0

Background {
    id: root

    height: 50
    width: 50

    property alias text: channelInfo.text
    ChannelInfo {
        id: channelInfo
        anchors.centerIn: parent
    }
}
