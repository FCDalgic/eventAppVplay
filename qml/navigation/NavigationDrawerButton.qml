// 
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0


ItemDelegate {
    id: myButton
    property bool isActive: index == 1
    property string myIconFolder: iconFolder
    property int counter:1
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    height: 48
    width: myBar.width

    // Material.buttonPressColor
    Rectangle {
        visible: true
        height: myButton.height
        width: myButton.width
        color:  Material.listHighlightColor
    }

    Row {
        spacing: 0
        topPadding: 0
        leftPadding: 16
        rightPadding: modelData.showCounter? 24 :  16
        anchors.verticalCenter: parent.verticalCenter
        Item {
            anchors.verticalCenter: parent.verticalCenter
            width: 24 + 32
            height: 24
            Image {
                id: myImage
                width: 24
                height: 24
                horizontalAlignment: Image.AlignLeft
                anchors.verticalCenter: parent.verticalCenter
                source: "../../assets/images/"+myIconFolder+"/"+modelData.icon
                opacity: 0.7 // Todo sonradan dinamik yapılabilir.
            }
            ColorOverlay {
                id: colorOverlay
                visible: myButton.isActive
                anchors.fill: myImage
                source: myImage
                color: "green"
            }
        } // image and coloroverlay
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: modelData.name
            opacity: 0.87 // isActive? 1.0 : 0.7
            color: "steelblue" // flatButtonTextColor
            font.pixelSize: 14
            font.weight: Font.Medium
        } // label
    } // row
    Label {
        rightPadding: 16
        visible: modelData.showCounter
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        text: counter
        opacity: 0.87 // isActive? 1.0 : 0.7
        color: "gray"
        font.pixelSize: 14
        font.weight: Font.Medium
    } // label
    Rectangle {
        visible: modelData.showMarker
        anchors.right: parent.right
        width: 6
        height: parent.height
        color: "pink"
    }
    onClicked: {
        navigationBar.close()
    }
} // myButton
