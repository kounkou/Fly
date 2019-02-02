import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {

    id: root
    objectName: "window"
    visible: true
    width: 325
    height: 500
    color: "grey"
    title: backend.currentPage

    Loader {
        id: pageLoader
        source : backend.currentPage
    }
}
