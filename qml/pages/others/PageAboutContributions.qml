import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

import "../../items"
import "../../items/delegates"

Page {

    id: homePage;
    width: appWindow.width;
    height : appWindow.height;


    // Sayfa Yukarı Kaydırılabilir mi?
    function canGoTop()
    {
        console.log("Can go Top Called About");
        return false;
    }
    function scrollTop()
    {
        scrollTopAnimator.start();
    }

    NumberAnimation {
        id: scrollTopAnimator;
        target: flickablePageAbout
        property: "contentY"
        duration: 1000;
        from: contentY;
        to: 0;
        easing.type: Easing.InOutQuad
    }

    Flickable {
        id: flickablePageAbout;
        anchors.fill: parent;
        //    anchors.fill: parent
        clip: true
        contentHeight: myButtons.height + 200;
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        maximumFlickVelocity: appWindow.height  * 10;

        property var locale: Qt.locale()    // Get the local language

        Column {
            id: myButtons
            focus: false
            width: parent.width;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top:parent.top;
            spacing: 5;
            property bool isSearchEnabled: false;


            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            // Giriş metninin yer alacağım kısım.
            Rectangle
            {
                id: girisMetni;
                height: girisMetniIcerik.contentHeight;
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;

                Text {
                    id: girisMetniIcerik;
                    anchors.centerIn: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    text:
                        "Şehir Etkinlikleri şimdiye kadar sizlere,";
                }

                color: "transparent";
            }

            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

            // Toplamda kaç farklı mekanda.
            Rectangle
            {
                id : numberOfPlaceIcon;
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height:  appWindow.height / 10;

                color: "transparent";
                Rectangle
                {
                    height: parent.height;
                    width: height;
                    radius: width/2;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    property real value: 0;
                    property int intValue: value
                    NumberAnimation on value { easing.type: Easing.Linear; from: 0; to: 176; duration: 1000 }
                    Text {
                        id: name
                        text: parent.intValue.toString();
                        anchors.centerIn: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        color: "white";
                        anchors.fill: parent;
                        anchors.margins: 5;
                    }
                }
            }
            Rectangle
            {
                id: numberOfPlace;
                height: numberOfPlaceContent.implicitHeight;
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;

                Text {
                    id: numberOfPlaceContent;
                    anchors.centerIn: parent;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    horizontalAlignment: Text.AlignHCenter;
                    text:"farklı yerdeki,";
                    //                    color: "#297fb8";
                }

                color: "transparent";
            }

            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

            // Toplamda kaç farklı etkinlik
            Rectangle
            {
                id : numberOfEventIcon;
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height:  appWindow.height / 10;

                color: "transparent";
                Rectangle
                {
                    height: parent.height;
                    width: height;
                    radius: width/2;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    property real value: 0;
                    property int intValue: value
                    NumberAnimation on value { easing.type: Easing.Linear; from: 0; to: 712; duration: 1000 }
                    Text {
                        text: parent.intValue.toString();
                        color: "white";
                        horizontalAlignment: Text.AlignHCenter;
                        verticalAlignment: Text.AlignVCenter
                        anchors.centerIn: parent;
                        anchors.fill: parent;
                        anchors.margins: 5;

                    }
                }
            }
            Rectangle
            {
                id: numberOfEvent;
                height: numberOfPlaceContent.implicitHeight;
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                Text {
                    id: numberOfEventContent;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    //                    color: "#297fb8";
                    text:"farklı etkinliği,";
                }

                color: "transparent";
            }

            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

            // Bilgilendirme metninin yer alacağım kısım.
            Rectangle
            {
                id:  bilgilendirmeMetni
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: bilgilendirmeMetniIcerik.contentHeight;
                Text {
                    id: bilgilendirmeMetniIcerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    text:
                        "sundu. ";
                }
            }
            Item
            {
                Layout.fillWidth: true;
                height: 18;
            }


            Rectangle { Layout.fillWidth: true; width: parent.width; height: appWindow.height / 20; color: "transparent";}

            // Login Button
            Rectangle
            {
                width: appWindow.width;
                height: appWindow.height / 18;
                color: "transparent";

                Rectangle
                {
                    id:  btnRecentEvents;
                    height: parent.height;
                    width: parent.width * .8;
                    radius: height *.25;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    Text
                    {
                        anchors.centerIn: parent;
                        height: parent.height;
                        text: qsTr("Güncel etkinlikler için tıklayınız");
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white";
                    }

                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            appWindow.categorySelected("all");
                            appWindow.setDrawerIndex(4);
                        }
                    }

                }

            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: appWindow.height / 25; color: "transparent";}

            // Login Button
            Rectangle
            {
                width: appWindow.width;
                height: appWindow.height / 18;
                color: "transparent";

                Rectangle
                {
                    id:  btnMissedEvents;
                    height: parent.height;
                    width: parent.width * .8;
                    radius: height *.25;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    Text
                    {
                        anchors.centerIn: parent;
                        height: parent.height;
                        text: qsTr("Geçmiş etkinlikler için tıklayınız");
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white";
                    }

                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            appWindow.categorySelected("missed");
                        }
                    }

                }

            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: appWindow.height / 25; color: "transparent";}

            // Login Button
            Rectangle
            {
                width: appWindow.width;
                height: appWindow.height / 18;
                color: "transparent";

                Rectangle
                {
                    id:  btnHomepage;
                    height: parent.height;
                    width: parent.width * .8;
                    radius: height *.25;
                    anchors.centerIn: parent;
                    color: appWindow.colorMain;
                    Text
                    {
                        anchors.centerIn: parent;
                        height: parent.height;
                        text: qsTr("Ana sayfaya dönmek için tıklayınız");
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white";
                    }

                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            appWindow.goHomepage();
                            appWindow.setSwipeIndexManually(0);
                        }
                    }

                }

            }

        } // ColumnLayout myButtons




        ScrollIndicator.vertical: ScrollIndicator { }

    }


    function closeSearchPanel()
    {
        searchPopup.close();
    }

    property string lastHeader: "";
    Component.onCompleted:
    {
        console.log("Page about completed");
        lastHeader = appWindow.selectedCategoryTitle;
        //        appWindow.selectedCategoryTitle = qsTr("Hakkımızda");
        //        appWindow.setHeaderByID(4);
    }


    function whatWasMyTitle()
    {
        return lastHeader;
    }

    function whoAmI()
    {
        return "about";
    }
}
