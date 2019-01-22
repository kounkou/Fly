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
import QtQuick.Controls 1.4
import QtQuick.Controls.Material 2.2

ApplicationWindow {

    id: root
    objectName: "window"
    visible: true
    width: 325
    height: 500
    title: qsTr("BuyMe")

    property string itemTitle : ""
    property string itemDetail: ""
    property string itemColor : ""
    property bool   dataChange: false

    color: "#161616"

    // After loading show initial Login Page
    Component.onCompleted: {
        stackView.push({item: componentMap[label.text]});
    }

    FontLoader {
        id: robotoLight
        source: "qrc:/Roboto-Light"
    }

    FontLoader {
        id: robotRegular
        source: "qrc:/Roboto-Regular"
    }

    property Component login    : LoginItem    {}
    property Component register : RegisterUser {}
    property Component overview : Overview     {}
    property Component splash   : Splashscreen {}
    property Component task     : Task         {}

    property var componentMap: {
        "LoginItem"    : login,
        "RegisterUser" : register,
        "Overview"     : overview,
        "Splashscreen" : splash,
        "Task"         : task
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: init

        Rectangle {
            id: init
            width: 300
            height: 300
            color: "grey"

            Text {
                id: label
                text: "Splashscreen"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (stackView.depth == 1) {
                        stackView.push({item: componentMap[label.text]});
                        stackView.currentItem.forceActiveFocus();
                    }
                }
            }
        }
    }
}
