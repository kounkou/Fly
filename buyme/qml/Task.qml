import QtQuick 2.0

Rectangle {
    id: root

    anchors.fill: parent

    Component.onCompleted: {
        menu.currentPageName = "Task"
    }

    MenuBarItem {
        id: menu
        previousPageLink: true
        height: 50
        width: parent.width
    }
}
