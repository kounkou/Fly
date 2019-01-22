
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Rectangle {
    id: root

    height: 70
    width: parent.width
    color: "#616161"

    property alias currentPageName  : context.text
    property alias previousPageLink : backButton.visible
    property alias forwardButton    : forwardButton.visible
    property alias forwardButtonArea: forwardButton
    property alias backButton       : backButton

    Row {
        id: menuElements
        anchors.verticalCenter: parent.verticalCenter
        anchors.fill: parent
        spacing: 10

        Button {
            id: backButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 20

            onClicked: {
                stackView.pop()
            }

            contentItem: Text {
                text: "←"
                font.pixelSize: 25
                font.bold: true
                opacity: enabled ? 1.0 : 0.3
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.family: robotoLight.name
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: "transparent"
            }
        }

        Text {
            id: context
            font.pixelSize: 16
            text: ""
            color: "#FFFFFF"
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: robotoLight.name
        }                

        Button {
            id: forwardButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            width: 20

            onClicked: {
                // stackView.push("qrc:/AddItem.qml")
            }

            contentItem: Text {
                text: "?"
                font.pixelSize: 20
                font.bold: true
                opacity: enabled ? 1.0 : 0.3
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.family: robotoLight.name
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: "transparent"
            }
        }
    }
}
