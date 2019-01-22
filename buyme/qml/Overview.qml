
import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {

    id: root
    anchors.fill: parent

    Component.onCompleted: {
        menu.currentPageName = "Overview"
        list.visible = true
    }

    MenuBarItem {
        id: menu
        previousPageLink: false
        height: 50
        width: parent.width
    }

    ListModel {
        id: model
        ListElement {
            item: "Algorithms"
            details: "String permutation, gcd"
            itemcolor: "#356859"
        }
        ListElement {
            item  : "Finance"
            details: "Invest, save, expenses"
            itemcolor: "#216821"
        }
        ListElement {
            item: "Vocabulary"
            details: "Welp, wigging, thermostat"
            itemcolor: "#152050"
        }
        ListElement {
            item: "Spanish"
            details: "Carino, Coco, Impressar"
            itemcolor: "#130070"
        }
        ListElement {
            item: "Moving out"
            details: "Luggages, Clothes, etc."
            itemcolor: "#154050"
        }
        ListElement {
            item  : "Finance"
            details: "Invest, save, expenses"
            itemcolor: "#216821"
        }
        ListElement {
            item: "Vocabulary"
            details: "Welp, wigging, thermostat"
            itemcolor: "#ffab00"
        }
        ListElement {
            item: "Spanish"
            details: "Carino, Coco, Impressar"
            itemcolor: "#130070"
        }
        ListElement {
            item: "Moving out"
            details: "Luggages, Clothes, etc."
            itemcolor: "#00aaff"
        }
    }

    ListView {
        id: list
        visible: false
        anchors.top: menu.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        clip: true

        model: model
        delegate: Column {
            id: delegate

            Rectangle {
                id: listItem

                height: 70
                width : parent.width
                color : "#ffffff"

                Rectangle {
                    id: taskColor
                    width : 40
                    height: width
                    radius: width * 0.5
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    color: itemcolor
                }

                Text {
                    id: title
                    text: qsTr(item)
                    anchors.left: taskColor.right
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    font.pixelSize: 16
                    font.bold: true
                }
                Text {
                    id: detail
                    text: qsTr(details)
                    anchors.top: title.bottom
                    anchors.topMargin: 5
                    anchors.left: taskColor.right
                    anchors.leftMargin: 10
                    font.pixelSize: 12
                    color: "gray"
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    onClicked: {
                        delegate.ListView.view.currentIndex = index;
                        console.log('clicked index          : ' + index)
                        console.log('[item, details, color] : [' + item + ', [' + details + '], ' + itemcolor + ']')

                        stackView.push("qrc:/Task.qml")
                    }
                }
            }

            Rectangle {
                width : root.width - 20
                height: 1
                color : "lightgray"
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }
}
