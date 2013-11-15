import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Item {
    id: root
    width: 900
    height: 600

    onVisibleChanged: {
        if (visible)
            channelList.forceActiveFocus()
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 75
        Item {
            id: channelListContainer
            width: (root.width - rowLayout.spacing) / 2
            height: root.height
            ListView {
                id: channelList

                spacing: 10
                anchors.fill: parent
                maximumFlickVelocity: 0

                topMargin: height / 2
                bottomMargin: height / 2
                cacheBuffer: 20
                delegate: ChannelInfoSummary {
                    id: infoSummary
                }

                focus: true
                onCurrentItemChanged: {
                    channelInfoDetails.program = channelList.currentItem.program
                    channelInfoDetails.channelName = channelList.currentItem.name
                }

                preferredHighlightBegin: height / 2 - 50
                preferredHighlightEnd: height / 2 + 50
                highlightRangeMode: ListView.StrictlyEnforceRange
            }
        }

        Item {
            id: channelDetailsContainer
            width: (root.width - rowLayout.spacing) / 2
            height: 200
            anchors.verticalCenter: parent.verticalCenter

            ChannelInfoDetailed {
                id: channelInfoDetails

                anchors.fill: parent
                visible: true
                opacity: 0.7
            }
        }
    }


    Connections {
        target: channelModel
        onInitialized: channelList.model = channelModel
    }
}
