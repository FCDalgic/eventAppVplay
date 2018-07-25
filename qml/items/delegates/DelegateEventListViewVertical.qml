import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/decoration/spaces"
Rectangle {

    id : elements
    width:   appWindow.width;
    height:  appWindow.height  * 0.15;
//    anchors.margins:  10;
//    anchors.horizontalCenter: appWindow.horizontalCenter;
    color: "white";

    //        anchors.horizontalCenter:  parent.horizontalCenter


    /// Resmin bulunacağı kısım.
    Rectangle
    {
        id: imageContainer;
        width: parent.width * 0.3;
        height: parent.height;
        color: "transparent";
        anchors.left: parent.left;

        ColorableIcon {
            id: eventImage
            iconPath:  ImageURL;


            wRatio: 0.90;
            hRatio: 0.90;

            width: parent.width;
            height: parent.height;
            color: "transparent";
            anchors.margins: 10;

            overlayColor: "transparent";
        }

    }

    /// Metinlerin bulunacağı kısım.
    Rectangle
    {
        id: detailsContainer
        width: parent.width * 0.62;
        height: parent.height;
        color: "transparent";
        anchors.left: imageContainer.right;

        IosSpaceBetweenContents
        {
             id: space1;
             height: parent.height *.05;
             anchors.top: parent.top
        }

        // Başlığın bulunacağı kısım
        Rectangle
        {
            id: eventHeader;
            width: parent.width;
            height: parent.height * 0.25;
            color: "transparent";
            anchors.top: space1.bottom;

            Text {
                id: eventName
                text: Name;
                color: appWindow.colorMain;
                width: parent.width;
                height: parent.height * .9;
                wrapMode: Text.WordWrap;
                verticalAlignment: Text.AlignVCenter;
                elide: Text.ElideRight;
                maximumLineCount: 2;
            }
        }

        IosSpaceBetweenTexts
        {
            id: space2;
            anchors.top : eventHeader.bottom;
        }

        // Etkinliğin Yerinin bulunacağı kısım.
        Rectangle
        {
            id: eventPlaceContainer;
            width: parent.width;
            height: parent.height * 0.15;
            color: "transparent";
            anchors.top: space2.bottom;

            Text {
                id: eventPlace
                font.pointSize: eventName.font.pointSize * 0.8;
                text:  "Yer   : " + model.modelData.Yer;

                width: parent.width;
                height: parent.height * .9;
                wrapMode: Text.WordWrap;
                verticalAlignment: Text.AlignVCenter;
                elide: Text.ElideLeft;
            }
        }

        IosSpaceBetweenTexts
        {
            id: space3;
            anchors.top : eventPlaceContainer.bottom;
        }

        // Etkinliğin Yerinin bulunacağı kısım.
        Rectangle
        {
            id: eventDateContainer;
            width: parent.width;
            height: parent.height * 0.15;
            color: "transparent";
            anchors.top: space3.bottom;

            Text {
                id: eventTime

                font.pointSize: eventName.font.pointSize * 0.8;
                text:  "Saat : " +  model.modelData.EventTime;

                width: parent.width;
                height: parent.height * .9;
                wrapMode: Text.WordWrap;
                verticalAlignment: Text.AlignVCenter;
                elide: Text.ElideLeft;
            }
        }


    }


    /// Ok'un bulunacağı kısım.
    Rectangle{
        id:  buttonContainer;
        width: parent.width * .05;
        height: parent.height;
        color: "transparent";
        anchors.left: detailsContainer.right;

        ColorableIcon {
            id: selectionIcon
            iconPath:  "../../assets/images/fa/forward-x64.png";
            width:   Math.min(parent.width , parent.height);
            height:  width // eventInfoContainer.height;
            wRatio:  0.8;
            hRatio:  0.8;
            anchors.centerIn: parent;
            color: "transparent";
            overlayColor: appWindow.colorMain;
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            appWindow.eventSelected(model);
        }
    }
} // Rectangle ends










//import QtQuick 2.7
//import QtQuick.Layouts 1.3
//import QtQuick.Controls 2.1
//import QtGraphicalEffects 1.0

//import "../../items"

//Rectangle {

//    id : elements
//    width:   appWindow.width;
//    height:  delegateContainer.height;
//    anchors.margins:  10;
//    color: "transparent";

//    //        anchors.horizontalCenter:  parent.horizontalCenter

//    // Burası sadece yataydaki eksende ortalamak için yapıldı.
//    Rectangle
//    {
//        id: delegateContainer;
//        height: delegateLayout.implicitHeight + (3 * border.width);
//        width: parent.width * .95;
//        anchors.horizontalCenter: parent.horizontalCenter;
//        border{
//            color: "#34495e";
//            width: height / 10;

//        }

//        radius: height / 10;

//        // Column
//        Column
//        {
//            id: delegateLayout;
//            width: parent.width;
//            anchors.margins: 5;
//            spacing: 2;

//            // Etkinliğin isminin bulunacağı satır.


//            // Etkinliğe ait resmin ve kismi bilgilerin bulunacağı yer.
//            Rectangle
//            {
//                Layout.fillWidth: true;
//                width: parent.width;
//                height: delegateDetailContaier.height;

//                Row
//                {
//                    id: delegateDetailContaier;
//                    width: parent.width;
//                    spacing: 8;

//                    // Etkinliğin resminin gösterileceği alan.
//                    property real diff: delegateLayout.height - eventName.height;

//                    Rectangle
//                    {
//                        id: eventImageContainer;
//                        width: parent.width * 0.3;
//                        height: parent.diff > eventInfoContainer.height ? parent.diff : eventInfoContainer.height;
//                        color: "transparent";

//                        Image
//                        {
//                            id: ikon;
//                            width: parent.width   * 1;//0.9;
//                            height: parent.height * 1;//0.9;
//                            source: ImageURL
//                            sourceSize: Qt.size(width, height);
//                            anchors.centerIn: parent;
//                            layer.enabled: true
//                            layer.effect: OpacityMask {
//                                maskSource: mask
//                            }

//                        }

//                        Rectangle {
//                            id: mask
//                            width: ikon.width
//                            height: ikon.height
//                            radius: width < height ? width / 10 : height /10;
//                            visible: false

//                        }
//                    }

////                    ColorableIcon {
////                        id: eventImage
////                        iconPath:  ImageURL;
////                        width: parent.width * 0.3;
////                        height: parent.diff > eventInfoContainer.height ? parent.diff : eventInfoContainer.height;

////                        wRatio: 1;
////                        hRatio: 1;

////                        anchors.margins: 10;

////                        overlayColor: "transparent";

////                    }


//                    // Etkinliğe ait diğer bilgilerin yer alacağı kısım

//                    Column
//                    {
//                        id: eventInfoContainer;
//                        width: parent.width * 0.62;
//                        anchors.margins: 10;
//                        // Etkinliği yeri, düzenleyen.
//                        Rectangle
//                        {
//                            id : containerName;
//                            Layout.fillWidth: true;
//                            width: parent.width;
//                            height: eventName.contentHeight;
//                            anchors.margins: 10;

//                            Text
//                            {
//                                id: eventName;
//                                text: Name;
//                                horizontalAlignment: Text.AlignJustify
////                                font.family: appWindow.fontMain.name;
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                verticalAlignment: Text.AlignBottom
//                                color: appWindow.colorMain;
//                            }
//                        }
//                        Rectangle
//                        {
//                            id: containerPlace;
//                            Layout.fillWidth:  true;
//                            width: parent.width;
//                            height: eventPlace.contentHeight + 8;

//                            Text
//                            {
//                                id: eventPlace;
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                anchors.left: parent.left;
////                                font.family: appWindow.fontMain.name;
//                                font.pointSize: eventName.font.pointSize * 0.8;
//                                text:  "Yer   : " + model.modelData.Yer;
//                                horizontalAlignment: Text.AlignLeft;
//                                verticalAlignment: Text.AlignVCenter;
//                            }
//                        }
//                        // Etkingliğin Saati
//                        Rectangle
//                        {
//                            id : containerDate;
//                            Layout.fillWidth:  true;
//                            width: parent.width;
//                            height: eventTime.contentHeight + 8;


////                            Text {
////                                id: eventTimeHeader;
////                                text: qsTr("Saat : ")
////                                color: appWindow.colorMain;
////                                horizontalAlignment: Text.AlignLeft;
////                                anchors.left: parent.left;
////                            }

//                            Text
//                            {
//                                id: eventTime;
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                anchors.left: parent.left;
////                                font.family: appWindow.fontMain.name;
//                                font.pointSize: eventName.font.pointSize * 0.8;
//                                text:  "Saat : " +  model.modelData.EventTime;
//                                horizontalAlignment: Text.AlignLeft;
//                                verticalAlignment: Text.AlignVCenter;
//                            }
//                        }

//                        // Yüksekliği sabit tutmak amacı ile.
//                        Rectangle
//                        {
//                            Layout.fillWidth:  true;
//                            width:  parent.width;
//                            height: Math.abs((containerDate.height * 5.5) -  containerName.height - containerPlace.height);
//                            color: "transparent";

////                            Component.onCompleted:
////                            {
////                                console.log ("---- Delege FARK konyetnır : "  + Name);
////                                console.log("Etkinlik adı  büyüklüğü : " + containerName.height);
////                                console.log("Etkinlik yeri büyüklüğü : " + containerPlace.height);
////                            }
//                        }

//                    }

//                    ColorableIcon {
//                        id: selectionIcon
//                        iconPath:  "../../assets/images/fa/forward-x64.png";
//                        width: parent.width  -  eventInfoContainer.width - eventImageContainer.width - 10 - 2 * parent.spacing;
//                        height: eventInfoContainer.height;
//                        hRatio: 0.25;
//                        anchors.margins: 10;

//                        overlayColor: "transparent";

//                    }

//                }
//            }

//        }


//    }

//    MouseArea{
//        anchors.fill: parent
////        onPressAndHold: {
////            mouse.accepted = true
////            add2FavouritePopup.open()
////        }
//        onClicked: {
//            appWindow.eventSelected(model);
//        }
//    }
//} // Rectangle ends






//import QtQuick 2.7
//import QtQuick.Layouts 1.3
//import QtQuick.Controls 2.1
//import QtGraphicalEffects 1.0

//import "../../items"

//Rectangle {

//    id : elements
//    width:   appWindow.width;
//    height:  delegateContainer.height;
////    anchors.margins:  10;
////    anchors.horizontalCenter: appWindow.horizontalCenter;
//    color: "white";

//    //        anchors.horizontalCenter:  parent.horizontalCenter

//    // Burası sadece yataydaki eksende ortalamak için yapıldı.
//    Rectangle
//    {
//        id: delegateContainer;
//        height: delegateLayout.implicitHeight + (3 * border.width);
//        width: parent.width  * .95;
//        anchors.horizontalCenter: parent.horizontalCenter;
//        border{
//            color: "#34495e";
//            width: 2;
//        }

//        // Column
//        Column
//        {
//            id: delegateLayout;
//            width: parent.width;
//            anchors.margins: 5;
//            spacing: 2;

//            // Etkinliğin isminin bulunacağı satır.


//            // Etkinliğe ait resmin ve kismi bilgilerin bulunacağı yer.
//            Rectangle
//            {
//                Layout.fillWidth: true;
//                width: parent.width;
//                height: delegateDetailContaier.height;

//                Row
//                {
//                    id: delegateDetailContaier;
//                    width: parent.width;
//                    spacing: 8;

//                    // Etkinliğin resminin gösterileceği alan.
//                    property real diff: delegateLayout.height - eventName.height;
//                    ColorableIcon {
//                        id: eventImage
//                        iconPath:  ImageURL;
//                        width: parent.width * 0.3;
//                        height: parent.diff > eventInfoContainer.height ? parent.diff : eventInfoContainer.height;

//                        wRatio: 0.95;
//                        hRatio: 0.95;

//                        anchors.margins: 10;

//                        overlayColor: "transparent";

//                    }


//                    // Etkinliğe ait diğer bilgilerin yer alacağı kısım

//                    Column
//                    {
//                        id: eventInfoContainer;
//                        width: parent.width * 0.62;
//                        anchors.margins: 10;
//                        // Etkinliği yeri, düzenleyen.
//                        Rectangle
//                        {
//                            id : containerName;
//                            Layout.fillWidth: true;
//                            width: parent.width;
//                            height: eventName.implicitHeight // eventName.contentHeight;
//                            anchors.margins: 10;

//                            Text
//                            {
//                                id: eventName;
//                                text: Name;
//                                horizontalAlignment: Text.AlignJustify
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                verticalAlignment: Text.AlignVCenter;
//                                color: appWindow.colorMain;
//                            }
//                        }
//                        Rectangle
//                        {
//                            id: containerPlace;
//                            Layout.fillWidth:  true;
//                            width: parent.width;
//                            height: eventPlace.implicitHeight + 8; // eventPlace.contentHeight + 8;

//                            Text
//                            {
//                                id: eventPlace;
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                anchors.left: parent.left;
//                                font.pointSize: eventName.font.pointSize * 0.8;
//                                text:  "Yer   : " + model.modelData.Yer;
//                                horizontalAlignment: Text.AlignLeft;
//                                verticalAlignment: Text.AlignVCenter;
//                            }
//                        }
//                        // Etkingliğin Saati
//                        Rectangle
//                        {
//                            id : containerDate;
//                            Layout.fillWidth:  true;
//                            width: parent.width;
//                            height:  eventTime.implicitHeight + 8// eventTime.contentHeight + 8;


////                            Text {
////                                id: eventTimeHeader;
////                                text: qsTr("Saat : ")
////                                color: appWindow.colorMain;
////                                horizontalAlignment: Text.AlignLeft;
////                                anchors.left: parent.left;
////                            }

//                            Text
//                            {
//                                id: eventTime;
//                                width: parent.width;
//                                wrapMode: Text.WordWrap;
//                                anchors.left: parent.left;
//                                font.pointSize: eventName.font.pointSize * 0.8;
//                                text:  "Saat : " +  model.modelData.EventTime;
//                                horizontalAlignment: Text.AlignLeft;
//                                verticalAlignment: Text.AlignVCenter;
//                            }
//                        }

//                        // Yüksekliği sabit tutmak amacı ile.
//                        Rectangle
//                        {
//                            Layout.fillWidth:  true;
//                            width:  parent.width;
//                            height: Math.abs((containerDate.height * 5.5) -  containerName.height - containerPlace.height);
//                            color: "transparent";

////                            Component.onCompleted:
////                            {
////                                console.log ("---- Delege FARK konyetnır : "  + Name);
////                                console.log("Etkinlik adı  büyüklüğü : " + containerName.height);
////                                console.log("Etkinlik yeri büyüklüğü : " + containerPlace.height);
////                            }
//                        }

//                    }

//                    Rectangle
//                    {
//                        width: parent.width  -  eventInfoContainer.width - eventImage.width - 10 - 2 * parent.spacing;
//                        height:   eventInfoContainer.height;
//                        color : "transparent";

//                        ColorableIcon {
//                            id: selectionIcon
//                            iconPath:  "../../assets/images/fa/forward-x64.png";
//                            width:  Math.min(parent.width , parent.height);
//                            height:  width // eventInfoContainer.height;
//                            wRatio:  0.8;
//                            hRatio:  0.8;
//                            anchors.centerIn: parent;
//                            color: "transparent";
//                            overlayColor: appWindow.colorMain;
//                        }

//                    }



//                }
//            }

//        }


//    }

//    MouseArea{
//        anchors.fill: parent
////        onPressAndHold: {
////            mouse.accepted = true
////            add2FavouritePopup.open()
////        }
//        onClicked: {
//            appWindow.eventSelected(model);
//        }
//    }
//} // Rectangle ends










////import QtQuick 2.7
////import QtQuick.Layouts 1.3
////import QtQuick.Controls 2.1
////import QtGraphicalEffects 1.0

////import "../../items"

////Rectangle {

////    id : elements
////    width:   appWindow.width;
////    height:  delegateContainer.height;
////    anchors.margins:  10;
////    color: "transparent";

////    //        anchors.horizontalCenter:  parent.horizontalCenter

////    // Burası sadece yataydaki eksende ortalamak için yapıldı.
////    Rectangle
////    {
////        id: delegateContainer;
////        height: delegateLayout.implicitHeight + (3 * border.width);
////        width: parent.width * .95;
////        anchors.horizontalCenter: parent.horizontalCenter;
////        border{
////            color: "#34495e";
////            width: height / 10;

////        }

////        radius: height / 10;

////        // Column
////        Column
////        {
////            id: delegateLayout;
////            width: parent.width;
////            anchors.margins: 5;
////            spacing: 2;

////            // Etkinliğin isminin bulunacağı satır.


////            // Etkinliğe ait resmin ve kismi bilgilerin bulunacağı yer.
////            Rectangle
////            {
////                Layout.fillWidth: true;
////                width: parent.width;
////                height: delegateDetailContaier.height;

////                Row
////                {
////                    id: delegateDetailContaier;
////                    width: parent.width;
////                    spacing: 8;

////                    // Etkinliğin resminin gösterileceği alan.
////                    property real diff: delegateLayout.height - eventName.height;

////                    Rectangle
////                    {
////                        id: eventImageContainer;
////                        width: parent.width * 0.3;
////                        height: parent.diff > eventInfoContainer.height ? parent.diff : eventInfoContainer.height;
////                        color: "transparent";

////                        Image
////                        {
////                            id: ikon;
////                            width: parent.width   * 1;//0.9;
////                            height: parent.height * 1;//0.9;
////                            source: ImageURL
////                            sourceSize: Qt.size(width, height);
////                            anchors.centerIn: parent;
////                            layer.enabled: true
////                            layer.effect: OpacityMask {
////                                maskSource: mask
////                            }

////                        }

////                        Rectangle {
////                            id: mask
////                            width: ikon.width
////                            height: ikon.height
////                            radius: width < height ? width / 10 : height /10;
////                            visible: false

////                        }
////                    }

//////                    ColorableIcon {
//////                        id: eventImage
//////                        iconPath:  ImageURL;
//////                        width: parent.width * 0.3;
//////                        height: parent.diff > eventInfoContainer.height ? parent.diff : eventInfoContainer.height;

//////                        wRatio: 1;
//////                        hRatio: 1;

//////                        anchors.margins: 10;

//////                        overlayColor: "transparent";

//////                    }


////                    // Etkinliğe ait diğer bilgilerin yer alacağı kısım

////                    Column
////                    {
////                        id: eventInfoContainer;
////                        width: parent.width * 0.62;
////                        anchors.margins: 10;
////                        // Etkinliği yeri, düzenleyen.
////                        Rectangle
////                        {
////                            id : containerName;
////                            Layout.fillWidth: true;
////                            width: parent.width;
////                            height: eventName.contentHeight;
////                            anchors.margins: 10;

////                            Text
////                            {
////                                id: eventName;
////                                text: Name;
////                                horizontalAlignment: Text.AlignJustify
//////                                font.family: appWindow.fontMain.name;
////                                width: parent.width;
////                                wrapMode: Text.WordWrap;
////                                verticalAlignment: Text.AlignBottom
////                                color: appWindow.colorMain;
////                            }
////                        }
////                        Rectangle
////                        {
////                            id: containerPlace;
////                            Layout.fillWidth:  true;
////                            width: parent.width;
////                            height: eventPlace.contentHeight + 8;

////                            Text
////                            {
////                                id: eventPlace;
////                                width: parent.width;
////                                wrapMode: Text.WordWrap;
////                                anchors.left: parent.left;
//////                                font.family: appWindow.fontMain.name;
////                                font.pointSize: eventName.font.pointSize * 0.8;
////                                text:  "Yer   : " + model.modelData.Yer;
////                                horizontalAlignment: Text.AlignLeft;
////                                verticalAlignment: Text.AlignVCenter;
////                            }
////                        }
////                        // Etkingliğin Saati
////                        Rectangle
////                        {
////                            id : containerDate;
////                            Layout.fillWidth:  true;
////                            width: parent.width;
////                            height: eventTime.contentHeight + 8;


//////                            Text {
//////                                id: eventTimeHeader;
//////                                text: qsTr("Saat : ")
//////                                color: appWindow.colorMain;
//////                                horizontalAlignment: Text.AlignLeft;
//////                                anchors.left: parent.left;
//////                            }

////                            Text
////                            {
////                                id: eventTime;
////                                width: parent.width;
////                                wrapMode: Text.WordWrap;
////                                anchors.left: parent.left;
//////                                font.family: appWindow.fontMain.name;
////                                font.pointSize: eventName.font.pointSize * 0.8;
////                                text:  "Saat : " +  model.modelData.EventTime;
////                                horizontalAlignment: Text.AlignLeft;
////                                verticalAlignment: Text.AlignVCenter;
////                            }
////                        }

////                        // Yüksekliği sabit tutmak amacı ile.
////                        Rectangle
////                        {
////                            Layout.fillWidth:  true;
////                            width:  parent.width;
////                            height: Math.abs((containerDate.height * 5.5) -  containerName.height - containerPlace.height);
////                            color: "transparent";

//////                            Component.onCompleted:
//////                            {
//////                                console.log ("---- Delege FARK konyetnır : "  + Name);
//////                                console.log("Etkinlik adı  büyüklüğü : " + containerName.height);
//////                                console.log("Etkinlik yeri büyüklüğü : " + containerPlace.height);
//////                            }
////                        }

////                    }

////                    ColorableIcon {
////                        id: selectionIcon
////                        iconPath:  "../../assets/images/fa/forward-x64.png";
////                        width: parent.width  -  eventInfoContainer.width - eventImageContainer.width - 10 - 2 * parent.spacing;
////                        height: eventInfoContainer.height;
////                        hRatio: 0.25;
////                        anchors.margins: 10;

////                        overlayColor: "transparent";

////                    }

////                }
////            }

////        }


////    }

////    MouseArea{
////        anchors.fill: parent
//////        onPressAndHold: {
//////            mouse.accepted = true
//////            add2FavouritePopup.open()
//////        }
////        onClicked: {
////            appWindow.eventSelected(model);
////        }
////    }
////} // Rectangle ends
