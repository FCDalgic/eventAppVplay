import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0

import "../items"

Rectangle {
    id: myButton
    property bool isActive: true;
    property string iconPath: "";
    property bool showCounter: false;
    property string overlayColor: appWindow.colorMain;
    property string text: "";
    property bool showMarker: true;
    property real counter: 0;

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter


    signal btnClicked();
    // Material.buttonPressColor
//    Rectangle {
//        visible: true
//        height: myButton.height
//        width: myButton.width
//        color:  "lightgray";
//    }

    Row {
        spacing: 0
        topPadding: 0
        leftPadding: 16
        rightPadding: myButton.counter > 0 ? 24 :  16
        anchors.margins: 2;
        anchors.verticalCenter: parent.verticalCenter

        Item {
            anchors.verticalCenter: parent.verticalCenter
            width:  myImage.width + 32;
            height: myImage.height;
            ColorableIcon
            {
                id: myImage
                width:  myButton.height;
                height: myButton.height;

                iconPath:   myButton.iconPath;
                opacity: 0.7 // Todo sonradan dinamik yapılabilir.
                color: "transparent";
                overlayColor: appWindow.colorMain;
            }
        } // image and coloroverlay
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: myButton.text;
            opacity: 0.87 // isActive? 1.0 : 0.7
//            color: appWindow.colorDrawerIcon; // flatButtonTextColor
            font.pixelSize: myButton.height / 3;
            font.weight: Font.Medium
        } // label
    } // row
    Label {
        rightPadding: 16
        visible: myButton.counter > 0 ? true : false;
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        text:  myButton.counter.toString();
        opacity: 0.87 // isActive? 1.0 : 0.7
        color: "gray"
        font.pixelSize: 18
        font.weight: Font.Medium
    } // label
    Rectangle {
        visible: false;
        anchors.right: parent.right
        width: 6
        height: parent.height
        color: "pink"
    }
    MouseArea
    {
        anchors.fill: parent;
        onClicked: {
            navigationBar.close();
            btnClicked();
        }
    }


} // myButton
