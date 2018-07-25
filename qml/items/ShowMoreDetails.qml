import QtQuick 2.0

Rectangle
{
    width: parent.width;
    height: appWindow.height / 10;
//    visible: homepageFlick.showMoreVisibility //  homepageFlick.state == "loaded";
    color: "transparent";
    id: moreDetailsButton;
    property bool moreSelected: false;

    signal clicked(bool pStatus);

    onClicked:
    {
        if (pStatus)
        {
            showMoreText.anchors.bottom = bottom;
            showMoreIcon.anchors.top = top;
        }
        else
        {
            showMoreIcon.anchors.bottom = bottom;
            showMoreText.anchors.top = top;
        }
    }

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
            text: moreDetailsButton.moreSelected ? qsTr("Daha az"): qsTr("Daha fazla");
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            color: appWindow.colorMain;

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    moreDetailsButton.moreSelected = !moreDetailsButton.moreSelected;
                    moreDetailsButton.clicked(moreDetailsButton.moreSelected );
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
            overlayColor: appWindow.colorMain;
            iconPath: "../../assets/images/fa/down-x64.png";

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    moreDetailsButton.moreSelected = !moreDetailsButton.moreSelected;
                    moreDetailsButton.clicked(moreDetailsButton.moreSelected );
                }

            }
        }
    }


}
