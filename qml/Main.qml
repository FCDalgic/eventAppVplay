import QtQuick 2.4
import VPlayApps 1.0
import "items"
import "pages/main"
import "navigation"

MobileApp {
    id: appWindow

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"


    Page {
      // make navigation public, so app-demo launcher can track navigation changes and log screens with Google Analytics
      property alias childNavigationStack: globalNavStack
      property alias navigation: navigation
      useSafeArea: false // full screen


      NavigationStack {
          id: globalNavStack

          // Wrapper page
          Page {
              navigationBarHidden: Theme.isAndroid
              useSafeArea: false // full screen

              title: navigation.currentNavigationItem ? navigation.currentNavigationItem.title : ""

              Navigation {
                  id: navigation
                  // Comment to use a navigation drawer instead of tabs on Android
                  navigationMode: navigationModeTabs

                  NavigationItem {
                      title: qsTr("Homepage");
                      icon: IconType.home

                      FirstPage
                      {

                      }
                  }

                  NavigationItem {
                      title: qsTr("Recents")
                      icon: IconType.square;

                      SecondPage {


                      }
                  }


                  NavigationItem {
                      title: qsTr("Places")
                      icon: IconType.locationarrow;

                      SecondPage {



                      }
                  }

              }
          }
      }



      // MainViewStackedPages
      // {
      //     id: navPane;
      //     anchors.fill: parent;
      //     focus: true;
      // }

    }

    NavigationDrawerBar{
        id: navigationBar
    }
}
