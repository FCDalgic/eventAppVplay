import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import VPlayApps 1.0

import "../items"
import "../items/decoration/spaces"

Drawer {
    id: myBar
    z: 1
    leftPadding: 0

    width : appWindow.width * .68;
    height: appWindow.height
    visible: false;

    property real index: 0;

    dragMargin: appWindow.width * 0.05;
    onIndexChanged: console.log("Drawer index changed" + index);
    background: Rectangle
    {
        anchors.fill : parent;
        color: appWindow.colorDrawer;
    }


    onVisibleChanged:
    {
        if (!visible)
            return;

        textUsername.text = textUsername.getUsername();
    }


    Flickable {
        id: flickableDrawer
        anchors.fill: parent;
        //    anchors.fill: parent
        clip: true
        contentHeight: drawerColumn.height
        flickableDirection: Flickable.VerticalFlick
        interactive: false;
        property real sectionHeight:  height / 15;

        Column {
            id: drawerColumn
            focus: false
            width: parent.width;
            anchors.centerIn: parent;
            spacing: 5;
            // Bannerın yer alacağı alan.
            Rectangle
            {
                width: parent.width;
                height  : appWindow.height * 0.20;
                color: appWindow.colorMain;

                ColorableIcon
                {
                    id: userPhotoDrawer;
                    width   : Math.min(parent.width , parent.height * .9);
                    height  : width;

                    anchors.centerIn: parent;

                    iconPath: "../../assets/images/fa/user-x64.png"; //  "../../assets/images/fa/user-x64.png";
                    color: "transparent";
                    overlayColor: "white";

                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            nativeUtils.displayCameraPicker("Profile Image");

                        }
                    }

                    Connections {
                        target: nativeUtils
                        onCameraPickerFinished: {
                            if(accepted) userPhotoDrawer.iconPath = path
                        }
                    }
                }

                Rectangle
                {
                    width: parent.width * .8;
                    height: parent.height * .1;
                    anchors.left: parent.left;
                    anchors.leftMargin: 15;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 15;
                    color: "transparent";

                    Text {
                        id: textUsername;
                        width: parent.width *.8;
                        height: parent.height * 0.8;
                        anchors.bottom: parent.bottom;
                        text: getUsername();
                        font.pointSize: 100
                        minimumPointSize: 10
                        fontSizeMode: Text.Fit
                        wrapMode: Text.WordWrap;
                        verticalAlignment: Text.AlignBottom
                        color: "white"

                        function getUsername()
                        {
                            if(appWindow.loggedIn)
                                return ProfileManager.getStoredMail();
                            else
                                return "";
                        }


                    }


                }

            }


            NavigationButton{
                iconPath: "../../assets/images/fa/home-x64.png";
                text: qsTr("Homepage");
                width: parent.width;
                height: flickableDrawer.height / 20;
                color: flickableDrawer.index == 0 ? "lightgray" : "transparent";

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        //                        if (navPane.depth != 1)
                        //                            navPane.pushPageByPageNumber(1);
                        appWindow.goHomepage();
                        appWindow.setSwipeIndexManually(0);
                        myBar.close();
                    }

                }
            }

            // space between content - see google material guide
            SpaceSelectedEventPageContents{}

            NavigationButton{
                iconPath: "../../assets/images/fa/description-x64.png";
                text: qsTr("About");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 20;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        appWindow.categorySelected("about");
                        myBar.close();
                    }

                }
            }

            // space between content - see google material guide
            SpaceSelectedEventPageContents{}
            NavigationButton{
                iconPath: "../../assets/images/fa/bug-x256.png";
                text: qsTr("Found an Error");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 20;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Found a  bug&body=");
                    }

                }
            }

            // space between content - see google material guide
            SpaceSelectedEventPageContents{}

            NavigationButton{
                iconPath: "../../assets/images/fa/lightbulb-x256.png";
                text: qsTr("Got an idea!");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 20;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Have an idea&body=");
                    }

                }
            }
            // space between content - see google material guide
            SpaceSelectedEventPageContents{}

            NavigationButton{
                iconPath: "../../assets/images/fa/mail-x256.png";
                text: qsTr("Contact Us");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 20;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Contact Us&body=");
                    }

                }
            }

            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }
            Rectangle { color: "transparent";  width: parent.width;  height: 8;
                Rectangle
                {
                    width: parent.width * .95;
                    height: parent.height/2;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00;
                            color: "#fdfdfd";
                        }
                        GradientStop {
                            position: 0.50;
                            color: "#661349";
                        }
                        GradientStop {
                            position: 1.00;
                            color: "#ffffff";
                        }
                    }
                }

            }

            // space between content - see google material guide
            SpaceSelectedEventPageContents{}

            NavigationButton{
                iconPath: "../../assets/images/fa/like-x256.png";
                text: qsTr("Share Us");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 20;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        nativeUtils.share("Let's go to this event!" ,"http://sehir-etkinlikleri.com/android/share.php" + "?SEID=-1")
                    }

                }
            }

            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }
            // Rectangle { color: "transparent";  width: parent.width;  height: 8;
            //     Rectangle
            //     {
            //         width: parent.width * .95;
            //         height: parent.height/2;
            //         anchors.centerIn: parent;color: appWindow.colorMain;
            //         gradient: Gradient {
            //             GradientStop {
            //                 position: 0.00;
            //                 color: "#fdfdfd";
            //             }
            //             GradientStop {
            //                 position: 0.50;
            //                 color: "#661349";
            //             }
            //             GradientStop {
            //                 position: 1.00;
            //                 color: "#ffffff";
            //             }
            //         }
            //     }
            //
            // }



        } // ColumnLayout myButtons
        // ScrollIndicator.vertical: ScrollIndicator { }


    } // Flickable

} // drawer
