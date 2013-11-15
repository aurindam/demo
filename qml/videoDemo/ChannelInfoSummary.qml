import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Background {
    id: root

    width: 450
    height: 100

    opacity: ListView.isCurrentItem ? 0.7 : 0.5

    property var program: channelProgram
    property string name: channelName

    RowLayout {
        anchors.centerIn: parent
        spacing: 0
        Item {
            height: root.height
            width: root.width / 3
            ChannelIcon {
                anchors.fill: parent
                iconSource: channelIcon
                opacity: 0.7
                border.width: 0
                radius: 0
            }
        }
        Item {
            id: infoContainer
            height: root.height
            width: root.width / 3 * 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 2
                ChannelInfo {
                    id: channelInfo
                    height: 1.5 * textSize
                    width: infoContainer.width - 50
                    text: channelNumber + "  " + channelName
                }

                Item {
                    height: infoContainer.height - channelInfo.height - 20
                    ListView {
                        id: programList

                        interactive: false
                        anchors.fill: parent
                        delegate: ProgramInfo {
                            width: infoContainer.width - 50
                        }
                        model: channelProgramSummary
                    } // ListView
                } // Item

            } // ColumnLayout
        }
    } //RowLayout
}
