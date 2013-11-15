import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Item {
    id: root
    width: 900
    height: 600

    property int itemsPerScreen: 5

    onVisibleChanged: {
        if (visible)
            channelHalfPipe.forceActiveFocus()
    }

    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20

        Item {
            id: channelDetailsContainer
            width: 400
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter

            ChannelInfoDetailed {
                id: channelInfoDetails

                anchors.fill: parent
                visible: true
                opacity: 0.7
            }
        }

        Item {
            id: channelHalfPipeContainer
            width: root.width
            height: root.height - 100 - columnLayout.spacing - channelLabel.height - columnLayout.anchors.topMargin - columnLayout.anchors.bottomMargin - channelDetailsContainer.height
            PathView {
                id: channelHalfPipe

                anchors.fill: parent
                maximumFlickVelocity: 0

                pathItemCount: root.itemsPerScreen
                delegate: ChannelIcon {
                    id: infoSummary

                    property string number: channelNumber
                    property string name: channelName
                    property var program: channelProgram

                    height: 50
                    width: 150
                    iconSource: channelIcon
                    opacity: PathView.isCurrentItem ? 0.7 : 0.5
                }

                focus: true
                onCurrentItemChanged: updateSiblings()
                onModelChanged: updateSiblings()

                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange

                path: Path {
                    startX: 0; startY: 100
                    PathQuad { x: channelHalfPipeContainer.width; y: 100; controlX: channelHalfPipeContainer.width / 2; controlY: channelHalfPipeContainer.height }
                }
                Keys.onLeftPressed: decrementCurrentIndex()
                Keys.onRightPressed: incrementCurrentIndex()

                function updateSiblings() {
                    channelLabel.text = currentItem.number + "  " + currentItem.name
                    channelInfoDetails.program = currentItem.program
                    channelInfoDetails.channelName = currentItem.name
                }
            }
        }

        ChannelLabel {
            id: channelLabel
            width: 200
            height: 1.5 * textSize
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.7
        }
    }


    Connections {
        target: channelModel
        onInitialized: channelHalfPipe.model = channelModel
    }
}
