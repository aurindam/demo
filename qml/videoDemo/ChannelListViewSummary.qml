import QtQuick 2.0

Item {

    property alias delegate: list.delegate
    property alias model: list.model

    ListView {
        id: list

        anchors.fill: parent
        delegate: ChannelInfo {}

    }

    ListModel {
        id: programModel
    }

    onModelChanged: {
        channelModel.programModel()
    }
}
