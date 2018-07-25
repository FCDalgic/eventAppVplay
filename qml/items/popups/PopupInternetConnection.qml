import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../decoration/spaces"
Popup
{

    id: popupUpdatePassword;
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    modal: true;
    focus: true;

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2


    width : appWindow.width  * .7;
    height: contentContainer.height;

    opacity: 0.5;
    background: Rectangle
    {
        color: "white";
        radius: 30;
    }

    Rectangle
    {
        id: contentContainer;
        width: parent.width *.9;
        height:  space1.height + space2.height + space3.height + space4.height + space5.height + space2.height
               + border.height
               + header.maxHeight + content.maxHeight + optionOk.maxHeight;

        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        color: "transparent";

        IosSpaceBetweenContents
        {
            id: space1;
            anchors.top: parent.top;
        }

        Text {
            id: header;
            width: parent.width;
            text: "Hücresel Veri Kapalı";
            font.bold: true;
            font.pointSize: 17;
            wrapMode: Text.WordWrap;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: space1.bottom;
            property real maxHeight: Math.max(height , implicitHeight , contentHeight);
        }

        IosSpaceBetweenTexts
        {
            id:  space2;
            anchors.top: header.bottom
        }

        Text {
            id: content;
            width: parent.width;
            anchors.top: space2.bottom;
            text: "Verilere erişmek için Hücresel Veri'yi açın veya Wi-Fi'yi kullanın.";
            wrapMode: Text.WordWrap;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            property real maxHeight: Math.max(height , implicitHeight , contentHeight);

        }

        IosSpaceBetweenContents
        {
            id: space3;
            anchors.top: content.bottom;
        }


        Rectangle
        {
            id: border;
            width: parent.width;
            height: 6;
            color: appWindow.colorMain;
            anchors.top: space3.bottom;
        }

        IosSpaceBetweenTexts
        {
            id: space4;
            anchors.top: border.bottom;
        }

        Text
        {
            id: optionOk;
            width: parent.width *.9;
            anchors.top: space4.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("Tamam");
            color: appWindow.colorMain;
            font.bold: true;
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 17;
            horizontalAlignment: Text.AlignHCenter
            property real maxHeight: Math.max(height , implicitHeight , contentHeight);

            MouseArea
            {
                anchors.fill: parent;
                onClicked:popupUpdatePassword.close();
            }
        }
        IosSpaceBetweenTexts
        {
            id: space5;
            anchors.top: optionOk.bottom;
        }

    }


    signal popupClosing();

    NumberAnimation {
        id: popupAnimator;
        target: popupUpdatePassword
        property: "opacity"
        duration: appWindow.scrollTopInterval;
        from: 0.5;
        to: 1;
        easing.type: Easing.InOutQuad

    }

    onVisibleChanged:
    {
        if (visible)
        {
            popupAnimator.start();
        }
        else
        {
            opacity = 0.5;
        }
    }
}
