import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
Popup
{

    id: popupSignupSuccess;
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    modal: true;
    focus: true;

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2


    width : appWindow.width * .8;
    height: message.implicitHeight + iconContainer.height;

    background: Rectangle{
        color: "white";
        radius: 15;
    }


    Rectangle
    {
        id:  iconContainer;
        color: "transparent";
        width: parent.width *.9;
        height: appWindow.height / 5;
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter;

        AnimatedImage
        {
            id: animatedIcon;
            source:"../../../assets/images/v3/check-circle.gif";
            anchors.centerIn: parent;
            height: parent.height;
            width: height;
            playing: false;

            onFrameChanged:
            {
                if (currentFrame == 90)
                {
                    paused = true;
                }
            }

        }
    }

    onVisibleChanged:
    {
        if (visible)
        {
            if (!animatedIcon.playing)
                animatedIcon.playing = true;

        }
        else
        {
            if (animatedIcon.playing)
                animatedIcon.playing = false;
        }
    }

    Text {
        id: message;
        width: parent.width *.9;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        text:
                  "<p></p>"
                + "<p>Üyeliğiniz gerçekleştirildi! Vakit ayırdığınız için teşekkür ederiz.\n</p>"
//                + "<p>Bu işlemin tamamlanması için size gelen aktivasyon mailindeki <b>Etkinleştir</b> butonuna tıklamanız gerekmektedir. Mail gelmediyse, <b>Spam</b>, <b>Gereksiz</b>, <b>Junk</b> maillerinizi kontrol etmeniz önerilir.</p>"
                + "<p></p>"
                + "<p>Hesabınızı etkinleştirmek için mailinizi kontrol etmeyi unutmayınız.\n</p>"
//                + "<p>Üye olduğunuz için,"
//                + "<ul type=\"bullet\">"
//                + "<li>İlgilendiğiniz etkinliği <b>Favoriler</b> ekleyebilirsiniz.</li>"
//                + "<li>Etkinlikleri sevdiklerinizle paylaşarak onların da haberdar olmasını sağlayabilirsiniz.</li>"
//                + "</ul>"
//                + "</p>"
//                + "<p>Şehir Etkinlikleri'ni tercih ettiğiniz için teşekkür ederiz.</p>"
        horizontalAlignment: Text.AlignHCenter
        //        font.pointSize: 100
//        minimumPointSize: 10
//        fontSizeMode: Text.Fit
        wrapMode: Text.WordWrap;
        verticalAlignment: Text.AlignVCenter

    }

}
