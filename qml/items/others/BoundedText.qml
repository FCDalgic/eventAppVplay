import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

Rectangle
{
    id:  textContainer
    width: parent.width
    height: textContent.contentHeight;

    property string text: "";

    signal clicked();
    Text {
        id: textContent;
        anchors.fill: parent;
        width: parent.width;
        horizontalAlignment: Text.AlignJustify;
        wrapMode: Text.WordWrap;
        text: parent.text;
        onLinkActivated: parent.clicked();
    }

    color:"transparent";
}
