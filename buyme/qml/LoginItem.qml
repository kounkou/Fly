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

    function validateInput() {
        if (usernameText.text === "") {
            infoUsername.color = "#ff0000"
            return
        } else {
            infoUsername.color = "lightgray"
        }

        if (passText.text === "") {
            infoPass.color = "#ff0000"
            return
        } else {
            infoPass.color = "lightgray"
        }

        stackView.push("qrc:/Overview.qml")
    }

    Component.onCompleted: {
        menu.currentPageName  = "Login"
        menu.previousPageLink = false
        menu.forwardButton    = false                
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
                placeholderText: qsTr("Username*")
                font.family: robotoLight.name
                font.pixelSize: 12
                background: Rectangle {
                    id: usernamePers
                    implicitWidth: 200
                    implicitHeight: 30
                    border.width: 1
                    border.color: "lightgray"
                    radius: 5
                    smooth: true
                    antialiasing: true
                }
            }
            Text {
                id: infoUsername
                font.family: robotoLight.name
                font.pixelSize: 10
                color: "lightgray"
                text: qsTr("*required")
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
                font.family: robotoLight.name
                placeholderText: qsTr("Password*")
                echoMode: TextInput.Password
                font.pixelSize: 12
                background: Rectangle {
                    id: passPers
                    implicitWidth: 200
                    implicitHeight: 30
                    border.width: 1
                    border.color: "lightgray"
                    radius: 5
                    smooth: true
                }

                // on enter
                Keys.onReturnPressed: {
                    console.log("Enter pressed")
                    validateInput()
                }
            }
            Text {
                id: infoPass
                font.family: robotoLight.name
                font.pixelSize: 10
                color: "lightgray"
                text: qsTr("required*")
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
                validateInput()
            }

            contentItem: Text {
                font.family: robotoLight.name
                text: "login"
                font.pixelSize: 16
                font.bold: true
                opacity: enabled ? 1.0 : 0.3
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                smooth: true
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: "#616161"
                radius: 5
                smooth: true
            }
        }
    }
}
