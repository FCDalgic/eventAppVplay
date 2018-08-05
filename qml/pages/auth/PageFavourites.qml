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
    title: selectedCategoryTitle;
    model: ProfileManager.Favorites
    backNavigationEnabled: true;
    focus: true
    clip: true

    backgroundColor: "blue";
    listView
    {
        // width: parent.width - dp(20);
        backgroundColor: colorMain;
        spacing: 4;
        emptyText.text : "No favourites available";

    }

    property real previousContentY: 0;
    property string sectionFilter: "EventDate";
    property real status: 0;

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

    delegate: EventListItemDelegate
    {
        eventModel: modelData
        anchors.horizontalCenter : parent.horizontalCenter;
        small: true
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
            style.compactStyle: true;
            style.backgroundColor: "white";
            style.textColor: colorMain;
            width: listviewSelectedCategory.width - dp(20);
            anchors.horizontalCenter:  parent.horizontalCenter;


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

}
