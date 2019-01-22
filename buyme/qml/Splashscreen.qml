
import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {

    id: root
    anchors.fill: parent
    color: "#ffffff"

    Column {
        id: logo
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5

        Rectangle {
            id: r1
            width: 50
            height: 10
            color: "#001122"
            radius: 5
        }

        Rectangle {
            id: r2
            width: 50
            height: 10
            color: "#335588"
            radius: 5
            rotation: 90
        }

        Rectangle {
            id: r3
            width: 50
            height: 10
            color: "#131321"
            radius: 5
        }
    }

    Text {
        id: appName
        anchors.top: logo.bottom
        anchors.topMargin: 10
        text: "fibrain"
        color: "#000000"
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.5
        font.family: robotoLight.name
    }

    Timer {
        interval   : 4000;
        running    : true;
        repeat     : false
        onTriggered: {
            root.visible = false

            stackView.push("qrc:/LoginItem.qml")
        }
    }

    Text {
        id: copyright
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        text: "Copyright(c) 2018"
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.5
        font.pixelSize: 12
        font.family: robotoLight.name
    }
}
