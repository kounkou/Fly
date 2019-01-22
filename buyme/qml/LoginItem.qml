////////////////////////////////////////////////////////////////////////
///
/// Copyright (c) 2018, Wasserman lab
///
/// FILE        main.cpp
///
/// DESCRIPTION This is the declarative entry file of the project.
///             The main file will initialize the User Interface
///
/// Initial version @ Godfrain Jacques KOUNKOU
///
////////////////////////////////////////////////////////////////////////

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Rectangle {
    id: root

    anchors.fill: parent

    Component.onCompleted: {
        menu.currentPageName  = "Login"
        menu.previousPageLink = false
    }

    PopupItem {
        id: popup
    }

    MenuBarItem {
        id: menu
        height: 50
        width: parent.width
    }

    Rectangle {
        id: username
        height: 50
        anchors.top: menu.top
        anchors.topMargin: 150
        width: parent.width - 10
        anchors.left: parent.left
        anchors.leftMargin: 5

        Column {
            id: usernameCol
            anchors.centerIn: parent

            TextField {
                id: usernameText
                placeholderText: qsTr("Username")
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 30
                    border.width: 1
                    border.color: usernameText.focus ? "#000000" : "lightgray"
                    radius: 5
                }
            }
            Text {
                id: infoUsername
                font.pixelSize: 10
                color: "lightgray"
                text: qsTr("requires a username or email")
            }
        }
    }
    Rectangle {
        id: password

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: username.bottom
        anchors.topMargin: 10
        height: 50
        width: parent.width - 10

        Column {
            id: passCol
            anchors.centerIn: parent

            TextField {
                id: passText
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 30
                    border.width: 1
                    border.color: passText.focus ? "#000000" : "lightgray"
                    radius: 5
                }
            }
            Text {
                id: infoPass
                font.pixelSize: 10
                color: "lightgray"
                text: qsTr("requires a password")
            }
        }
    }
    Rectangle {
        id: login

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: password.bottom
        anchors.topMargin: 10
        height: 50
        width: parent.width - 10

        Button {
            id: loginButton
            anchors.centerIn: parent
            height: 25
            onClicked: {
                if (usernameText.text === "" || passText.text === "") {
                    popup.open()
                    popup.lcontrol.visible = false
                    popup.popupMessage.text = "Wrong Username or Password"
                    popup.rcontrol.text = "OK"
                    return
                }
                stackView.push("qrc:/Overview.qml")
            }

            contentItem: Text {
                text: "login"
                font.pixelSize: 16
                opacity: enabled ? 1.0 : 0.3
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: "#000000"
                radius: 5
            }
        }
    }
}
