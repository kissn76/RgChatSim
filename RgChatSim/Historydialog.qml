import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2

Rectangle {
    id: root

    function append(history) {
        historyModel.append({historyLineText: history});
        historyList.positionViewAtEnd();
    }

    function clear() {
        historyModel.clear();
    }

    function open() {
        historyDialog.open();
    }

    Dialog {
        id: historyDialog
        title: qsTr("History")
        width: 500
        height: 400

        contentItem: ScrollView {
            padding: 5

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: true

            ListView {
                id: historyList
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                spacing: 6

                model: ListModel {
                    id: historyModel
                }

                delegate: Rectangle {
                    height: historyLine.height

                    Label {
                        id: historyLine
                        width: historyList.width
                        wrapMode: Text.Wrap

                        text: historyLineText
                    }
                }

            }
        }
    }
}
