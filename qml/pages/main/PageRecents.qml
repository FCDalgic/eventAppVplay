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

Flickable {
    id: flickablePageSelectedCategory;
    //    width: appWindow.width;
    //    height : appWindow.height;
    //    anchors.fill: parent
    clip: true
    // StackView manages this, so please no anchors here
    // anchors.fill: parent

    // Sayfa Yukarı Kaydırılabilir mi?
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

    Component.onCompleted:
    {

//        loaderTimer.start();
        if (visible)
            listviewSelectedCategory.setCategoryName(appWindow.currentlySelectedCategoryName);
    }


    property string modelType: "art";

      MobileListview
      {
          id:listviewSelectedCategory;
          model: categoryResults.eventList;
          anchors.fill: parent;

      }

    function setDelegate(pDelegateName)
    {
        if (pDelegateName == "art")
        {
            listviewSelectedCategory.model = categoryResults.eventList;
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
