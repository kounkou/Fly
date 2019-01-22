import QtQuick 2.9
import QtQuick.Controls 2.2

Popup {
    property alias popupMessage: popupMessage
    property alias ggmPopup    : popup
    property alias lcontrol    : lcontrol
    property alias rcontrol    : rcontrol

    id: popup
    width: parent.width / 1.3
    height: parent.height / 4
    modal: true
    focus: true
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 200
        border.color: "lightgray"
        radius: 5
    }

    Text {
        id: popupTitle
        text: qsTr("Input Error")
        font.pointSize: 18
        font.bold: true
        color: "#232F34"
        font.family: robotoLight.name
    }

    Text {
        id: popupMessage
        text: qsTr("")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: "gray"
        font.family: robotoLight.name
    }

    Row {
        id: rowItems
        spacing: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Button {
            id: lcontrol
            width: 80
            height: 35
            text: qsTr("OK")            
            font.family: robotoLight.name
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                opacity: enabled ? 1 : 0.3
                radius: 2
                color: "white"
            }
            contentItem: Text {
                text: lcontrol.text
                font: lcontrol.font
                opacity: enabled ? 1.0 : 0.3
                color: lcontrol.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            onClicked: popup.close()
        }

        Button {
            id: rcontrol
            width: 80
            height: 35
            text: qsTr("CANCEL")
            font.family: robotoLight.name

            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                opacity: enabled ? 1 : 0.3
                radius: 2
                color: "white"
            }
            contentItem: Text {
                text: rcontrol.text
                font: rcontrol.font
                opacity: enabled ? 1.0 : 0.3
                color: rcontrol.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            onClicked: popup.close()
        }
    }
}
