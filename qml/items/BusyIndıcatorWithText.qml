import QtQuick 2.9
import QtQuick.Controls 2.2
Rectangle
{
    id : bussyContaier;
    width: parent.width/4;
    height: parent.height * 0.15;
    visible: true;
    property bool running: true;
    property string text: "";
    BusyIndicator
    {
        id : bussy
        running: parent.running;
        width:  height;
        anchors.horizontalCenter: parent.horizontalCenter;
        height: parent.height * 0.66;
        anchors.top: parent.top;
    }

    Text {
        id: busyText
        text: parent.text;
        width: parent.width;
        height: parent.height / 3;
        anchors.bottom: parent.bottom;
    }

}
