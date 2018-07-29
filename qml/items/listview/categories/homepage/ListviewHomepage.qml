import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0
import VPlayApps 1.0

import "../../../delegates"
import "../../../listview"
import "../../../../items"
import "../../../../items/decoration/icons"

AppListView {
    id: listviewHomepage;
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





    spacing: 4;  // Google Materia refence.

    currentIndex: 0
    delegate: EventListItemDelegate
    {
        eventModel: modelData
        small: false
        onClicked:
        {
            appWindow.eventSelected(model);
        }

    }

    section.property: sectionFilter;
    section.criteria: ViewSection.FullString

    section.delegate: sectionHeading

    // ScrollIndicator.vertical: ScrollIndicator { }

    footer:  ListviewHomepageFooter
    {
        visible: listviewHomepage.showListFooter;
        width: parent.width;
        height: appWindow.height / 10;
        color: "transparent";
    }

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
            homepageMessageHeader.status = listviewHomepage.status;
            homepageMessageHeader.visible= false;
        }
        else
            showListFooter = false;


        console.log("Homepage Listview count changed : " + count);
    }


    cacheBuffer: appWindow.height * 5;

    highlightMoveVelocity : appWindow.height  * 10;
    maximumFlickVelocity: appWindow.height  * 10;

    ListviewMessageHeader
    {
        id: homepageMessageHeader;
        anchors.top: parent.top;
        z :2;

        onVisibleChanged: console.log("Anasayfa Mesaj Başlığı visible değişti :" + homepageMessageHeader.visible);
    }


    // Footer
    property bool  showListFooter: false;
    Component
    {
        id: listFooter;
        ListviewHomepageFooter
        {
            width: listviewHomepage.width;
            visible: listviewHomepage.showListFooter;
        }
    }

    // Section
    Component {
        id: sectionHeading
        ListviewSectionCriteriaHomepage
        {
            width: listviewHomepage.width;
        }

    }

    // Timer
    function configureLodingText()
    {

        if (!visible)
            return;


        if (listviewHomepage.count > 0)
        {
            homepageMessageHeader.status = 0;
            homepageMessageHeader.visible= false;

        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!isOnline)
            {
                homepageMessageHeader.status = 1;
                homepageMessageHeader.visible = true;
            }
            else
            {
                homepageMessageHeader.status = 3;
                homepageMessageHeader.visible= true;
                stopTimers();
                lastCheckTimer.start();
            }
        }

    }

    function doCheckLastTime()
    {
        if (!visible)
        {
            homepageMessageHeader.status = 0;
            return;
        }


        if (listviewHomepage.count > 0)
        {
            homepageMessageHeader.status = 0;
            stopTimers();
        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!isOnline)
            {
                homepageMessageHeader.status = 1;
            }
            else
            {
                homepageMessageHeader.status = 0;
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
        homepageMessageHeader.setCategoryName("homepage_recent");
    }


} // end listView
