import QtQuick 2.0

Rectangle
{
    id: header;
    height: headerContent.contentHeight;
    width: parent.width
    property string text: "";

    Text {
        id: headerContent;
        anchors.centerIn: parent;
        width: parent.width;
        font.bold: true;
        horizontalAlignment: Text.AlignLeftg;
        wrapMode: Text.WordWrap;
        color: appWindow.colorMain;
        text: parent.text;
    }

    color: "transparent";
}
