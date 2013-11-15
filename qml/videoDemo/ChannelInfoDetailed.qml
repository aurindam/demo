import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Background {
    id: root

    width: 400
    height: 600

    property alias program: programList.model
    property alias channelName: channelInfo.text

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 10
        ChannelInfo {
            id: channelInfo
            height: 1.5 * textSize
        }

        Item {
            width: 400
            height: 100
            ListView {
                id: programList

                anchors.fill: parent
                delegate: ProgramInfo {
                    width: 350
                }
            } // ListView
        } // Item

    } // ColumnLayout
}
