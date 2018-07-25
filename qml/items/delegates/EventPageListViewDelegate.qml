import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
Component {
    id: eventListComponent
    Rectangle {

        id : elements
        width:  appWindow.width
        height: (appWindow.height / 8)
        anchors.margins: 20
//        anchors.horizontalCenter:  parent.horizontalCenter
        border{
            color: "lightgray";
            width: 2;
        }

        Row
        {
            spacing: 30;
            anchors.verticalCenter:  parent.verticalCenter;

            Image {
                id: eventIcon
                source: model.modelData.ImageURL;
                width:  elements.width * .3
                height: elements.height - 10 // Marginleri çıkardık
                sourceSize: Qt.size(width, height);

            }

            Rectangle{
                id: container
                height: eventIcon.height - 10;
                width:  appWindow.width - eventIcon.width - 30; //  - space.width

                ColumnLayout{
                    spacing: 1
                    anchors.fill: parent
                    anchors.margins: 10;
                    Row{
                        Text {
                            id: name
                            font.pointSize:  11
                            text: model.modelData.Name;
                            verticalAlignment: Text.AlignVCenter;
                            width: container.width *.7;
                            wrapMode: Text.WordWrap;
                        }

                        Rectangle{
                            id: add2FavouriteContainer;
                            width: container.width * 0.3;
                            height: container.height;
                            property real ref: Math.min(width, height) * .5;
                            Image
                            {
                                anchors.centerIn: parent;
                                source: "../../assets/images/fa/forward-x64.png";
                                sourceSize: Qt.size(parent.ref, parent.ref);


                            }

                            Popup
                            {
                                id: add2FavouritePopup;
                                margins: 0;
                                padding: 0;
                                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                                background: Rectangle{
                                    anchors.fill: parent;
                                    color: "transparent";
                                }

                                width: container.width * 0.1;
                                height: container.height * .5;
                                x: width;
                                y: height /2;

                                contentItem: Rectangle
                                {
                                    color: "transparent";
                                    anchors.fill: parent;
                                    border.color: "transparent";
                                    property real ref: Math.min(width, height) * .5;
                                    Image
                                    {
                                        id: fav;
                                        anchors.centerIn: parent;
                                        source: "../../assets/images/fa/love-x64.png";
                                        sourceSize: Qt.size(parent.ref, parent.ref);


                                    }

                                    ColorOverlay
                                    {
                                        source: fav;
                                        anchors.fill: parent;
                                        color : "red";
                                    }

                                    MouseArea
                                    {
                                        anchors.fill: parent;
                                        onClicked: {
                                            add2FavouritePopup.close();
                                            eventManager.add2Favourites(model.modelData.ID);
                                            console.log("Favorilere ekleme yazılacak");
                                        }
                                    }
                                }


                            }
                        }
                    }

                }

            }


        }



        MouseArea{
            anchors.fill: parent
            onPressAndHold: {
                mouse.accepted = true
                add2FavouritePopup.open()
            }
            onClicked: {
                appWindow.eventSelected(model);
            }
        }
    } // Rectangle ends
} // component ends
