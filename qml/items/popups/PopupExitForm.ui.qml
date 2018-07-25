import QtQuick 2.4

Item {
    width: 400
    height: 400

    Rectangle {
        id: rectangle
        x: 100
        y: 65
        width: 200
        height: 92
        color: "#b3b3b3"
        radius: height / 5
        Text {
            id: text1
            x: 8
            y: 11
            width: 184
            height: 24
            text: qsTr("Uygulamadan çıkmak istediğinize emin misiniz?")
            elide: Text.ElideLeft
            wrapMode: Text.WordWrap
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle1
            x: 8
            y: 53
            width: 90
            height: 30
            color: "black"
            anchors.verticalCenterOffset: 22
            anchors.horizontalCenterOffset: -47
            radius: height / 5

            Text {
                id: text2
                x: 34
                y: 8
                text: qsTr("Evet")
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            id: rectangle2
            x: 102
            y: 53
            width: 90
            height: 30
            color: "black"
            opacity: 0.3
            Text {
                id: text3
                x: 34
                y: 8
                text: qsTr("Hayır")
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
            }
        }
    }
}
