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

    AppFlickable {
        id: homepageFlick
        anchors.fill: parent
        contentHeight: content.height


        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                Qt.inputMethod.hide();
            }
        }


        Column {
            id: content
            focus: false
            width: parent.width;
            anchors.top: parent.top;
            anchors.horizontalCenter : parent.horizontalCenter;
            spacing: 0;
            property bool isSearchEnabled: false;
            // Bannerın yer alacağı alan.
            Rectangle
            {
                id: bannerContaier;
                width: parent.width;
                height  : appWindow.height * 0.4;
                color: "transparent";

                // Banner
                //            ColorableIcon{
                Rectangle{
                    id: banner;
                    anchors.fill: parent;
                    width: parent.width;
                    height: parent.height;

                    color: "transparent";
                    // İmza - Logo
                    Rectangle
                    {
                        width: parent.width / 2;
                        height:  parent.height * 0.5;
                        color: "transparent";

                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.top: parent.top;
                        anchors.topMargin:  parent.height / 8;

                        Image
                        {
                            id : imgImza;
                            fillMode: Image.PreserveAspectFit
                            anchors.fill: parent;
                            source:"../../../assets/images/v3/Logo_.png";
                        }
                        ColorOverlay
                        {
                            source:imgImza;
                            anchors.fill:  imgImza;
                            color: "white";
                        }
                    }

                    // Categories
                    Rectangle
                    {
                        id: categoryContaier;
                        width: parent.width;
                        height  : categoryContaierLayout.implicitHeight;
                        color : "transparent";
                        //                    anchors.bottomMargin: 5;//  parent.height / 30;
                        anchors.bottom: banner.bottom;
                        property real length:  width * 0.20;
                        property real pHeight: bannerContaier.height / 4;

                        Row
                        {
                            id: categoryContaierLayout;
                            anchors.centerIn: parent;
                            spacing: 1;


                            CategoryIconHomepage
                            {
                                width: categoryContaier.length;
                                height: categoryContaier.pHeight;
                                iconPath: "../../assets/images/v3/Tümü.png";
                                categoryName: "All";
                                //                        overlayColor: "#297fb8";
                                onCategorySelected:
                                {
                                    appWindow.categorySelected("all");
                                    appWindow.setDrawerIndex(4);
                                }
                            }

                            CategoryIconHomepage
                            {
                                width: categoryContaier.length;
                                height: categoryContaier.pHeight;
                                iconPath: "../../assets/images/v3/Sanat.2.png"; // "../../assets/images/fa/concert.png";
                                categoryName: "Entertainment";
                                //                        overlayColor: "#297fb8";
                                onCategorySelected:
                                {
                                    appWindow.categorySelected("concert");
                                    appWindow.setDrawerIndex(4);
                                }
                            }

                            CategoryIconHomepage
                            {
                                width: categoryContaier.length;
                                height: categoryContaier.pHeight;
                                iconPath: "../../assets/images/v3/Eğitim.png";
                                categoryName: "Academic";
                                //                        overlayColor: "#297fb8";
                                onCategorySelected:
                                {
                                    appWindow.categorySelected("academic");
                                    appWindow.setDrawerIndex(5);
                                }
                            }

                            CategoryIconHomepage
                            {
                                width: categoryContaier.length;
                                height: categoryContaier.pHeight;
                                iconPath: "../../assets/images/v3/Cocuklar.2.png";
                                categoryName: "Kids";
                                //                        overlayColor: "#297fb8";
                                onCategorySelected:
                                {
                                    appWindow.categorySelected("kids");
                                    appWindow.setDrawerIndex(4);
                                }
                            }


                            CategoryIconHomepage
                            {
                                width: categoryContaier.length;
                                height: categoryContaier.pHeight;
                                iconPath: "../../assets/images/v3/fork-spoon-x256.png";
                                categoryName: "Workshops";
                                //                        overlayColor: "#297fb8";
                                onCategorySelected:
                                {
                                    appWindow.categorySelected("food");
                                    appWindow.setDrawerIndex(4);
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true;
                                height: parent.height;
                            }
                        }
                    }

                }

            }

            ListviewHomepage
            {
                id: homePageRecentEventsListview;
                focus: true
                width: parent.width - 30;
                model: HomeRecentEvents.eventList;
                height:  Math.min(dp(2000), contentHeight)
                interactive: false;
                anchors.horizontalCenter: parent.horizontalCenter;

                backgroundColor: "transparent";
                onCountChanged:
                {

                }
            }



        } // ColumnLayout flickLayout



    }
}
