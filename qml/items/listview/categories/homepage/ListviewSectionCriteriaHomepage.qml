import QtQuick 2.0

Rectangle {
    width: parent.width // * .95;
    anchors.horizontalCenter: parent.horizontalCenter;
    height: hebele.height + spaceSection.height;
    color: "transparent";
    radius: height/5;

    Rectangle
    {
        id :hebele;
        width: parent.width;
        radius: 15;
        height: sectionContent.height;
        color: "white";
        Rectangle
        {
            id: sectionContent;
            //                        anchors.left: parent.left;
            //                        anchors.leftMargin: parent.width / 25;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: sectionIcerik.contentHeight;
            width: parent.width;
            color: "transparent";
            Text {
                id: sectionIcerik
                text: calcSectionString();
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                //                        font.family: appWindow.fontMain.name;
                width: parent.width;
                color: "black";

                anchors.centerIn: parent;
            }
        }
    }

    Rectangle
    {
        id: spaceSection;
        radius: 15;
        color:  "transparent";
        height: dp(10);
        width: parent.width;
    }



    function calcSectionString()
    {
        var curDate = Qt.formatDate(new Date(), "dd.MM.yyyy");
        var curDay = curDate.split(".")[0];

        var splited = section.split(".");
        var givenDay = splited[0];

        var output = "";


        if (givenDay == curDay)
            output = qsTr("Bugün");
        else if (parseInt(givenDay) == (parseInt(curDay) + 1))
            output = qsTr("Yarın");
        else
            output = section;

        return output;
    }

}


