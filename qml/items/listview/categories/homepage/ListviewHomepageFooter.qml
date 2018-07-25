import QtQuick 2.0
import "../../../../items"
Rectangle
{
    width: parent.width;
    height: appWindow.height / 10;
//    visible: homepageFlick.showMoreVisibility //  homepageFlick.state == "loaded";
    color: "transparent";
    Rectangle
    {
        id : showMoreText;
        width: parent.width;
        height:  appWindow.height / 20;
        anchors.top: parent.top;
        color: "transparent";
        Text
        {
            width: parent.width;
            height: parent.height;
            text: qsTr("More");
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            color: "white";

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    appWindow.categorySelected("all");
                }

            }
        }


    }
    Rectangle
    {
        id : showMoreIcon;
        width: parent.width;
        height:  appWindow.height / 20;
        color: "transparent";
        anchors.bottom: parent.bottom;
        ColorableIcon
        {
            anchors.centerIn: parent;
            //                        width: parent.width / 6;
            width : appWindow.width * 0.0498;
            height: appWindow.height * 0.0315;
            wRatio: 0.8;
            hRatio: 0.8;
            color: "transparent";
            overlayColor: "white";
            iconPath: "../../assets/images/fa/down-x64.png";

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    appWindow.categorySelected("all");
                }

            }
        }
    }


}
