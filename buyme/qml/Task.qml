
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0

Rectangle {

    id: root
    anchors.fill: parent

    Component.onCompleted: {
        menu.currentPageName = "Task"
    }

    function saveChangesInTable() {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
            function (tx) {
                var rs = tx.executeSql("UPDATE tasks SET details = \"" + textareadetail.text + "\" WHERE title = '" + itemTitle + "'")
            }
        )
        dataChange = true
    }

    MenuBarItem {
        id: menu
        previousPageLink: true
        forwardButton: false
        height: 50
        width: parent.width

        backButton.onClicked: {
            saveChangesInTable()
        }

        /*
        Button {
            id: saveChanges
            anchors.right: parent.right
            height: 20
            width: 20
            anchors.rightMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            text: "S"
            font.family: robotRegular.name
            font.pixelSize: 12
            font.bold: saveChanges.pressed ? true : false
            onClicked: {
                itemDetail = textareadetail.text
                saveChangesInTable()
            }
        }
        */
    }

    TextField {
        id: taskTitle
        anchors.top : menu.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: robotRegular.name
        text: qsTr(itemTitle)
        background: Rectangle {
            border.width: 0
        }
    }

    Rectangle {
        id: sep
        width : root.width - 20
        height: 1
        color : "lightgray"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: taskTitle.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Flickable {
        id: details

        anchors.top: sep.bottom
        anchors.margins: 16
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true
        height: 200

        TextArea.flickable: TextArea {
            id: textareadetail
            font.family: robotoLight.name
            font.pixelSize: 12
            text: qsTr(itemDetail)
            wrapMode: Text.WordWrap
            selectByMouse : true

            background: Rectangle {
                implicitWidth : 290
                implicitHeight: 90
                border.width: 0
                radius: 5
                color: "#d5d5d5"
                opacity: 0.12
            }


        }

        ScrollBar.vertical: ScrollBar { }
    }

    Rectangle {
        id: sep2
        width : root.width - 20
        height: 1
        color : "lightgray"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: details.bottom
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        id: tools
        visible: false
        anchors.top: sep2.bottom
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.topMargin: 16
        spacing: 5
        Button { id: rec1 }
        Button { id: rec2 }
    }
}
