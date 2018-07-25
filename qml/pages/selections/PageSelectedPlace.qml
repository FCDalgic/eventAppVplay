
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/delegates"
import "../../items/delegates"
import "../../items/decoration/icons"


Flickable {
    id: selectedPlacePage
    contentHeight: root.implicitHeight
    //    anchors.fill: parent
    clip: true
    flickableDirection: Flickable.VerticalFlick

    property var model;
    function setModelData(pModelData)
    {
        modelData = pModelData;
    }

    onModelChanged:
    {
        console.warn("Selected Place Model Changed");
    }

    property string eventID: "";
    Component.onCompleted:
    {
        eventID = model.modelData.ID ? model.modelData.ID : 0;
    }
    onEventIDChanged: console.log("Selected event page, event id changed...");

    // Sayfa Yukarı Kaydırılabilir mi?
    function canGoTop()
    {
        console.log("Can go Top Called Selected Event");
        return contentY >= 20 ? true : false;
    }

    NumberAnimation {
        id: scrollTopAnimator;
        target: selectedPlacePage
        property: "contentY"
        duration: appWindow.scrollTopInterval;
        from: contentY;
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
                            source: parent.getSource();
                            sourceSize: Qt.size(parent.width, parent.height)

                        }

                        ColorOverlay{
                            visible: parent.getSource().length > 5 ? false : true;
                            anchors.fill: resimIcon;
                            source: resimIcon;
                            color: "white"; // appWindow.colorMain // make image like it lays under red glass
                        }


                        function getSource()
                        {

                           var link = selectedPlacePage.model.modelData.Image ? selectedPlacePage.model.modelData.Image : "../../assets/images/v3/building-x512.png";
                           link = link.length > 5 ? link : "../../assets/images/v3/building-x512.png"

                            console.log("checking link : " + link);
                            return link;
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
                            text: selectedPlacePage.model.modelData.Name;
                            font.pixelSize: parent.height * .4;
                            wrapMode: Text.WordWrap;
                            width: parent.width;
                            opacity: 1;
                            color: "white"
                        }
                    }
                }
            }

            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent"; visible: resimRow.visible }
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent"; visible: resimRow.visible }

            //  // Açıklama
            //  TextFieldWithIconAndHeader
            //  {
            //      id: aciklama;
            //      iconHeight:appWindow.height / 20;
            //      Layout.fillWidth: true;
            //      width: parent.width;
            //
            //      headerWRatio: 0.55
            //      iconSrc: "../../assets/images/selectedEventPage/description.png";
            //      headerText: qsTr("Etkinlik Açıklaması");
            //      detailText: ""//selectedPlacePage.model.modelData.Description;
//          //        isLongText: true;
            //
            //  }
            //  // Boşluk
            //  Rectangle { visible: aciklama.visible;Layout.fillWidth: true; width: parent.width; height: 7; color: "transparent";}
            //  TextFieldWithIconAndHeader
            //  {
            //      id: aciklamaMetni;
            //      iconHeight:appWindow.height / 20;
            //      Layout.fillWidth: true;
            //      width: parent.width;
            //
            //      iconWRatio: 0;
            //      headerWRatio: 0;
            //      iconSrc: "../../assets/images/selectedEventPage/description.png";
            //      headerText: ""//qsTr("Etkinlik Açıklaması");
            //      detailText: selectedPlacePage.model.modelData.Description;
            //
            //  }
            //
            //  Rectangle {visible: saat.visible; Layout.fillWidth: true; width: parent.width; height: appWindow.height / 20; color: "transparent";}

            // Site
            TextFieldWithIconAndHeader
            {
                id: site;
                property string webSitesi: selectedPlacePage.model.modelData.Link;
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
                property string webSitesi: selectedPlacePage.model.modelData.Link;
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

            // Telefon
            TextFieldWithIconAndHeader
            {
                id: telefon;
                iconHeight:appWindow.height / 20;
                Layout.fillWidth: true;
                width: parent.width;

                iconSrc: "../../assets/images/selectedEventPage/telephone.png";
                headerText: "Telefon";
                detailText: selectedPlacePage.model.modelData.Telephone != "" ? selectedPlacePage.model.modelData.Telephone : "Bilinmiyor";


                MouseArea
                {
                    property string callNumber: selectedPlacePage.model.modelData.Telephone
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
                detailText: ""; // selectedPlacePage.model.modelData.Address;
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
                detailText:  selectedPlacePage.model.modelData.Address;
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
                                              + "center=" + selectedPlacePage.model.modelData.Coordinate + "&zoom=16&size=" + Math.ceil(760) + "x"  + Math.ceil(430)
                                              + "&markers=color:red|label:A|scale:2|" + selectedPlacePage.model.modelData.Coordinate + "|title:" + selectedPlacePage.model.modelData.Yer ;
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
                    property string origin :selectedPlacePage.model.modelData.Address;
                    property string directionURL: "";

                    onClicked:
                    {
                        origin = origin.replace(" ", "+");
                        origin = origin.replace(";", "+");
                        origin = origin.replace(".", "+");
                        origin = origin.replace("-", "+");
                        origin = origin.replace("/", "+");
                        directionURL =  "https://www.google.com/maps?saddr=My+Location&daddr=" + selectedPlacePage.model.modelData.Coordinate;

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
                        property string origin :selectedPlacePage.model.modelData.Address;
                        property string directionURL: "";

                        onClicked:
                        {
                            origin = origin.replace(" ", "+");
                            origin = origin.replace(";", "+");
                            origin = origin.replace(".", "+");
                            origin = origin.replace("-", "+");
                            origin = origin.replace("/", "+");
                            directionURL =  "https://www.google.com/maps?saddr=My+Location&daddr=" + selectedPlacePage.model.modelData.Coordinate;

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




    onFocusChanged: console.log("Selected page flickable focus : " + focus);
    ScrollIndicator.vertical: ScrollIndicator { }


    function whoAmI() {
        return qsTr("event")
    }
}
