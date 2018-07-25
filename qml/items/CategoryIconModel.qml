import QtQuick 2.0

Rectangle {
    id: categoryIcon
    property string imageSource: "";
    property string signalName : "";
    property string title: "";
    property string colorStr: "";

    anchors.verticalCenter:  parent.verticalCenter

    signal categoryClicked();

    radius: width / 10;

    RoundImage {
        id: icon;
        source:  imageSource;
        sourceSize: Qt.size(parent.width, parent.height);
        anchors.centerIn: parent;

        width: parent.width;
        height: parent.height;
    }

    Text {

//        height: parent.height;
//        width: parent.width;

        width: parent.width * .6;
        font.pointSize: 11;
        horizontalAlignment: Text.AlignHCenter;
        anchors.horizontalCenter: categoryIcon.horizontalCenter;
        anchors.bottom : parent.bottom;
        anchors.bottomMargin: parent.height / 8;

        text: title;
        color: "white";

        font.bold: true;

        wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
    }

    MouseArea
    {
        anchors.fill: parent;
        onClicked: categoryClicked();
    }
}
