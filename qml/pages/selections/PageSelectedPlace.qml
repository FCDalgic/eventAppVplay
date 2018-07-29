import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/delegates"
import "../../items/delegates"
import "../../items/decoration/icons"
import "../../items/decoration/spaces"
import "../../items/map"
import VPlayApps 1.0


Page
{
    id: selectedPlacePage
    width: appWindow.width;
    height : appWindow.height;

    title: selectedEventTitle;
    backNavigationEnabled: true;
    property var model;
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
        id: selectedPlacePageFlickable;
        anchors.fill: parent;

        contentHeight: Math.max(root.implicitHeight, parent.height);
        //    anchors.fill: parent
        clip: true
        flickableDirection: Flickable.VerticalFlick

        NumberAnimation {
            id: scrollTopAnimator;
            target: selectedPlacePageFlickable
            property: "contentY"
            duration: appWindow.scrollTopInterval;
            from: selectedPlacePageFlickable.contentY;
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
                SpaceSelectedEventPageContents {}

                // Website
                TextFieldWithIconAndHeader
                {
                    id: site;
                    property string webSitesi: selectedPlacePage.model.modelData.Link;
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
                    headerText: "Phone";
                    detailText: selectedPlacePage.model.modelData.Telephone != "" ? selectedPlacePage.model.modelData.Telephone : "Bilinmiyor";


                    MouseArea
                    {
                        property string callNumber: selectedPlacePage.model.modelData.Telephone
                        anchors.fill: parent;
                        onClicked:
                        {
                            if (callNumber.length > 3 && callNumber != "Bilinmiyor" && callNumber != "Telefon numarası belirtilmemiş.")
                            {
                                Qt.openUrlExternally("tel:+" + callNumber);
                                //                            NativeController.directCall(callNumber);
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
                SpaceSelectedEventPageContents {visible: aciklama.visible}

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
                            property string coordinates :selectedPlacePage.model.modelData.Coordinate;
                            property string constant: "https://www.google.com/maps?saddr=My+Location&daddr=";
                            property string directionURL: "";

                            onClicked:
                            {
                                directionURL =  constant + coordinates;
                                Qt.openUrlExternally(directionURL);
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
                                text: "Get Directions"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: "white"
                            }
                        }
                    }

                }

            } // ColumnLayout myButtons

        }

    }
}

