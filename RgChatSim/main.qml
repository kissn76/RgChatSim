import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: mainpane.width
    maximumWidth: width
    minimumWidth: width
    height: mainpane.height
    maximumHeight: height
    minimumHeight: height
    title: qsTr("RgChatSim")

    property string leftUsername: "leftpanel"
    property string rightUsername: "rightpanel"

    /*
     * Signals
     */

    // send message from chat panels to C++
    signal qmlSignalSubmitMessage(string sendFrom, string sendTo, string message)

    // get history from C++
    signal qmlSignalGetHistory(string name)

    /*
     * Slots
     */

    // append line to chat panel by processed message from C++
    function qmlSlotSetMessageBlock(toUser, message) {
        if (toUser === rightUsername) {
            chatpanelRight.append(message);
        } else if (toUser === leftUsername) {
            chatpanelLeft.append(message);
        }
    }

    // append line to history from C++
    function qmlSlotSetHistoryBlock(history) {
        historydialog.append(history);
    }

    /*
     * The QML code
     */

    // Main Pane
    Pane {
        id: mainpane
        padding: 5

        // two Chat panel holder layout
        RowLayout {
            spacing: 0

            // Left Chat panel layout
            Chatpanel {
                id: chatpanelLeft

                onHistory: {
                    historydialog.open();
                    historydialog.clear();
                    qmlSignalGetHistory(leftUsername);
                }

                onSubmitted: qmlSignalSubmitMessage(leftUsername, rightUsername, text)
            }

            // Separator between panels
            ToolSeparator {
                Layout.fillHeight: true
                topPadding: 0
                rightPadding: 5
                bottomPadding: 0
                leftPadding: 5
            }

            // Right Chat panel layout
            Chatpanel {
                id: chatpanelRight

                onHistory: {
                    historydialog.open();
                    historydialog.clear();
                    qmlSignalGetHistory(rightUsername);
                }

                onSubmitted: qmlSignalSubmitMessage(rightUsername, leftUsername, text)
            }
        }
    }

    // History dialog
    Historydialog {
        id: historydialog
    }
}
