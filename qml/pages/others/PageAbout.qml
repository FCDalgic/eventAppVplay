import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

import "../../items"
import "../../items/delegates"

Page
{
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
        target: flickablePageSelectedCategory
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
                        "   Şehir Etkinlikleri, Ankara'da düzenlenen tiyatrolardan konserlere, fuarlardan sergilere, seminerlerden eğitimlere, kısacası şehre dair ne varsa sizlere kolaylıkla ulaştırmayı amaçlamaktadır. Şimdiye kadar sizlere,";
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
                        "sunduk. Söz konusu etkinliklerin hiçbiri tarafımızca organize edilmemektedir." +
                        " Bu sebeple etkinliğe katılmadan önce özellikle yer ve" +
                        " saat bilgilerini kontrol etmeniz önerilir.";
                }
            }
            Item
            {
                Layout.fillWidth: true;
                height: 18;
            }


            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

            // İletişim bilgilerinin yer alacağı kısım
            // Bilgilendirme metninin yer alacağım kısım.

            Rectangle
            {
                id:  iletisimMetni
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: iletisimMetniIcerik.contentHeight;
                Text {
                    id: iletisimMetniIcerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    text:
                        "   Fikirleriniz bizim için değerli! Tüm görüş, öneri ve düşüncelerinizi bize mail yoluyla iletebilirsiniz, en kısa zamanda tarafınıza dönüş yapılacaktır. "
                        +"İletişim için: ";
                    onLinkActivated: Qt.openUrlExternally(link);
                }
            }


            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 10; color: "transparent";}
            Rectangle
            {
                id:  iletisimMetni2
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: iletisimMetni2Icerik.contentHeight;
                Text {
                    id : iletisimMetni2Icerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    wrapMode: Text.WordWrap;
                    linkColor: "#297fb8";
                    text:
                        "<a href='iletisim@sehir-etkinlikleri.com'>iletisim@sehir-etkinlikleri.com</a>";
                    MouseArea
                    {
                        anchors.fill: parent;

                        onClicked:  Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bilgi&body=");
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 10; color: "transparent";}

            // Sloganın yer alacağı kısım
            // Bilgilendirme metninin yer alacağım kısım.

            Rectangle
            {
                id:  slogan
                width: parent.width * 0.9;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: sloganIcerik.contentHeight;

                Text {
                    id: sloganIcerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    wrapMode: Text.WordWrap;
                    text:
                        "Şehir Etkinlikleri ile gelin beraber şehrin tadını çıkaralım!"
                    font.bold: true;
                    onLinkActivated: Qt.openUrlExternally(link);
                    color: appWindow.colorMain;
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
