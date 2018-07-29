import QtQuick 2.0
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
                onClicked: navigationBar.open();
                anchors.fill: parent;
            }
          }
        }
      } // NavigationBarItem



}
