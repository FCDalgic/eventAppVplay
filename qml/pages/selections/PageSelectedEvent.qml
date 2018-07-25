import VPlayApps 1.0
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/delegates"
import "../../items/delegates"
import "../../items/decoration/icons"


Page
{
    id: selectedEventPage
    width: appWindow.width;
    height : appWindow.height;

    property var selectedEventModel;



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


                        // Favourite...
                        TextedIconSelectedEventPage
                        {
                            id:favButton
                            width: parent.height;
                            height: parent.height;
                            anchors.top: parent.top;
                            anchors.right: shareButton.left;
                            anchors.rightMargin: width/5;
                            iconPath:"../../assets/images/fa/love-x64.png";
                            iconColor:paintIcon();
                            iconText: "Favori";
                            textColor: "gray";

                            property bool isButtonEnabled: true;
                            MouseArea
                            {
                                anchors.fill: parent;
                                onClicked:
                                {
                                    if (!appWindow.checkInternetConnection())
                                        return;

                                    if (!appWindow.loggedIn)
                                    {
                                        appWindow.openPopupFavError(1);
                                        return;
                                    }

                                    if (!favButton.isButtonEnabled)
                                        return;

                                    favButton.isButtonEnabled = false;
                                    buttonEnabler.start();
                                    if (parent.iconColor === "red")
                                        eventManager.delFavourites(ProfileManager.getStoredMail(),
                                                                   ProfileManager.getStoredPass(),
                                                                   selectedEventPage.eventID);
                                    else
                                        eventManager.addFavourites(ProfileManager.getStoredMail(),
                                                                   ProfileManager.getStoredPass(),
                                                                   selectedEventPage.eventID);
                                }
                            }

                            Timer
                            {
                                id: buttonEnabler;
                                interval: 300;
                                running: false;
                                onTriggered:
                                {
                                    favButton.isButtonEnabled = true;
                                    stop();
                                }

                            }

                            function paintIcon()
                            {
                                try
                                {
    //                                if (selectedEventPage == null || selectedEventPage.selectedEventModel === null)
    //                                    return "gray";

                                    if (ProfileManager.isEventFavourite(selectedEventPage.eventID))
                                        return "red";
                                    else
                                        return "gray";
                                }
                                catch(err)
                                {
                                    return "gray";
                                }
                            }

                        }

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
                            iconText: "Paylaş";
                            textColor: "gray";
                            MouseArea
                            {
                                anchors.fill: parent;
                                onClicked:
                                {
                                    SehirUtils.prepareContentAndShare(selectedEventPage.eventID);
                                }
                            }
                        }
                    }
                }

                // Boşluk
                Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
                Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

                // Açıklama
                TextFieldWithIconAndHeader
                {
                    id: aciklama;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    headerWRatio: 0.55
                    iconSrc: "../../assets/images/selectedEventPage/description.png";
                    headerText: qsTr("Etkinlik Açıklaması");
                    detailText: ""//selectedEventPage.selectedEventModel.modelData.Description;
    //                isLongText: true;

                }
                // Boşluk
                Rectangle { visible: aciklama.visible;Layout.fillWidth: true; width: parent.width; height: 7; color: "transparent";}
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

                Rectangle {visible: saat.visible; Layout.fillWidth: true; width: parent.width; height: appWindow.height / 20; color: "transparent";}

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
                    headerText: "Link";
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
                Rectangle { visible: site.visible;Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

                TextFieldWithIconAndHeader
                {
                    id: tarih;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconSrc: "../../assets/images/selectedEventPage/date.png";
                    headerText: "Tarih";
                    detailText: selectedEventPage.selectedEventModel.modelData.EventDate;
                }

                // Boşluk
                Rectangle { visible: tarih.visible;Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

                TextFieldWithIconAndHeader
                {
                    id:saat;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/clock.png";
                    headerText: "Saat";
                    detailText: selectedEventPage.selectedEventModel.modelData.EventTime;

                    visible: detailText.length > 0 ? true : false;
                }

                // Boşluk
                Rectangle {visible: saat.visible; Layout.fillWidth: true; width: parent.width; height: appWindow.height / 20; color: "transparent";}

                TextFieldWithIconAndHeader
                {
                    id: yer;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;
                    iconSrc: "../../assets/images/fa/tag-x64.png";
                    headerText: "Yer";
                    detailText: selectedEventPage.selectedEventModel.modelData.Yer;
                }

                // Boşluk
                Rectangle {visible: yer.visible; Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}


    //            // Ücret Bilgisi
    //            TextFieldWithIconAndHeader
    //            {
    //                id: ucret;
    //                property string ucretBilgisi:  selectedEventPage.selectedEventModel.modelData.Tag1 // parent.calcUcret(selectedEventPage.selectedEventModel.modelData.Tag1);
    //                visible: false; // ucretBilgisi.length > 1 ? true : false;
    //                iconHeight:appWindow.height / 20;
    //                Layout.fillWidth: true;
    //                width: parent.width;

    //                iconSrc:  "../../assets/images/fa/tl-icon.png";
    //                headerText: "Ücret";
    //                detailText: ucretBilgisi

    //            }
    //            function calcUcret(text)
    //            {
    //                console.log("Ücret bilgisi : " + text);
    //                return (text == "Ücretli" || text == "Ücretsiz" || text == "Bilinmiyor") ? model.modelData.Tag1 : "";
    //            }

    //            // Boşluk
    //            Rectangle { visible: ucret.visible;Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

                // Telefon
                TextFieldWithIconAndHeader
                {
                    id: telefon;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/telephone.png";
                    headerText: "Telefon";
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
                                //                            NativeController.directCall(callNumber);
                            }
                        }
                    }
                }
                // Boşluk
                Rectangle { visible: telefon.visible;Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}



                // Address
                TextFieldWithIconAndHeader
                {
                    id: adres;
                    iconHeight:appWindow.height / 20;
                    Layout.fillWidth: true;
                    width: parent.width;

                    iconSrc: "../../assets/images/selectedEventPage/pin.png";
                    headerText: "Adres";
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
                Rectangle
                {
                    color:"transparent";
                    width: parent.width;

                }

                // Boşluk
                Rectangle {visible: adres.visible; Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

                Rectangle
                {
                    visible: true;
                    width: parent.width;
                    height: 500;
                    Layout.fillWidth: true;
                    color: "transparent";

                    Image {
                        id: googleMapStaticImage;
                        property string constant: "https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyD3crnSmwEYtw31-5FKBKr5H-xAEpNgzvU&"
                                                  + "center=" + selectedEventPage.selectedEventModel.modelData.Coordinate + "&zoom=16&size=" + Math.ceil(760) + "x"  + Math.ceil(430)
                                                  + "&markers=color:red|label:A|scale:2|" + selectedEventPage.selectedEventModel.modelData.Coordinate + "|title:" + selectedEventPage.selectedEventModel.modelData.Yer ;
                        property variant temp;
                        property string latitude: "-34.397";
                        property string longitude: "150.644";

                        source: constant;
                        width: parent.width;
                        height: parent.height;
                        sourceSize: Qt.size(width ,  height);

                        function prepareMap()
                        {
                            temp = pCoordinate.split(",");
                            latitude = temp[0];
                            longitude = temp[1];

                        }

                    }

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
                        }
                    }

                    //                Rectangle
                    //                {
                    //                    width: parent.width * 0.7;
                    //                    height: parent.height;
                    //                    anchors.right:  parent.right;
                    //                    anchors.rightMargin: parent.width * 0.03;

                    //                }


                }

                Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}

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
                                text: "Adres Tarifi Al"
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

