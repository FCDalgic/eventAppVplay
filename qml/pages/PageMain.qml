import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "main"
import "../items"
import "../items/footers"

Flickable {
    id: flickable
    width: appWindow.width;
    height: appWindow.height;

    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "PageOne"
    property string title: qsTr("Root Page in Stack of max 5")
    property real globalIndex: 0;

    // Sayfa Yukarı Kaydırılabilir mi?
    function canGoTop()
    {
        console.log("Can go Top Called Page Main");

        return swipeView.currentItem.item.canGoTop();
    }

    function scrollTop()
    {
        swipeView.currentItem.item.goTop();
    }

    Connections
    {
        target: appWindow;
        onSwipeViewFooterTabbarIndexChanged:
        {
            console.log("swipe view footer tab index changed event received from page main");
            if (swipeView.currentIndex == pIndex)
                return;
            else
                swipeView.currentIndex = pIndex;
        }
    }

    Connections
    {
        target: appWindow;

        onSetSwipeIndexManually: setSwipeIndexManually(pIndex);
        onDecreaseSwipeIndex: flickable.decreaseSwipeIndex();
        onSetSwiperViewBack:  flickable.setSwiperViewBack();
    }

    function setSwiperViewBack() {
        if (swipeView.currentIndex > 0)
            swipeView.currentIndex--;
        else
        {
            appWindow.tryToExit();
        }
    }

    function setSwipeIndexManually(index)
    {
        console.log("Set swipeview back event received from page main");
        if (index !== swipeView.currentIndex)
            swipeView.currentIndex = index;
        else
        {
            console.log("Trying to go top.");
            switch(index)
            {
            case 0:
                homePageLoader.item.goTop();
                break;
            case 1:
                recentEventsPageLoader.item.goTop();
                break;

            case 2:
                placesListPageLoader.item.goTop();
                break;
            }
        }

    }

    function decreaseSwipeIndex()
    {
        swipeView.currentIndex -= 1;
    }


    SwipeView {
        id: swipeView
        focus: true
        anchors.fill: parent;

        // currentIndex: footerBar.currentIndex

        // shows a Busy indicator - probably not noticed yet

        signal goTop();

        background: Rectangle
        {
            anchors.fill : parent;
            color : "transparent";
        }

        Loader {
            // index 0
            id: homePageLoader
            active: swipeView.currentIndex == 0 // || swipeView.currentIndex == 1
            source: "main/Homepage.qml";// "main/PageCategories.qml"
            //            onLoaded: item.init()
            // would like to call item.cleanup() from here, but there's no 'onUnloading'
            // so cleanup() is called from Component.onDestruction inside item


            Connections
            {
                target: swipeView;
                onCurrentIndexChanged:
                {
//                    homePageLoader.item.closeSearchPanel();

                }

                onGoTop:
                {
                    if (swipeView.currentIndex == 0)
                        homePageLoader.item.goTop();
                }
            }

        }

        Loader {
            // index 1
            id: recentEventsPageLoader
            active: swipeView.currentIndex == 1 // || swipeView.currentIndex == 1 || swipeView.currentIndex == 2
            source: "main/PageRecents.qml"

            Connections
            {
                target: swipeView;
                onGoTop:
                {
                    if (swipeView.currentIndex == 1)
                        recentEventsPageLoader.item.goTop();
                }
            }
        }


        Loader {
            // index 2
            id: favouritesEventsPageLoader
            active: swipeView.currentIndex == 2 // || swipeView.currentIndex == 1 || swipeView.currentIndex == 2
            source: "favourites/PageFavouritesLoader.qml"
//            source: "authantication/PageRequestAuthantication.qml"
            Connections
            {
                target: swipeView;
                onGoTop:
                {
                    if (swipeView.currentIndex == 2)
                        favouritesEventsPageLoader.item.goTop();
                }
            }
        }


        Loader {
            // index 3
            id: placesListPageLoader
            active: swipeView.currentIndex == 3 // || swipeView.currentIndex == 2 || swipeView.currentIndex == 3
            source: "places/PagePlacesList.qml"

            Connections
            {
                target: swipeView;
                onGoTop:
                {
                    if (swipeView.currentIndex == 3)
                        placesListPageLoader.item.goTop();
                }
            }
        }

        onCurrentIndexChanged:
        {


            appWindow.swipeViewIndexChanged(currentIndex);

        }

    } // SwipeDelegate


    ScrollIndicator.vertical: ScrollIndicator { }

    function whoAmI() {
        return qsTr("Page Main")
    }
    // called immediately after push()
    function init() {
        console.log(qsTr("Init done from Page Main"))
    }
    // called immediately after pop()
    function cleanup() {
        console.log(qsTr("Cleanup done from Page Main"))
    }

    property int myLastIndex: 0;

    function whatWasMySwipeIndex()
    {
        return myLastIndex;
    }


} // flickable
