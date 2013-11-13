import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    width: 1000
    height: 600

    Item {
        id: channelListContainer
        x: 50
        width: 400
        height: 600
        ListView {
            id: channelList

            spacing: 10
            anchors.fill: parent
            delegate: ChannelInfoSummary {}

            focus: true
//            onCurrentItemChanged: {
//                if (currentItem) {
//                    channelInfoDetails.channelName = currentItem.name;
//                    channelInfoDetails.visible = true
//                } else {
//                    channelInfoDetails.visible = false
//                }
//            }
        }
    }

//    Item {
//        id: channelDetailsContainer
//        x: channelListContainer.x + channelListContainer.width + 50
//        width: 400
//        height: 200
//        anchors.verticalCenter: parent.verticalCenter

//        ChannelInfoDetailed {
//            id: channelInfoDetails

//            anchors.fill: parent
//            visible: true
//            opacity: 0.7
//        }
//    }

    Connections {
        target: channelModel
        onInitialized: {
            console.log("initialized")
            channelList.model = channelModel
        }
    }
}
