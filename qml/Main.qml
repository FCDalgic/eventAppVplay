import QtQuick 2.4
import VPlayApps 1.0
import "items"
import "pages/main"
import "pages/auth"
import "navigation"

MobileApp {
    id: appWindow

    Page {
      // make navigation public, so app-demo launcher can track navigation changes and log screens with Google Analytics
      property alias childNavigationStack: globalNavStack
      property alias navigation: navigation
      useSafeArea: false // full screen



      NavigationStack {
          id: globalNavStack

          // Wrapper page
          Page {

              useSafeArea: false // full screen

              title: currentAppTitle;

              // To access Drawer anywhere from this level of stack.
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
                          anchors.fill: parent;
                          onClicked: navigationBar.open();
                      }
                    }
                  }
                } // NavigationBarItem


              Navigation {
                  id: navigation
                  // Comment to use a navigation drawer instead of tabs on Android
                  navigationMode: navigationModeTabs
                    tabPosition: Qt.BottomEdge;
                  onCurrentIndexChanged: swipeViewIndexChanged(currentIndex);


                  NavigationItem {
                      title: qsTr("Homepage");
                      icon: IconType.home
                      showInDrawer: false;

                      Homepage
                      {

                      }
                  }

                  NavigationItem {
                      title: qsTr("Recents")
                      icon: IconType.thlarge;

                      PageRecents {


                      }
                  }

                  NavigationItem {
                      title: qsTr("Places")
                      icon: IconType.locationarrow;

                      PagePlacesList {


                      }
                  }

                  NavigationItem {
                      title: qsTr("Profile")
                      icon: IconType.user;

                      PageProfileLoader {


                      }
                  }

              } // Navigation ends.

          } // Page ends.

      }//Stack ends
    }

    // Custom Drawer
    NavigationDrawerBar{
        id: navigationBar
    }
}
