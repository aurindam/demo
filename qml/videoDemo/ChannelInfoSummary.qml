import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Item {
    id: root

    width: 400
    height: 150

    opacity: ListView.isCurrentItem ? 0.7 : 0.5

    property string name: ""

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 2
//        ChannelInfo {
//            id: channelInfo
//            height: 1.5 * textSize
//        }

//        Column {
//            Repeater {
//                id: repeater
//                model: listModel
//                ProgramInfo {
//                    width: 350
//                }
//            }
//        }
        Item {
            width: 400
            height: 500
            ListView {
                id: programList

                interactive: false
                anchors.fill: parent
                delegate: ProgramInfo {
                    width: 350
                    color: "black"
                }
                model: channelModel.programModel(channelName)

            }
        }
    }

//    ListModel {
//        id: listModel
//    }

//    Component.onCompleted: {
//        root.name = channelName
//        console.log(" oncompleted " + root.name)
//        var model = channelModel.programModel(channelName)
//        var nextTwoStartTimes = model.nextTwoStartTimes();
//        var nextTwoPrograms = model.nextTwoPrograms();
//        var length = nextTwoPrograms.length;
//        for (var i = 0; i < length; ++i) {
//            listModel.append({
//                         "programName": nextTwoPrograms[i],
//                         "startTime": nextTwoStartTimes[i]
//            })
//        }
//    }
}
