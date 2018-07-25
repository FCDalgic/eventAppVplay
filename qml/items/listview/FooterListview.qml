import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    id: listFooterContainer;
    width: appWindow.width
    height: appWindow.height / 20;
    color: "transparent";

    property string text: "";
    Rectangle
    {
        id: footerContent;
        width: parent.width  * 0.4;
        height: footerIcerik.contentHeight;
        anchors.horizontalCenter: parent.horizontalCenter;
        color: "transparent";
        radius: height/2;

        Text {
            id: footerIcerik
            text:  listFooterContainer.text; //categoryResults.eventList.length + " Etkinlik";
            height: parent.height;
            //                    width: parent.width;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            color: "white";
            font.bold: true;
            anchors.centerIn: parent;
        }
    }
}
