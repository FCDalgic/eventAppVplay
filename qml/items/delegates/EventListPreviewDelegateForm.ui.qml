import QtQuick 2.4

Item {
    width: 400
    height: 400
    property alias column: column

    Column {
        id: column
        anchors.fill: parent
    }
}
