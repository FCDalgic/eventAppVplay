import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

import "../listview"
import "../../items"

Rectangle
{

    anchors.horizontalCenter: parent.horizontalCenter;
    height: innerHeading.height + 15;
    color: "transparent";
    Rectangle {
        id: innerHeading;
        width: parent.width;
        height: sectionContent.height;
        anchors.top:parent.top;
        color: "transparent";


        Rectangle {
            id: space1;
            width: parent.width * 0.1;
            height: parent.height;
            //                color: "transparent";
        }

        ColorableIcon
        {
            id: border1;
            anchors.left: space1.right;
            width: parent.width *0.25;
            height: parent.height;
            wRatio: 0.9;
            hRatio: 0.6;
            iconPath:"../../assets/images/fa/border5-960x480.png";
        }


        Rectangle
        {
            id: sectionContent;
            anchors.left:  border1.right;
            width: parent.width  * 0.3;
            height: sectionIcerik.contentHeight;

            Text {
                id: sectionIcerik
                text: section
                font.bold: true
                width: parent.width;
                horizontalAlignment: Text.AlignHCenter;
                color: appWindow.colorMain;
                anchors.centerIn: parent;
            }
        }


        ColorableIcon
        {
            id: border2;
            anchors.left: sectionContent.right;
            width: parent.width *0.25;
            height: parent.height;
            wRatio: 0.9;
            hRatio: 0.6;
            iconPath:"../../assets/images/fa/border5-right-960x480.png";
        }

        Rectangle {
            anchors.left: border2.right;
            width: parent.width *0.1;
            height: parent.height;
        }

    }

}
