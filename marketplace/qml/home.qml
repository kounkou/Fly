import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root

    height: 500
    width : 350
    anchors.centerIn: parent

    Text {
        id: name
        anchors.centerIn: parent
        text: qsTr("home")
    }
}
