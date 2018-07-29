import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/delegates"
import "../../items/delegates"
import "../../items/decoration/icons"
import "../../items/map"
import "../../items/decoration/spaces"

import VPlayApps 1.0


Page
{
    id: selectedEventPage
    width: appWindow.width;
    height : appWindow.height;

    title: selectedEventTitle;
    backNavigationEnabled: true;
    property var selectedEventModel;
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
                onClicked: appWindow.openNavDrawer();
                anchors.fill: parent;
            }
          }
        }
      } // NavigationBarItem

    Flickable {
        id: selectedEventPageFlickable;
        anchors.fill: parent;

        contentHeight: root.implicitHeight
        //    anchors.fill: parent
        clip: true
        flickableDirection: Flickable.VerticalFlick

        NumberAnimation {
            id: scrollTopAnimator;
            target: selectedEventPageFlickable
            property: "contentY"
            duration: appWindow.scrollTopInterval;
            from: selectedEventPageFlickable.contentY;
            to: 0;
            easing.type: Easing.InOutQuad
        }
        function scrollTop()
        {
            scrollTopAnimator.start();
        }
        MouseArea
        {
            anchors.fill: parent;
            onClicked: searchAreaContaier.focus = false;
        }
        Pane {
            id: root
            anchors.fill: parent


            Column {
                id: myButtons
                focus: false
                width: parent.width;
                anchors.right: parent.right
                anchors.left: parent.left
                spacing: 5;


                // Etkinlik resminin bulunduğu en üstteki kısım. Ayrıca etkinliği ismini de gösterecektir.
                Rectangle
                {
                    id: resimRow;
                    Layout.fillWidth: true;
                    width: parent.width;
                    height: appWindow.height*0.36;
                    property string src: selectedEventPage.selectedEventModel.modelData.ImageURL;
                    // https://img.kurumsalb2c.com/products/noimage.jpg

                    //                visible: src.length > 5 ? true : false;

                    Item {
                        id: eventPhotoHolder
                        width: parent.width;
                        anchors.top: parent.top;
                        height: appWindow.height*0.33;
                        Rectangle
                        {
                            anchors.fill: parent

                            Image {
                                id : resimIcon
                                anchors.fill: parent
                                width: parent.width;
                                height: parent.height;
                                source: resimRow.src.length > 5  ? resimRow.src :  "http://blog.cliaweb.com/wp-contenat/uploads/not-found.png" //modelData.ImageURL;
                                sourceSize: Qt.size(parent.width, parent.height)
                            }

                            ColorOverlay{
                                visible: resimRow.src.length > 5 ? false : true;
                                anchors.fill: resimIcon;
                                source: resimIcon;
                                color: appWindow.colorMain // make image like it lays under red glass
                            }

                        }



                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: parent.height / 4;
                            color: "#34495e"
                            opacity: 0.7;
                            radius: 10;
                            Text {
                                id: name
                                anchors.bottom: parent.bottom
                                text: selectedEventPage.selectedEventModel.modelData.Name;
                                font.pixelSize: parent.height * .4;
                                wrapMode: Text.WordWrap;
                                width: parent.width;
                                opacity: 1;
                                color: "white"
                            }
                        }
                    }

                    Rectangle {
                        id: buttonContainer;
                        width: parent.width;
                        //                    anchors.bottom: parent.bottom;
                        height: appWindow.height*0.09; // appWindow.height*0.06;
                        anchors.verticalCenterOffset: (0 -  appWindow.height * 0.02);

                        anchors.verticalCenter: parent.bottom;
                        color: "transparent";
                        z: 2;


                        // Share...
                        TextedIconSelectedEventPage
                        {
                            id:shareButton
                            width: parent.height;
                            height: parent.height;
                            anchors.top: parent.top;
                            anchors.right: parent.right;
                            anchors.rightMargin: parent.width*0.05;
                            iconPath:  "../../assets/images/fa/share-x64.png";
                            iconColor: "#41cd52";
                            iconText: "Share";
                            textColor: "gray";
                            MouseArea
                            {
                                anchors.fill: parent;
                                onClicked:
                                {
                                    nativeUtils.share("Let's go to this event!" ,"http://sehir-etkinlikleri.com/android/share.php" + "?SEID=" + selectedEventPage.eventID)
                                }
                            }
                        }
                    }
                }

                // Boşluk
                SpaceSelectedEventPageContents {}

                // Açıklama
                TextFieldWithIconAndHeader
                {
                    id: aciklama;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    headerWRatio: 0.55
                    iconSrc: "../../assets/images/selectedEventPage/description.png";
                    headerText: qsTr("Description");
                    detailText: ""//selectedEventPage.selectedEventModel.modelData.Description;
    //                isLongText: true;

                }
                // Boşluk
                SpaceSelectedEventPageContents {visible: aciklama.visible}

                TextFieldWithIconAndHeader
                {
                    id: aciklamaMetni;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconWRatio: 0;
                    headerWRatio: 0;
                    iconSrc: "../../assets/images/selectedEventPage/description.png";
                    headerText: ""//qsTr("Etkinlik Açıklaması");
                    detailText: selectedEventPage.selectedEventModel.modelData.Description;

                }

                SpaceSelectedEventPageContents {visible: saat.visible}

                // Site
                TextFieldWithIconAndHeader
                {
                    id: site;
                    property string webSitesi: selectedEventPage.selectedEventModel.modelData.Link;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    visible: webSitesi.length > 1 ? true : false;
                    iconSrc: "../../assets/images/selectedEventPage/link.png";
                    headerText: "Website";
                    isLink: true;
                    detailText: ""; //webSitesi != "" ? webSitesi : "Bilinmiyor"
                }
                TextFieldWithIconAndHeader
                {
                    id: siteMetin;
                    property string webSitesi: selectedEventPage.selectedEventModel.modelData.Link;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconWRatio: 0;
                    headerWRatio: 0;
                    visible: webSitesi.length > 1 ? true : false;
                    iconSrc: "../../assets/images/selectedEventPage/link.png";
                    headerText: "";
                    isLink: true;
                    linkFontColor: "#3683a9"
                    detailText: webSitesi != "" ? webSitesi : "Bilinmiyor"

                    function getHRef()
                    {
                        return "<a href=" + webSitesi + ">" + webSitesi + "</a>";
                    }
                }
                // Boşluk
                SpaceSelectedEventPageContents {visible: site.visible}

                TextFieldWithIconAndHeader
                {
                    id: tarih;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconSrc: "../../assets/images/selectedEventPage/date.png";
                    headerText: "Date";
                    detailText: selectedEventPage.selectedEventModel.modelData.EventDate;
                }

                // Boşluk
                SpaceSelectedEventPageContents {visible: tarih.visible}

                TextFieldWithIconAndHeader
                {
                    id:saat;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/clock.png";
                    headerText: "Time";
                    detailText: selectedEventPage.selectedEventModel.modelData.EventTime;

                    visible: detailText.length > 0 ? true : false;
                }

                // Boşluk
                SpaceSelectedEventPageContents {visible: saat.visible}

                TextFieldWithIconAndHeader
                {
                    id: yer;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconSrc: "../../assets/images/fa/tag-x64.png";
                    headerText: "Place";
                    detailText: selectedEventPage.selectedEventModel.modelData.Yer;
                }

                // Boşluk
                SpaceSelectedEventPageContents {visible: yer.visible}
                // Telefon
                TextFieldWithIconAndHeader
                {
                    id: telefon;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/telephone.png";
                    headerText: "Phone";
                    detailText: selectedEventPage.selectedEventModel.modelData.Telephone != "" ? selectedEventPage.selectedEventModel.modelData.Telephone : "Bilinmiyor";


                    MouseArea
                    {
                        property string callNumber: selectedEventPage.selectedEventModel.modelData.Telephone
                        anchors.fill: parent;
                        onClicked:
                        {
                            if (callNumber.length > 3 && callNumber != "Bilinmiyor")
                            {
                                Qt.openUrlExternally("tel:+" + callNumber);
                            }
                        }
                    }
                }
                // Boşluk
                SpaceSelectedEventPageContents {visible: telefon.visible}



                // Address
                TextFieldWithIconAndHeader
                {
                    id: adres;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/pin.png";
                    headerText: "Address";
                    detailText: ""; // selectedEventPage.selectedEventModel.modelData.Address;
                }

                TextFieldWithIconAndHeader
                {
                    id: adresİcerik;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconWRatio: 0;
                    headerWRatio: 0;
                    iconSrc: "../../assets/images/selectedEventPage/pin.png";
                    headerText: "";
                    detailText:  selectedEventPage.selectedEventModel.modelData.Address;
                }


                // Boşluk
                SpaceSelectedEventPageContents {visible: adres.visible}

                GoogleStaticMapItem
                {
                    visible: true;
                    width: parent.width;
                    height: dp(200);
                    Layout.fillWidth: true;
                    color: "transparent";

                    staticApiKey: "AIzaSyD3crnSmwEYtw31-5FKBKr5H-xAEpNgzvU";
                    latitude: getLatitudeFromInput(selectedPlacePage.model.modelData.Coordinate);
                    longitude: getLongitudeFromInput(selectedPlacePage.model.modelData.Coordinate);
                    title:selectedPlacePage.model.modelData.Name;

                    enableGetDirection: true;
                    function getLatitudeFromInput(pInput)
                    {
                        var temp = pInput.split(",");
                        return temp[0];
                    }
                    function getLongitudeFromInput(pInput)
                    {
                        var temp = pInput.split(",");
                        return temp[1];
                    }
                }

                Rectangle { Layout.fillWidth: true; width: parent.width; height: dp(14); color: "transparent";}

                Rectangle
                {
                    visible: true;
                    width: parent.width;
                    height: appWindow.height / 15;
                    Layout.fillWidth: true;
                    color: "transparent";

                    Rectangle
                    {
                        width: parent.width * .98;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: parent.height;
                        radius: height * .2
                        color: appWindow.colorMain;

                        MouseArea
                        {
                            anchors.fill: parent;
                            property string directionAPIKey : "AIzaSyBjCFhR7k4a7pQ7DPrcWtu2t18F7vgxV4c";
                            property string origin :selectedEventPage.selectedEventModel.modelData.Address;
                            property string directionURL: "";

                            onClicked:
                            {
                                origin = origin.replace(" ", "+");
                                origin = origin.replace(";", "+");
                                origin = origin.replace(".", "+");
                                origin = origin.replace("-", "+");
                                origin = origin.replace("/", "+");
                                directionURL =  "https://www.google.com/maps?saddr=My+Location&daddr=" + selectedEventPage.selectedEventModel.modelData.Coordinate;

                                console.log("Trying to open google maps : "  + directionURL);
                                Qt.openUrlExternally(directionURL);
                                // Qt.openUrlExternally("https://www.google.com/calendar/render?action=TEMPLATE&text=%C5%9Eehir+Etkinlikleri&details=Test+etkinlik&location=Ankara&dates=20180414T151100Z%2F20180415T151100Z");
                            }
                        }

                        Rectangle
                        {
                            width: directionsIcon.width +directionsContent.width + 10;
                            height: parent.height;
                            color: "transparent";
                            anchors.centerIn: parent;

                            ColorableIcon
                            {
                                id: directionsIcon;
                                width: height;
                                height: parent.height;
                                color: "transparent";
                                iconPath:"../../assets/images/fa/location-x64.png"
                                anchors.left: parent.left;
                                overlayColor: "white"
                            }

                            Text
                            {
                                id: directionsContent;
                                height: parent.height;
                                anchors.right: parent.right;
                                text: "Directions"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: "white"
                            }

                        }


                    }

                }

            } // ColumnLayout myButtons


        }




       //  ScrollIndicator.vertical: ScrollIndicator { }


        function whoAmI() {
            return qsTr("event")
        }
    }

}

