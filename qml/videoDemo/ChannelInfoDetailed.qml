import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Background {
    id: root

    width: 400
    height: 600

    property string channelName: ""

//    onChannelNameChanged: programList.model = channelModel.programModel(channelName)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 10
        ChannelInfo {
            id: channelInfo
            text: channelName
            height: 1.5 * textSize
        }

        Item {
            width: 400
            height: 500
            ListView {
                id: programList

                anchors.fill: parent
                delegate: ProgramInfo {
                    width: 350
                }
            }
        }
    }
}
