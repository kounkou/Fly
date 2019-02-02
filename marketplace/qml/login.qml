import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root

    height: 500
    width : 350
    anchors.centerIn: parent

    TextField {
        id: user
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        width : 100
        height: 40
        placeholderText: "login"
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    TextField {
        id: pass
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: user.bottom
        width : 100
        height: 40
        placeholderText: "password"
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Button {
        id: validate
        anchors.top: pass.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("enter")

        onClicked: {
            backend.requestAuthentification(user.text, pass.text)
        }
    }
}
