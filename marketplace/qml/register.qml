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
    }

    Rectangle {
        id: body
        anchors.top: head.bottom
        color: "lightgrey"
        anchors.margins: 0
        height: 10 * root.height / 12
        width: root.width

        TextField {
            id: username
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: (pass.height + confirmPass.height + validate.height) / 2
            width : 200
            height: 40
            placeholderText: "username"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12

            /*
            onTextChanged: acceptableInput ? userStyle.border.color = "green"
                                           : userStyle.border.color = "red"
            */

            background: Rectangle {
                id: usernameStyle
                implicitWidth: 200
                implicitHeight: 30
                border.width: 1
                border.color: "lightgray"
                radius: 5
                smooth: true
                antialiasing: true
            }
        }

        TextField {
            id: user
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: username.bottom
            width : 200
            height: 40
            placeholderText: "email"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            validator: RegExpValidator {
                regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            }

            /*
            onTextChanged: acceptableInput ? userStyle.border.color = "green"
                                           : userStyle.border.color = "red"
            */

            background: Rectangle {
                id: userStyle
                implicitWidth: 200
                implicitHeight: 30
                border.width: 1
                border.color: "lightgray"
                radius: 5
                smooth: true
                antialiasing: true
            }
        }

        TextField {
            id: pass
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: user.bottom
            width : 200
            height: 40
            placeholderText: "password"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            echoMode: TextInput.Password
            passwordMaskDelay: 500

            background: Rectangle {
                id: passStyle
                implicitWidth: 200
                implicitHeight: 30
                border.width: 1
                border.color: "lightgray"
                radius: 5
                smooth: true
                antialiasing: true
            }
        }
        TextField {
            id: confirmPass
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: pass.bottom
            width : 200
            height: 40
            placeholderText: "retype password"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            echoMode: TextInput.Password
            passwordMaskDelay: 500

            background: Rectangle {
                id: confirmPassStyle
                implicitWidth: 200
                implicitHeight: 30
                border.width: 1
                border.color: "lightgray"
                radius: 5
                smooth: true
                antialiasing: true
            }
        }

        Button {
            id: validate
            anchors.top: confirmPass.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("register")

            onClicked: {
                if (pass.text == confirmPass.text && user.acceptableInput === true) {
                    backend.requestRegistration(user.text, pass.text)
                }
            }
        }

        Button {
            id: cancel
            anchors.top: validate.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("cancel")

            onClicked: {
                backend.setCurrentPage("login.qml")
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
