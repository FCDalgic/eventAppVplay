import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
Popup
{

    id: popupLoginSuccess;
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    modal: true;
    focus: true;

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2


    width : appWindow.width / 2;
    height: appWindow.height /3;

    background: Rectangle{
        color: "white";
        radius: 15;
    }


    Image
    {
        id: animation
        anchors.top: parent.top;
        width: parent.width   / 2;
        height: parent.height  *.4;
        fillMode: Image.PreserveAspectFit;
        anchors.horizontalCenter: parent.horizontalCenter;
        source:"../../../assets/images/design/logo/Logo-Yeni.png";

    }

    Text {
        width: parent.width *.9;
        height: parent.height * 0.17;
        anchors.top:  animation.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: qsTr("Hoşgeldiniz!");

        font.pointSize: 100
        font.bold: true;
        minimumPointSize: 10
        fontSizeMode: Text.Fit
        wrapMode: Text.WordWrap;
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }

    Text {
        width: parent.width *.9;
        height: parent.height * 0.33;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: qsTr("Şehir Etkinlikleri olarak birbirinden güzel etkinliklerle dolu iyi eğlenceler dileriz.");
        font.pointSize: 100
        minimumPointSize: 10
        fontSizeMode: Text.Fit
        wrapMode: Text.WordWrap;
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter

    }

    onVisibleChanged:
    {
        if (visible)
        {
            console.log("Starting timer");
        }
    }
}
