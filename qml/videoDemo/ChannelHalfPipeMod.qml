import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Item {
    id: root
    width: 600
    height: 100

    property real size: Math.min(root.width, root.height);
    property int itemsPerScreen: 4

    ListView {
        id: list
        y: 10
        anchors.centerIn: parent
        width: parent.width
        height: parent.height / root.itemsPerScreen

        property real cellWidth: (list.width - (root.itemsPerScreen - 1) * list.spacing) / root.itemsPerScreen

        orientation: ListView.Horizontal

        maximumFlickVelocity: 0

        spacing: 40

        leftMargin: width / 2 - cellWidth / 2
        rightMargin: width / 2 - cellWidth / 2

        preferredHighlightBegin: width / 2 - 25
        preferredHighlightEnd: width / 2 + 25
        highlightRangeMode: ListView.StrictlyEnforceRange

        focus: true
        delegate: ChannelIconMod {
            id: iconRoot;

            width: 50
            height: list.height

            offset: list.contentX;
            iconSource: channelIcon
        }

//        onCurrentIndexChanged: {
//            if (list.currentIndex >= 0) {
//                descriptionLabel.text = applicationsModel.query(list.currentIndex, "description");
//                nameLabel.text = applicationsModel.query(list.currentIndex, "name");
//            } else {
//                descriptionLabel.text = ""
//                nameLabel.text = ""
//            }
//        }
    }

    Connections {
        target: channelModel
        onInitialized: list.model = channelModel
    }
}
