import QtQuick 2.9
import QtQuick.Controls 2.2

Popup {
    property alias ggmPopup    : popup
    property alias lcontrol    : lcontrol
    property alias rcontrol    : rcontrol
    property alias title       : title
    property alias details     : details
    property bool  status      : false

    id: popup
    width: parent.width - 20
    height: parent.height / 2
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

    Column {
        spacing: 10

        anchors.horizontalCenter : parent.horizontalCenter

        Text {
            id: titleLabel
            text: qsTr("Task")
            font.family: robotoLight.name
        }

        TextField {
            id: title
            placeholderText: qsTr("Name")
            font.family: robotoLight.name
            font.pixelSize: 12
            background: Rectangle {
                implicitWidth: details.width
                implicitHeight: 30
                border.width: 1
                border.color: title.focus ? "#BDBDBD" : "lightgray"
                radius: 5
                anchors.fill: parent
            }
        }

        Text {
            id: detailsLabel
            text: qsTr("Task details")
            font.family: robotoLight.name
        }

        Flickable {
            width: popup.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            height: 90

            TextArea.flickable: TextArea {
                id: details
                placeholderText: qsTr("Description")
                font.family: robotoLight.name
                font.pixelSize: 12
                text: ""
                wrapMode: TextArea.Wrap

                background: Rectangle {
                    implicitWidth : 290
                    implicitHeight: 90
                    border.width: 1
                    border.color: details.focus ? "#BDBDBD" : "lightgray"
                    radius: 5
                }
            }

            ScrollBar.vertical: ScrollBar { }
        }
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
            font.pixelSize: 14
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

            onClicked: {
                if (title.text !== "") {
                    status = true
                }
                popup.close()
            }
        }

        Button {
            id: rcontrol
            width: 80
            height: 35
            font.pixelSize: 14
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
            onClicked: {
                if (title.text !== "") {
                    status = true
                }
                popup.close()
            }
        }
    }
}
