import QtQuick 2.0

Rectangle
{
    id: container;

    property string iconPath: "";
    property string categoryName: "";
    property real fontPixelRatio: 0.5;
    property string overlayColor: appWindow.colorMain; // "#34495e";
    color : "transparent";
    Column
    {
        anchors.fill: parent;
        width: parent.width;
        height: parent.height;
        ColorableIcon
        {
            id: mainIcon;
            width: parent.height  * .65 // 0.54;
            height: parent.height * .65 // 0.54;
            iconPath: container.iconPath;
            anchors.horizontalCenter: parent.horizontalCenter;
            overlayColor:  "white";
            color: "transparent";
//            Rectangle
//            {
//                width: mainIcon.width
//                height: mainIcon.height;
//                anchors.centerIn: mainIcon;
//                radius:width/2;
//                z: -1;
//                color: appWindow.colorMain;
//            }
        }



        Text
        {
            width: parent.width   * 0.9;
            height: parent.height * 0.4;
            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: height *  container.fontPixelRatio;
            text: container.categoryName;
            anchors.horizontalCenter: parent.horizontalCenter;
            wrapMode: Text.WordWrap;
            color: "white";
        }

    }

    MouseArea
    {
        anchors.fill: parent;
        onClicked: parent.categorySelected(parent.categoryName);
    }

    signal categorySelected(string pCategoryName);

}
