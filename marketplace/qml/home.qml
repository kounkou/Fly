import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root
    anchors.fill: parent

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
        clip: true

        ListModel {
            id: model

            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
        }

        Rectangle {
            anchors.fill: parent

            Component {
                id: contactDelegate

                Rectangle {
                    width : root.width
                    height: 40
                    anchors.margins: 10
                    border.width: 0.5
                    border.color: "lightgrey"

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: name
                            anchors.margins: 5
                            anchors.left: parent.left
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            backend.setCurrentPage("itemdetails.qml")
                        }
                    }
                }
            }

            ListView {
                anchors.fill: parent
                model: model
                delegate: contactDelegate
                focus: true
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
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
