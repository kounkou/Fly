import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root
    width: 325
    height: 500

    Rectangle {
        id: head
        anchors.top: parent.top
        anchors.margins: 0
        height: root.height / 12
        width: root.width
        color: "grey"

        Button {
            id: logout
            text: qsTr("logout")
            anchors.right: parent.right
            anchors.rightMargin: 5
            height: parent.height - 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                backend.requestLogout()
            }
        }
    }

    Rectangle {
        id: body
        anchors.top: head.bottom
        color: "lightgrey"
        anchors.margins: 0
        height: 10 * root.height / 12
        width: root.width
    }

    Rectangle {
        id: tail
        anchors.top: body.bottom
        color: "grey"
        anchors.margins: 0
        height: root.height / 12
        width: root.width
    }
}
