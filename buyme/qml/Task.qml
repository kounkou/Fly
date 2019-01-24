
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
        anchors.left: parent.left
        font.pixelSize: 14
        font.family: robotRegular.name
        text: qsTr(itemTitle) + " (2019/01/21)"
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
        anchors.margins: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true
        height: 350

        TextArea.flickable: TextArea {
            id: textareadetail
            font.family: robotoLight.name
            font.pixelSize: 12
            text: qsTr(itemDetail)
            wrapMode: Text.WordWrap
            selectByMouse : true

            background: Rectangle {
                implicitWidth : 290
                implicitHeight: 150
                border.width: 0
                radius: 5
                color: "#ffffff"
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

    Rectangle {
        id: recall1
        height: 10
        width: 50
        color: "lightgrey"
        anchors.top: sep2.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.left: parent.left
        radius: 5
        Text {
            id: r1Message
            text: qsTr("1 days")
            anchors.centerIn: parent
            font.family: robotoLight.name
            font.pixelSize: 10
        }
    }
    Rectangle {
        id: recall2
        height: 10
        width: 50
        color: "lightgrey"
        anchors.top: sep2.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.left: recall1.right
        radius: 5
        Text {
            id: r2Message
            text: qsTr("1 days")
            anchors.centerIn: parent
            font.family: robotoLight.name
            font.pixelSize: 10
        }
    }
    Rectangle {
        id: recall3
        height: 10
        width: 50
        color: "lightgrey"
        anchors.top: sep2.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.left: recall2.right
        radius: 5
        Text {
            id: r3Message
            text: qsTr("2 days")
            anchors.centerIn: parent
            font.family: robotoLight.name
            font.pixelSize: 10
        }
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
