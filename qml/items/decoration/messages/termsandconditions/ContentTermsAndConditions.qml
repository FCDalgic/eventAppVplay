import QtQuick 2.0
Rectangle
{

    height: amacMetni.contentHeight;
    width: parent.width
    property string text: "";

    Text {
        anchors.centerIn: parent;
        id : amacMetni
        width: parent.width;
        horizontalAlignment: Text.AlignJustify;
        wrapMode: Text.WordWrap;
        text: parent.text;
    }
    color: "transparent";
}
