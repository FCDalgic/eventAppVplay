import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

import "../../items/delegates"
import "../../items/listview"
import "../../items"

import VPlayApps 1.0


ListPage
{
    id: listviewSelectedCategory;
    function canGoTop()
    {
        if (listviewSelectedCategory.contentY < 20 )
        {
            return false;
        }
        else
        {
            return true;
        }

    }


    backNavigationEnabled: true;
    rightBarItem:NavigationBarItem {

        // we specify the width of the item with the contentWidth property
        // the item width then includes the contentWidth and a default padding
        contentWidth: contentRect.width

        // the navigation bar item shows a colored rectangle
        Rectangle {
          id: contentRect
          width: dp(Theme.navigationBar.defaultIconSize)
          height: width
          anchors.centerIn: parent
          color: "transparent";


          Icon {
            anchors.fill: parent
            icon: IconType.navicon
            color: Theme.navigationBar.itemColor

            MouseArea
            {
                onClicked: appWindow.openNavDrawer();
                anchors.fill: parent;
            }
          }
        }
      } // NavigationBarItem
    title: selectedCategoryTitle;
    model: CategoryResults.eventList;

    NumberAnimation {
        id: scrollTopAnimator;
        target: listviewSelectedCategory;
        easing.type: Easing.InOutQuart
        properties: "contentY";
        from: listviewSelectedCategory.contentY;
        to: 0;
        running: false;
        duration: 1000;
    }
    function scrollTop()
    {
        scrollTopAnimator.start();
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

    focus: true
    clip: true

    property real previousContentY: 0;
    property string modelType: "art";
    property string eventType: "";
    property string sectionFilter: "EventDate";
    property real status: 0;



    delegate: EventListItemDelegate
    {
        eventModel: modelData
        small: false
        onClicked:
        {
            appWindow.eventSelected(model);
        }

    }

    // Section
    Component {
        id: sectionHeading
        SimpleSection
        {

            title: section // E.g. "Category: Fruits"
            textItem.horizontalAlignment: Text.AlignHCenter // center text horizontally
            enabled: true // make section clickable
        }
    }
    section.property: sectionFilter;
    section.criteria: ViewSection.FullString
    section.delegate: sectionHeading
    // Section ends.

    function setCategoryName(pName)
    {
        eventType = pName;
    }

    ListviewMessageHeader
    {
        id: msgHeader;
        anchors.top: parent.top;
        z :2;
    }


    // Timer
    function configureLodingText()
    {
        if (!visible)
            return;

        msgHeader.setCategoryName(appWindow.currentlySelectedCategoryName);


        if (listviewSelectedCategory.listView.count > 0)
        {
            msgHeader.status = 0;
        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!isOnline)
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

        console.log("configuring loading text in pageSelecteCategory" + msgHeader.status);

    }


    function doCheckLastTime()
    {
        if (!visible)
        {
            msgHeader.status = 0;
            return;
        }


        if (listviewSelectedCategory.listView.count > 0)
        {
            msgHeader.status = 0;
            stopTimers();
        }
        else
        {
            // 1. Internet bağlantısını kontrol et.
            if (!isOnline)
            {
                msgHeader.status = 1;
            }
            else
            {
                msgHeader.status = 2;
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

        console.log("before starting delay for page recents");
        appWindow.delay(2000, function() {
            console.log("delay is finished");
            loaderTimer.start();
        });
    }

    Component.onDestruction:
    {
        CategoryResults.clear();
    }

}

