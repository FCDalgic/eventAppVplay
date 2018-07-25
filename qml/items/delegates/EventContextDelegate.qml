import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"

Rectangle {

    id : contextDelegate
    width:   appWindow.width;
    height:  appWindow.height * 0.22;
    anchors.margins: 1;
    color: "lightgray";

    // Iconun Yer Alacağı Yer
    Rectangle
    {

        width: parent.height
        height: parent.width;
        anchors.left: parent.left;
        color: "transparent";

        Image
        {
            id: ikon;
            width: parent.width   * 0.9;
            height: parent.height * 0.9;
            source: ImageURL
            sourceSize: Qt.size(width, height);
            anchors.centerIn: parent;
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: mask
            }

        }

        Rectangle {
            id: mask
            width: ikon.width
            height: ikon.height
            radius: width < height ? width / 10 : height /10;
            visible: false

        }
    }

    // Detayların Yer Alacağı Kısım
    Rectangle
    {
        id: containerDetail;
        width: parent.width - parent.height;
        height: parent.height;
        color: "transparent";
        anchors.right: parent.right;
        ColumnLayout
        {
            anchors.fill: parent;

            Item{ Layout.fillWidth: true; height: contextDelegate.height * 0.1; }

            // Etkinliğin adının yer alacağı kısım
            Rectangle
            {
                width:  containerDetail.width;
                height: containerDetail.height *0.5;

                Text {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent;
                    wrapMode: Text.WordWrap;
                    fontSizeMode: Text.Fit
                    text: Name;
                }
            }

            // Etkinliğin yerinin bulunacağı kısım.
            Rectangle
            {
                width:  containerDetail.width;
                height: containerDetail.height *0.15;
                Text {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent;
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap;
                    text:  "Yer   : " + model.modelData.Yer;

                }
            }

            // Etkinliğin saatinin bulunacağı kısım.
            Rectangle
            {
                width:  containerDetail.width;
                height: containerDetail.height *0.15;

                Text {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent;
                    fontSizeMode: Text.Fit
                    wrapMode: Text.WordWrap;
                    text:  "Saat : " +  model.modelData.EventTime;
                }
            }

            Item{ Layout.fillWidth: true; height: contextDelegate.height * 0.1; }

        }
    }

    MouseArea{
        anchors.fill: parent
//        onPressAndHold: {
//            mouse.accepted = true
//            add2FavouritePopup.open()
//        }
        onClicked: {
            appWindow.eventSelected(model);
        }
    }
} // Rectangle ends
