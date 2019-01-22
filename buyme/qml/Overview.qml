import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root

    anchors.fill: parent

    property alias  jsMod: jsMod
    property string side : ""

    function saveElement(item, details, color) {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS
                saved_tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, details TEXT, color TEXT)')
            console.log('added element ' + item + ' with : ' + color)
            tx.executeSql('INSERT INTO saved_tasks (title, details, color) VALUES(?, ?, ?)', [item, details, color])
        })
    }

    function clearAll() {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
                    function (tx) {
                        // tx.executeSql('DROP TABLE tasks;')
                        tx.executeSql('DELETE FROM tasks')
                    }
                    )
    }

    function removeElement(item) {
        console.log("removing a task " + item)
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
                    function (tx) {
                        var rs = tx.executeSql('SELECT * FROM tasks')
                        for (var i = 0; i < rs.rows.length; i++) {
                            if (i === item) {
                                console.log('deleting item ' + rs.rows.item(i).title)
                                tx.executeSql("DELETE FROM tasks WHERE title='" + rs.rows.item(i).title + "'")
                            }
                        }
                    }
                    )
    }

    function addElement(item, details, color) {
        console.log("adding a task")
        jsMod.append({"item": item, "details" : details, "itemcolor" : color })
    }

    function createDatabase() {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
                    function (tx) {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS
                   tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, details TEXT, color TEXT)')
                    }
                    )
    }

    function addElementInDatabase(title, details, color) {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
                    function (tx) {
                        tx.executeSql('INSERT INTO tasks (title, details, color) VALUES(?, ?, ?)', [title, details, color])
                    }
                    )
    }
    function loadTaskFromStorage() {
        var db = LocalStorage.openDatabaseSync("tasksDB", "1.0", "Tasks saved", 1000000)

        db.transaction(
                    function (tx) {
                        var rs = tx.executeSql('SELECT * FROM tasks')
                        var r = ""
                        for (var i = 0; i < rs.rows.length; i++) {
                            addElement(rs.rows.item(i).title,
                                       rs.rows.item(i).details,
                                       rs.rows.item(i).color)
                        }
                    }
                    )
    }

    function getColor() {
        return "#9E9E9E"
        // return '#'+ Math.floor(Math.random()*16777215).toString(16)
    }

    AddItem {
        id: popup

        onClosed: {
            if (popup.status) {
                var col = getColor()
                addElementInDatabase(popup.title.text, popup.details.text, col)
                addElement(popup.title.text, popup.details.text, col)
                popup.title.clear()
                popup.details.clear()
                popup.status = false
            }
        }
    }

    Component.onCompleted: {
        menu.currentPageName = "Overview"
        list.visible = true
        createDatabase()
        loadTaskFromStorage()
    }

    Timer {
        interval: 500
        running : true
        repeat  : true
        onTriggered: {
            if (dataChange) {
                jsMod.clear()
                loadTaskFromStorage()
                dataChange = false
            }
        }
    }

    MenuBarItem {
        id: menu
        previousPageLink: false
        forwardButton: true
        height: 50
        width: parent.width

        /*
        Button {
            id: clearButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 20

            onClicked: {
                jsMod.clear()
                clearAll()
            }

            contentItem: Text {
                text: "x"
                font.pixelSize: 23
                font.bold: true
                opacity: enabled ? 1.0 : 0.3
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.family: robotoLight.name
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: "transparent"
            }
        }
        */

        forwardButtonArea.onClicked: {
            // popup.open()
        }
    }

    ListView {
        id: list

        Text {
            id: invite
            visible: jsMod.count > 0 ? false : true
            text: qsTr("It looks empty here, add a task !")
            color: "#818181"
            anchors.centerIn: parent
            font.family: robotoLight.name
        }

        Button {
            id: add
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 16
            width: 50
            height: 50
            z: 100

            Text {
                text: qsTr("+")
                anchors.centerIn: parent
                color: "#f9f9f9"
                font.family: robotRegular.name
                font.pixelSize: 30
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.width: 0
                color: add.pressed ? "#818181" : "#616161"
                radius: width / 2
            }

            onClicked: {
                popup.open()
            }
        }

        anchors.top: menu.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        clip: true

        delegate : SwipeDelegate {
            id: control
            clip: true
            height: 58

            onClicked: {
                console.log("clicked item " + index)
                stackView.push("qrc:/Task.qml")
                itemTitle = item
                itemDetail = details
            }

            // text: qsTr("SwipeDelegate")
            //////////////////////////////////////////////////

            background: Rectangle {
                id: container
                color : control.pressed ? "#f5f5f5" : "#ffffff"
                height: control.height
                width : parent.width
                anchors.verticalCenter: parent.verticalCenter
                clip: true

                Rectangle {
                    id: taskColor
                    width : 40
                    height: 40
                    radius: width * 0.5
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: container.verticalCenter
                    color: itemcolor

                    Text {
                        id: itemName
                        text: qsTr(item.substr(0, 1))
                        color: "#ffffff"
                        anchors.centerIn: parent
                        font.family: robotoLight.name
                    }
                }

                Text {
                    id: title
                    text: qsTr(item)
                    anchors.left: taskColor.right
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    font.pixelSize: 14
                    font.family: robotRegular.name
                }
                Text {
                    id: detail
                    text: qsTr(details.replace(/[\r\n]/g, " ").substr(0, 35))
                    anchors.top: title.bottom
                    anchors.left: taskColor.right
                    anchors.leftMargin: 16
                    font.pixelSize: 12
                    color: "gray"
                    clip: true
                    font.family: robotoLight.name
                }

                // next occurence
                Text {
                    id: metadata
                    font.family: robotoLight.name
                    anchors.right: parent.right
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("")
                }
            }
            //////////////////////////////////////////////////

            Rectangle {
                id: separator
                width : root.width - 20
                height: 1
                color : "lightgray"
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            anchors.right: parent.right
            width: list.width

            Component {
                id: componentRight

                Rectangle {
                    color: control.swipe.complete ? "#B00020" : "#B00020"
                    width: parent.width
                    height: parent.height - 1
                    clip: true
                    y: separator.y + 1


                    Component.onCompleted: {
                        side = "right"
                    }

                    Label {
                        text: qsTr("Delete")
                        font.bold: true
                        color: "#ffffff"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 16
                        font.family: robotoLight.name
                    }
                }
            }

            Component {
                id: componentLeft

                Rectangle {
                    color: "#2000B0"
                    width: parent.width
                    height: parent.height - 1
                    clip: true
                    y: separator.y + 1

                    Component.onCompleted: {
                        side = "left"
                    }

                    Label {
                        text: qsTr("Archive")
                        font.bold: true
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 16
                        font.family: robotoLight.name
                    }
                }
            }

            Timer {
                id: undoRightTimer
                interval: 10
                onTriggered: {
                    console.log("undo left, removeElement")
                    removeElement(index)
                    jsMod.remove(index)
                }
            }

            Timer {
                id: undoLeftTimer
                interval: 10
                onTriggered: {
                    console.log("undo right, saveElement")
                    saveElement(itemTitle, itemDetail, itemColor) // archive
                    removeElement(index)
                    jsMod.remove(index)
                }
            }

            swipe.right: componentRight
            swipe.left: componentLeft

            swipe.onCompleted: {
                itemTitle  = item
                itemDetail = details
                itemColor  = itemcolor
                side === "right" ? undoRightTimer.start() : undoLeftTimer.start()
            }

            contentItem: Text {
                text: control.text
                font: control.font
                width: list.width
                elide: Text.ElideRight
                visible: control.text
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter

                Behavior on x {
                    enabled: !control.down
                }
            }
        }

        model: ListModel { id: jsMod }

        remove: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 125 }
                NumberAnimation { property: "height"; to: 0; easing.type: Easing.InOutQuad }
            }
        }

        displaced: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 125 }
                NumberAnimation { property: "y"; easing.type: Easing.InOutQuad }
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
