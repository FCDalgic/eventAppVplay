import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import VPlayApps 1.0

import "../../items"
import "../../items/delegates"
import "../../items/listview/categories/homepage"


Page
{
    id: profilePage;
    AppFlickable {
        id: flickerProfilePage;
        anchors.fill: parent
        contentHeight: content.height


        Column {
            id: content
            focus: false
            width: parent.width;
            anchors.top: parent.top;
            anchors.horizontalCenter : parent.horizontalCenter;
            spacing: 0;
            property bool isSearchEnabled: false;
            // Bannerın yer alacağı alan.


            // Image header
               // Background color placeholder
               Rectangle {
                 id: topImage

                 z: 1
                 color: "transparent";
                 width: parent.width
                 height: dp(240)

                 property real offset: -(profileImage.height / 4) + height
                 Image {
                   id: imgHeader
                   source: "../../../assets/images/auth/default-cover.jpg";
                   anchors.fill: parent
                   fillMode: Image.PreserveAspectCrop
                   visible: false
                 }

                 FastBlur {
                   source: imgHeader
                   anchors.fill: imgHeader
                   radius: 64 * Math.max(0, Math.min(1, (flickerProfilePage.contentY * 0.5 + topImage.height)))
                 }

                 // Profile image
                 RoundedImage {
                   id: profileImage
                   source: ProfileManager.Picture.length > 5 ? ProfileManager.Picture : "../../../assets/images/auth/default-user-photo.jpg"; //  "../../assets/images/fa/user-x64.png";

                   x: dp(10)
                   y: -(height / 4) + parent.height
                   width: height
                   height: parent.height/2;

                   opacity: 1; // Math.max(0, Math.min(1, -(flickerProfilePage.contentY + topImage.height) / topImage.height))
                   scale: opacity

                   backgroundColor: "white"
                   anchors.horizontalCenter: parent.horizontalCenter;

                   MouseArea
                   {
                       anchors.fill: parent;
                       onClicked:
                       {
                               nativeUtils.displayImagePicker("Profile Image");
                       }
                   }

                   Connections {
                       target: nativeUtils
                       onImagePickerFinished: {
                           if(accepted)
                           {
                               userPhotoDrawer.iconPath = path

                               if (appWindow.isUserLogged)
                                   ProfileManager.Picture = path;
                           }
                       }
                   }
                 }

               }


               Rectangle { width: parent.width; height: topImage.offset/ 2; color: "white"; }

               Rectangle {
                 id: swipeContainer;

                 z: 1
                 color: "transparent";
                 width: parent.width
                 height: dp(240)

                 Navigation {
                     id: navigation
                     anchors.fill: parent;
                     // Comment to use a navigation drawer instead of tabs on Android
                     navigationMode: navigationModeTabs
                     tabPosition: Qt.TopEdge;

                     NavigationItem {
                         title: qsTr("Info");
                         icon: IconType.info
                         showInDrawer: false;



                     }

                     NavigationItem {
                         title: qsTr("Favourites")
                         icon: IconType.heart;

                         PageFavourites {


                         }
                     }


               }


               } // Navigation ends.



        } // ColumnLayout flickLayout
    }
}
