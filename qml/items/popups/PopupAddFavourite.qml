import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../decoration/spaces"
Popup
{

    id: popupFavourites;
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
        height:  space1.height + space2.height + space3.height + space4.height + space5.height + space5.height
               + border.height
               + header.maxHeight + content.maxHeight
               + optionsContainer.height;

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
            text: "Favoriler Güncellenemedi";
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
            text:     "   Bu özellikten faydalanabilmeniz için, giriş yapmanız gerekmektedir.\n"
                    + "   Giriş yaparak, ilgilendiğiniz etkinliği \"Favoriler\"e ekleyebilirsiniz."

            wrapMode: Text.WordWrap;
            verticalAlignment: Text.AlignVCenter
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
            Rectangle
            {
                id: leftspace;
                width: (parent.width/2) - 3;
                height: parent.height;
                color: "transparent";
                anchors.left: parent.left;
                anchors.top : parent.top;
            }
            Rectangle
            {
                width: 6;
                height: parent.height;
                color: appWindow.colorMain;
                anchors.left: leftspace.right;
                anchors.top: parent.top;
            }
        }

        Rectangle
        {
            id: optionsContainer;
            width: parent.width;
            color: "transparent";
            anchors.top: space4.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: Math.max(optionOk.maxHeight  , optionSkip.maxHeight);

            Text
            {
                id: optionOk;
                width: (parent.width/2) - 3;
                anchors.left: parent.left;
                anchors.top: parent.top;
                text: qsTr("Giriş Yap");
                color: appWindow.colorMain;
                font.bold: true;
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 17;
                horizontalAlignment: Text.AlignHCenter
                property real maxHeight: Math.max(height , implicitHeight , contentHeight);

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:{
                        popupFavourites.close();
                        appWindow.categorySelected("page_authantication");
                    }
                }

            }
            Rectangle
            {
                width: 6;
                height: parent.height;
                anchors.left: optionOk.right;
                anchors.top: parent.top;
                color:  appWindow.colorMain;
            }

            Text
            {
                id: optionSkip;
                width: (parent.width/2) - 3;
                anchors.right: parent.right;
                anchors.top: parent.top;
                text: qsTr("Daha Sonra");
                color: appWindow.colorMain;
                font.bold: true;
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 17;
                horizontalAlignment: Text.AlignHCenter
                property real maxHeight: Math.max(height , implicitHeight , contentHeight);

                MouseArea
                {
                    anchors.fill: parent;
                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked: popupFavourites.close();
                    }
                }
            }

        }


        IosSpaceBetweenTexts
        {
            id: space5;
            anchors.top: optionsContainer.bottom;
            Rectangle
            {
                id: leftspace2;
                width: (parent.width/2) - 3;
                height: parent.height;
                color: "transparent";
                anchors.left: parent.left;
                anchors.top : parent.top;
            }
            Rectangle
            {
                width: 6;
                height: parent.height;
                color: appWindow.colorMain;
                anchors.left: leftspace2.right;
                anchors.top: parent.top;
            }
        }

    }


    signal popupClosing();

    NumberAnimation {
        id: popupAnimator;
        target: popupFavourites
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

