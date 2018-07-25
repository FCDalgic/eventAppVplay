import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1


import "../items"

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
        textAccoutControl.manageDisplay();
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
                text: qsTr("Anasayfa");
                width: parent.width;
                height: flickableDrawer.height / 15;
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
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/fa/description-x64.png";
                text: qsTr("Hakkımızda");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

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
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/v3/Logo_.png";
                text: qsTr("Şehir Etkinlikleri Hakkında");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        appWindow.categorySelected("about_se");
                        myBar.close();
                    }

                }
            }

            // space between content - see google material guide
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/v3/Logo_.png";
                text: qsTr("Neler Yaptık?");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        appWindow.categorySelected("about_contributions");
                        myBar.close();
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

            // Section Space
//            Rectangle
//            {
//                width: parent.width;
//                height: (flickableDrawer.height / 30) + 8
//                color : "transparent";
//            }

            NavigationButton{
                iconPath: "../../assets/images/fa/location-x64.png";
                text: qsTr("Yeni bir etkinlik mi buldunuz?");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Sizde olmayan ve çok süper bir etkinlik buldum&body=");
                    }

                }
            }

            // space between content - see google material guide
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/fa/bug-x256.png";
                text: qsTr("Bir hata mı buldunuz?");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bir hata buldum&body=");
                    }

                }
            }

            // space between content - see google material guide
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/fa/lightbulb-x256.png";
                text: qsTr("Bir fikriniz mi var?");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bir fikrim var&body=");
                    }

                }
            }
            // space between content - see google material guide
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/fa/mail-x256.png";
                text: qsTr("Bize Ulaşın");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bize Ulaşın&body=");
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
            // Section Space
//            Rectangle
//            {
//                width: parent.width;
//                height: (flickableDrawer.height / 30) + 8
//                color : "transparent";
//            }

            NavigationButton{
                iconPath: "../../assets/images/fa/document-x256.png";
                text: qsTr("Kullanım Koşulları");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        appWindow.categorySelected("terms");
                        myBar.close();
                    }

                }
            }

            // space between content - see google material guide
            Item { Layout.fillWidth:  true; height: 8; }

            NavigationButton{
                iconPath: "../../assets/images/fa/like-x256.png";
                text: qsTr("Tavsiye Edin!");
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        SehirUtils.prepareContentAndShare("-1");
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
                    anchors.centerIn: parent;color: appWindow.colorMain;
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
            // Section Space
//            Rectangle
//            {
//                width: parent.width;
//                height: (flickableDrawer.height / 30) + 8
//                color : "transparent";
//            }


            NavigationButton{
                iconPath: "../../assets/images/fa/enter-x256.png";
                text: getDisplayText();
                width: parent.width;
                color: flickableDrawer.index == 8 ? "lightgray" : "transparent";
                height: flickableDrawer.height / 15;

//                MouseArea
//                {
//                    anchors.fill: parent;
//                    onClicked:
//                    {
//                        Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bir fikrim var!&body=");
//                    }

//                }
                function getDisplayText()
                {
                    if(appWindow.loggedIn)
                        return "Çıkış Yap";
                    else
                        return "Giriş Yap";
                }
                function manageDisplay()
                {
                    textAccoutControl.text  = getDisplayText();
                    parent.color = appWindow.loggedIn ? appWindow.colorMain : "#41cd52";
                }




                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (appWindow.loggedIn)
                        {
                            appWindow.loggedIn = false;
                            ProfileManager.logOut();
                        }
                        else
                            appWindow.categorySelected("page_authantication");

                        myBar.close();
                    }
                }
            }




            //            NavigationButton{
            //                iconPath: "../../assets/images/v3/Tümü.png";
            //                text: qsTr("Tüm Etkinlikler");
            //                width: parent.width;
            //                color: flickableDrawer.index == 7 ? "lightgray" : "transparent";
            //                height: flickableDrawer.height / 15;


            //                MouseArea
            //                {
            //                    anchors.fill: parent;
            //                    onClicked:
            //                    {
            //                        appWindow.categorySelected("all");
            //                        myBar.close();
            //                    }

            //                }

            //            }

            //            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }

            //            NavigationButton{
            //                iconPath: "../../assets/images/fa/concert.png";
            //                text: qsTr("Sanat Eğlence");
            //                width: parent.width;
            //                color: flickableDrawer.index == 7 ? "lightgray" : "transparent";
            //                height: flickableDrawer.height / 15;


            //                MouseArea
            //                {
            //                    anchors.fill: parent;
            //                    onClicked:
            //                    {
            //                        appWindow.categorySelected("concert");
            //                        myBar.close();
            //                    }

            //                }

            //            }

            //            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }

            //            NavigationButton{
            //                iconPath: "../../assets/images/v3/Eğitim.png";
            //                text: qsTr("Eğitim");
            //                width: parent.width;
            //                color: flickableDrawer.index == 7 ? "lightgray" : "transparent";
            //                height: flickableDrawer.height / 15;


            //                MouseArea
            //                {
            //                    anchors.fill: parent;
            //                    onClicked:
            //                    {
            //                        appWindow.categorySelected("academic");
            //                        myBar.close();
            //                    }

            //                }

            //            }

            //            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }

            //            NavigationButton{
            //                iconPath: "../../assets/images/v2/child-x64.png";
            //                text: qsTr("Çocuk");
            //                width: parent.width;
            //                color: flickableDrawer.index == 7 ? "lightgray" : "transparent";
            //                height: flickableDrawer.height / 15;


            //                MouseArea
            //                {
            //                    anchors.fill: parent;
            //                    onClicked:
            //                    {
            //                        appWindow.categorySelected("kids");
            //                        myBar.close();
            //                    }

            //                }

            //            }

            //            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }

            //            NavigationButton{
            //                iconPath: "../../assets/images/fa/kaçırdıklarınız ikon@3x.png";
            //                text: qsTr("Kaçırdıklarınız");
            //                width: parent.width;
            //                color: flickableDrawer.index == 3 ? "lightgray" : "transparent";
            //                height: flickableDrawer.height / 15;
            //                MouseArea
            //                {
            //                    anchors.fill: parent;
            //                    onClicked:
            //                    {
            //                        //                        if (navPane.depth != 1)
            //                        //                            navPane.goToPage(1);
            //                        appWindow.goHomepage();
            //                        appWindow.setSwipeIndexManually(3);
            //                        myBar.close();
            //                    }

            //                }

            //            }

            //            // space between content - see google material guide
            //            Item { Layout.fillWidth:  true; height: 8; }

        } // ColumnLayout myButtons
        ScrollIndicator.vertical: ScrollIndicator { }


    } // Flickable

    Rectangle
    {
        width: parent.width * 0.5;
        height: parent.height * .06;
        anchors.horizontalCenter: parent.horizontalCenter;
        color: appWindow.loggedIn ? "#a62727" : "#41cd52";
        radius: 15;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: height / 3;
        visible: false;

        Text {
            id: textAccoutControl;
            width: parent.width;
            height: parent.height;
            text: getDisplayText();
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap;
            verticalAlignment: Text.AlignVCenter
            color: "white"

            function getDisplayText()
            {
                if(appWindow.loggedIn)
                    return "Çıkış Yap";
                else
                    return "Giriş Yap";
            }
            function manageDisplay()
            {
                textAccoutControl.text  = getDisplayText();
                parent.color = appWindow.loggedIn ? appWindow.colorMain : "#41cd52";
            }


        }

        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                if (appWindow.loggedIn)
                {
                    appWindow.loggedIn = false;
                    ProfileManager.logOut();
                }
                else
                    appWindow.categorySelected("page_authantication");

                myBar.close();
            }
        }


    }

} // drawer
