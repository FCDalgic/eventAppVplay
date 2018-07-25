import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

import "../delegates"
import "../listview"
import "../../items"

ListView {
    id: listViewPlaces;
    focus: true
    clip: true
//    anchors.fill: parent
    orientation: ListView.Vertical
    //        z: 2;

    property real previousContentY: 0;
    property string modelType: "art";
    property string eventType: "";
    property string sectionFilter: "EventDate";
    property real status: 0;


    spacing: 18;  // Google Materia refence.

    currentIndex: 0

    delegate:  Rectangle {
        id: wrapper
        width: parent.width - 30;
        radius: 15;
        height:  appWindow.height  * 0.1;
        color: ListView.isCurrentItem ? "#d9d9d9" : "white";
        anchors.horizontalCenter: parent.horizontalCenter;

        Item {
            id: emptySpace;
            width: parent.width * .05;
            height: parent.height;
            anchors.left: parent.left;
        }
        Text {
            id: eventName
            text: Name;
            width: parent.width * .85;
            height: parent.height * .9;
            wrapMode: Text.WordWrap;
            verticalAlignment: Text.AlignVCenter;
            color: appWindow.colorMain;
            elide: Text.ElideRight;
            maximumLineCount: 2;
            anchors.left: emptySpace.right;
        }

        /// Ok'un bulunacağı kısım.
        Rectangle{
            id:  buttonContainer;
            width: parent.width * .05;
            anchors.leftMargin: parent.width * .05;
            height: parent.height;
            color: "transparent";
            anchors.right: eventName.right;

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
                appWindow.selectPlace(model);
            }
        }


    }

    //    model: categoryResults.eventList

    section.property: sectionFilter;
    section.criteria: ViewSection.FullString

    section.delegate: sectionHeading

    ScrollIndicator.vertical: ScrollIndicator { }

    footer:  listFooter;

    function setCategoryName(pName)
    {
        eventType = pName;
    }

    //    header: listHeader;
    onCountChanged:
    {
        if (!visible)
            return;

        // Görsel aktif ise pasif hale getirmek için...
        if (count > 0)
        {
            status = 0;
            showListFooter = true;
            msgHeader.status = listViewPlaces.status;
        }
        else
            showListFooter = false;


        console.log("listview count changed received selected category" + count);
    }


    cacheBuffer: appWindow.height * 5;

    highlightMoveVelocity : appWindow.height  * 10;
    maximumFlickVelocity: appWindow.height  * 10;

    ListviewMessageHeader
    {
        id: msgHeader;
        anchors.top: parent.top;
        z :2;
    }


    // Footer
    property bool  showListFooter: false;
    Component
    {
        id: listFooter;
        FooterListview
        {
            visible: listViewPlaces.showListFooter;
            text: "Bu sayfada şu an "+ foodEvents.eventList.length + " etkinlik görüntülenmektedir.";
        }

    }

    // Section
    Component {
        id: sectionHeading
        SectionHeadingListView
        {
            width: listViewPlaces.width - 30;

        }
    }

    // Timer
    function configureLodingText()
    {
        if (!visible)
            return;

        console.log("trying to set categoryname for msgheader");
        msgHeader.setCategoryName(appWindow.currentlySelectedCategoryName);


        if (listViewPlaces.count > 0)
        {
            msgHeader.status = 0;
        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!SehirUtils.checkInternetConnection())
            {
                msgHeader.status = 1;
            }
            else
            {
                msgHeader.status = 3;
                stopTimers();
                lastCheckTimer.start();
            }
        }

    }

    function doCheckLastTime()
    {
        if (!visible)
        {
            msgHeader.status = 0;
            return;
        }


        if (listViewPlaces.count > 0)
        {
            msgHeader.status = 0;
            stopTimers();
        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!SehirUtils.checkInternetConnection())
            {
                msgHeader.status = 1;
            }
            else
            {
                msgHeader.status = 0;
            }
        }

    }

    function stopTimers()
    {
        if (loaderTimer.running)
        {
            loaderTimer.stop();
        }

        if (lastCheckTimer.running)
        {
            lastCheckTimer.stop();
        }
    }

    Timer
    {
        id: loaderTimer;
        interval: 1000;
        running: false;
        repeat: false;
        onTriggered: configureLodingText();

    }
    Timer
    {
        id: lastCheckTimer;
        interval: 3000;
        running: false;
        repeat: false;
        onTriggered: doCheckLastTime();

    }
    Component.onCompleted:
    {
        loaderTimer.start();
    }


} // end listView
