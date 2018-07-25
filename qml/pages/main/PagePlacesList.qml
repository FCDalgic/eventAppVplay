import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

import "../../items/delegates"
import "../../items/listview"
import "../../items/listview/categories/food"
import "../../items"

Flickable {
    id: flickablePageSelectedCategory;
    clip: true

    function canGoTop()
    {
        if (listviewPlaces.contentY < 20 )
        {
            return false;
        }
        else
        {
            return true;
        }

    }


    NumberAnimation {
        id: scrollTopAnimator;
        target: listviewPlaces;
        easing.type: Easing.InOutQuart
        properties: "contentY";
        from: listviewPlaces.contentY;
        to: 0;
        running: false;
        duration: 1000;
    }
    function scrollTop()
    {
        scrollTopAnimator.start();
    }

    Component.onCompleted:
    {
        if (visible)
            listviewPlaces.setCategoryName(appWindow.currentlySelectedCategoryName);
    }


    property string modelType: "art";

    Rectangle
    {
        id: bilgilendirme;
        width: parent.width;
        height: appWindow.height / 6;
        color: "white";
        anchors.top: parent.top;
        radius: height / 10;

        ColorableIcon
        {
            id: bilgilendirmeResim;
            width: height;
            iconPath:"../../assets/images/fa/info-x256.png";
            height: parent.height / 3;
            color: "transparent";
            anchors.left: parent.left;
            anchors.top:parent.top;

            Component.onCompleted:
            {
                var oran = (height / appWindow.height);
                console.log("Ekran yükseklik oranı: " + oran);
            }
        }

        Rectangle
        {
            id: bilgilendirmeMetniTutucu;
            width: parent.width - ( bilgilendirmeResim.height + kapatbutonu.height + 10);
            height: parent.height;
            color: "transparent";
            anchors.left: bilgilendirmeResim.right;


            Text
            {
                width: parent.width * .95;
                anchors.centerIn: parent;
                height: parent.height;
                text:   "Ankara’da düzenlenen yemek workshoplarından tadım günlerine pek çok gurme etkinliği, çok yakında Şehir Etkinlikleri’nde sizlerle... ";
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap;
                horizontalAlignment: Text.AlignLeft;
                color:"gray";
            }
        }
        ColorableIcon
        {
            id: kapatbutonu;
            width: height;
            iconPath:"../../assets/images/fa/close-x256.png";
            height: parent.height / 3;
            color: "transparent";
            overlayColor: "gray";
            anchors.top:parent.top;
            anchors.left: bilgilendirmeMetniTutucu.right;

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    parent.parent.height = 0;
                    parent.parent.visible = false;
                }
            }
        }


    }

//    MobileListview
//    {
//        id:listviewPlaces;
//        model: foodEvents.eventList;
//        width: parent.width;
//        height: parent.height - bilgilendirme.height;
//        anchors.top: bilgilendirme.bottom;
//        anchors.topMargin: 5;
//    }

    ListViewPlaces
    {
        id: listviewPlaces;
        model: PlacesList.placeList;
        width: parent.width;
        height: parent.height - bilgilendirme.height;
        anchors.top: bilgilendirme.bottom;
        anchors.topMargin: 5;
    }



    function setDelegate(pDelegateName)
    {
        if (pDelegateName == "art")
        {
            listviewPlaces.model = categoryResults.eventList;
        }
    }

    function whoAmI() {
        return qsTr("category")
    }

    property string lastHeader: "";


    function whatWasMyTitle()
    {
        return lastHeader;
    }

    // called immediately after push()
    function init() {
        console.log(qsTr("Init done from One"))
    }
    // called immediately after pop()
    function cleanup() {
        console.log(qsTr("Cleanup done from One"))
    }
} // flickable
