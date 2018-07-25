import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Rectangle {

    id: textFieldWithIconAndHeaderContainer;
    property string iconSrc: "";
    property real  iconWRatio: 0.1;

    property string headerText: "";
    property real  headerWRatio : 0.22;
    property real  headerPointSizeRatio : 0.13;

    property string detailText: "";
    property real   detailWRatio : 1 - headerWRatio - iconWRatio;
    property real   detailPointSizeRatio : 0.2;

    visible: (detailText.length > 5 || headerText.length > 2) ? true : false;

    property real iconHeight: 30;
    property bool isLink: false;
    property bool isLongText: false;
    property string linkFontColor: appWindow.colorMain;
    height:  detailText.length > 0 ?(isLongText ?  longTextContainer.height  : detail.height) :header.height;

    ColorableIcon
    {
        id : telephoneIcon;
        width : height;
        anchors.left: parent.left;
        height: headerText.length > 0 ?  header.height: 0;
        iconPath: parent.iconSrc;
        visible: headerText.length > 0 ? true : false;

        wRatio: 0.7;
        hRatio: 0.7;
    }



    Text
    {
        id: header;
        anchors.left: telephoneIcon.right;
        width: parent.width * parent.headerWRatio;
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignLeft;
        color: appWindow.colorMain;
        text: parent.headerText;

    }



    Text
    {
        id: detail;
        visible: parent.isLongText ? false : !parent.isLink;
        anchors.left: header.right;
        width: parent.width * parent.detailWRatio;
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignLeft;
        text: parent.detailText;


    }


    Text
    {
        id: detailLink;
        width: parent.width * parent.detailWRatio;
        anchors.left: header.right;
        visible: parent.isLongText ? false :  parent.isLink;
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter;
        horizontalAlignment: Text.AlignLeft;
        textFormat: Text.RichText
        text: parent.detailText;
        color: parent.linkFontColor;
        MouseArea
        {
           anchors.fill: parent;
           onClicked:
           {
               console.log(" link activated");
               Qt.openUrlExternally(detailLink.text);
           }
        }
    }

    Rectangle
    {
        id : longTextContainer;
        width: parent.width * parent.detailWRatio;
        anchors.left: header.right;
        visible: parent.isLongText;
        height: longText.height + showMoreText.height;
        property bool showFull: false;

        Text
        {
            id: longText;
            wrapMode: Text.WordWrap
            width: parent.width;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            textFormat: Text.RichText
            text:  parent.showFull ?  textFieldWithIconAndHeaderContainer.detailText : parent.cutText(textFieldWithIconAndHeaderContainer.detailText );
            anchors.top: parent.top;
        }

//        ShowMoreDetails
//        {
//            id: showMoreText;
//            visible: textFieldWithIconAndHeaderContainer.detailText.length >  150 ? true : false;
//            anchors.bottom: parent.bottom;
//            color: "transparent";
//            onClicked:
//            {
//                longTextContainer.showFull = pStatus;
//            }
//        }

        Text
        {
            id: showMoreText;
            wrapMode: Text.WordWrap
            width: parent.width;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignLeft;
            textFormat: Text.RichText
            text:  parent.showFull ? "daha az..."  : "daha fazla...";
            color: appWindow.colorMain;
            anchors.bottom: parent.bottom;
            visible: textFieldWithIconAndHeaderContainer.detailText.length >  150 ? true : false;


        }

        function cutText(pName)
        {
            var output = pName;
            if (output.length > 150)
            {
                var parts = output.split(" ");
                var count = parts.length;

                output = parts[0];
                for (var i = 1 ; i < count; i++)
                {
                    var str   = parts[i];
                    var total = output.length  + str.length;

                    if (total <= 150)
                        output +=  " " + parts[i];
                    else
                    {
                        break;
                    }
                }
            }
            return output;
        }

        MouseArea
        {
           anchors.fill: parent;
           onClicked:
           {
               longTextContainer.showFull = !longTextContainer.showFull;
           }
        }
    }

    Item
    {
        Layout.fillWidth: true;
        enabled: false;
        height: parent.height
    }
}
