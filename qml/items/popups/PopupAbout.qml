import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Popup {
    id: popupFiltrele;
     property string selectedBtnName: "";
//    modal: true
//    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property date currentDate: new Date()
    property string dateString


    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    width  : appWindow.width  * 0.8;
    height : appWindow.height * 0.2;

    background: Rectangle
    {
        color: "#191d27"
        anchors.fill: parent;
    }


    Text {
        width: parent.width
        id: name
        text: qsTr("Görüş ve Önerileriniz İçin : \ndalgicsevgi.developer@gmail.com ");
        color: "white";
        anchors.centerIn: parent;
    }

}
