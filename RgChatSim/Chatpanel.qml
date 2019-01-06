import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    width: chatpanelLayout.width
    height: chatpanelLayout.height

    property string text;
    property int messageMaxLength: 180;

    signal history();
    signal submitted();

    function append(line) {
        messageBlockModel.append({messageBlockLineText: line});
        messageBlock.positionViewAtEnd();
    }

    ColumnLayout {
        id: chatpanelLayout
        height: 400

        // Button layout, top
        RowLayout {

            Button {
                text: qsTr("Clear")

                onClicked: messageBlockModel.clear()
            }

            Button {
                Layout.alignment: Qt.AlignRight

                text: qsTr("History")

                onClicked: history()
            }
        }

        // Message block
        ColumnLayout {

            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                padding: 5

                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.vertical.interactive: true

                // message rows
                ListView {
                    id: messageBlock
                    spacing: 6

                    model: messageBlockModel

                    delegate: messageBlockDelegate
                }

                ListModel {
                    id: messageBlockModel
                }

                Component {
                    id: messageBlockDelegate

                    Rectangle {
                        height: messageBlockLine.height

                        Label {
                            id: messageBlockLine
                            width: messageBlock.width
                            wrapMode: Text.Wrap

                            text: messageBlockLineText
                        }
                    }
                }
            }
        }

        // New message row
        ColumnLayout {

            RowLayout {
                spacing: 0

                TextField {
                    id: newMessageField
                    Layout.fillWidth: true
                    maximumLength: messageMaxLength

                    onTextChanged: {
                        newMessageFieldProgressbar.value = length;
                        newMessageFieldLength.text = length + "/" + messageMaxLength;
                    }

                    onAccepted: {
                        root.text = newMessageField.text;
                        newMessageField.clear();
                        submitted();
                    }
                }

                Button {
                    text: qsTr("Send")

                    onClicked: {
                        root.text = newMessageField.text;
                        newMessageField.clear();
                        submitted();
                    }

                }
            }

            RowLayout {

                ProgressBar {
                    id: newMessageFieldProgressbar
                    Layout.fillWidth: true
                    from: 0
                    to: messageMaxLength
                }

                Label {
                    id: newMessageFieldLength
                    text: newMessageField.length + "/" + messageMaxLength
                }
            }
        }
    }

}
