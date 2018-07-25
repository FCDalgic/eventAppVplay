import QtQuick 2.0
import "../../"
Rectangle
{
    id: container;
    color: "transparent";
    property string iconPath : "";
    property string iconColor: "";
    property string iconText : "";
    property string textColor: "";

    ColorableRoundIcon
    {
        id: icon;
        width: parent.height  * 0.6667;
        height: parent.height * 0.6667;
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter;
        hRatio: 0.7;
        wRatio: 0.7;
        iconPath:parent.iconPath;
        overlayColor:  parent.iconColor;

    }

    Text
    {
        id : iconText;
        width: parent.width * .95;
        height: parent.height / 3;
        anchors
        {
            bottom: parent.bottom;
            horizontalCenter: parent.horizontalCenter;
            bottomMargin: ((1 - icon.hRatio) * icon.height) / 2;
        }

        text: parent.iconText;
        horizontalAlignment: Text.AlignHCenter
        color: parent.textColor;
    }


}
