import QtQuick 2.0
import QtQml.Models 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "../../../items"

Rectangle
{
    id: bilgilendirme;
    width: parent.width;
    height: appWindow.height / 6;
    color: "white";
    anchors.top: parent.top;
    radius: height / 5;

    property string iconPath: "../../assets/images/fa/info-x256.png";
    property string message: "";
    property string closeIconPath: "../../assets/images/fa/close-x256.png";

    ColorableIcon
    {
        id: bilgilendirmeResim;
        width: height;
        iconPath: parent.iconPath;
        height: parent.height / 3;
        color: "transparent";
//            overlayColor: "white";
        anchors.left: parent.left;
        anchors.top:parent.top;

        Component.onCompleted:
        {
            var oran = (height / appWindow.height);
            console.log("Ekran yükseklik oranı: " + oran);
        }
    }

    Rectangle
    {
        id: bilgilendirmeMetniTutucu;
        width: parent.width - ( bilgilendirmeResim.height + kapatbutonu.height + 10);
        height: parent.height;
        color: "transparent";
        anchors.left: bilgilendirmeResim.right;


        Text
        {
            width: parent.width * .95;
            anchors.centerIn: parent;
            height: parent.height;
            text:   "Ankara’da düzenlenen yemek workshoplarından tadım günlerine pek çok gurme etkinliği, çok yakında Şehir Etkinlikleri’nde sizlerle... ";
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap;
            horizontalAlignment: Text.AlignLeft;
            color:"gray";
        }
    }
    ColorableIcon
    {
        id: kapatbutonu;
        width: height;
        iconPath: parent.closeIconPath;
        height: parent.height / 3;
        color: "transparent";
//            overlayColor: "white";
        overlayColor: "gray";
        anchors.top:parent.top;
        anchors.left: bilgilendirmeMetniTutucu.right;

        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                parent.parent.height = 0;
                parent.parent.visible = false;
            }
        }
    }


}
