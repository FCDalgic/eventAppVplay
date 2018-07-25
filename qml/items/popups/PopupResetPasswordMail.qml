import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
Popup
{

    id: popupFavourites;
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    modal: true;
    focus: true;

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2


    width : appWindow.width  * .7;
    height: appWindow.height / 5;
    opacity: 0.5;
    background: Rectangle{
        color: "white";
        radius: 15;
    }


    Text {
        id: dipslayMessage;
        width: parent.width *.9;
        height: parent.height;
        anchors.centerIn: parent;
        text: qsTr("");
        font.pointSize: 100
        minimumPointSize: 10
        fontSizeMode: Text.Fit
        wrapMode: Text.WordWrap;
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }

    signal popupClosing();

    // Koşullu olarak Görünür yapmak için
    // T: RESET MAİLİ GÖNDERİLDİ
    // F: KULLANICI KAYITLI DEĞİL.
    function showCase(pCase)
    {
        if (pCase)
        {
            dipslayMessage.text = qsTr("Şifrenizi sıfırlamanız için gerekli olan kod mail adresinize gönderilmiştir.");
        }
        else
        {
            dipslayMessage.text = qsTr("Girmiş olduğunuz mail adresi için kullanıcı bulunamadı. Lütfen tekrar deneyiniz veya kayıt olunuz")
        }

        visible = true;
    }


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
