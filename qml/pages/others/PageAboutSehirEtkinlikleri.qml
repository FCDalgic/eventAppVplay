import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

import "../items"
import "../items/delegates"

Page
{
    id: homePage;
    width: appWindow.width;
    height : appWindow.height;


    // Sayfa Yukarı Kaydırılabilir mi?
    function canGoTop()
    {
        console.log("Can go Top Called About");
        return false;
    }
    function scrollTop()
    {
        scrollTopAnimator.start();
    }

    NumberAnimation {
        id: scrollTopAnimator;
        target: flickablePageAbout
        property: "contentY"
        duration: 1000;
        from: flickablePageAbout.contentY;
        to: 0;
        easing.type: Easing.InOutQuad
    }

    Flickable {
        id: flickablePageAbout;
        anchors.fill: parent;
        //    anchors.fill: parent
        clip: true
        contentHeight: mainLayout.height + 250;
        flickableDirection: Flickable.VerticalFlick

        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: appWindow.height  * 10;

        property var locale: Qt.locale()    // Get the local language

        Column {
            id: mainLayout
            focus: false
            width: parent.width* .9;
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 5;
            property bool isSearchEnabled: false;


            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            // Giriş metninin yer alacağım kısım.
            Rectangle
            {
                id: girisMetni;
                height: girisMetniIcerik.contentHeight;
                width: parent.width
                Text {
                    id: girisMetniIcerik;
                    anchors.centerIn: parent;
                    width: parent.width;
                    font.bold: true;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    color: appWindow.colorMain;
                    text:
                        "Amacı:";
                }

                color: "transparent";
            }
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            Rectangle
            {

                height: amacMetni.contentHeight;
                width: parent.width

                Text {
                    anchors.centerIn: parent;
                    id : amacMetni
                    width: parent.width;
                    horizontalAlignment: Text.AlignLeft;
                    wrapMode: Text.WordWrap;
                    text:
                          "<ul>"
                        + "<li>Şehir Etkinlikleri, sadece Ankara’da düzenlenen etkinlikleri, Sanat Eğlence, Eğitim, Çocuk gibi temel kategorilerde kullanıcıya sunmayı amaçlar. Şehir değiştirme özelliği bulunmamaktadır.</li>"
                        + "</ul>"
                }

                color: "transparent";
            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            Rectangle
            {
                height: kullanımBaslik.contentHeight;
                width: parent.width

                Text {
                    id: kullanımBaslik
                    anchors.centerIn: parent;
                    width: parent.width;
                    font.bold: true;
                    color: appWindow.colorMain;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    text:
                       "Kullanımı:";
                }

                color: "transparent";
            }
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}


            Rectangle
            {
                height: kullanımİcerik.contentHeight;
                width: parent.width

                Text {
                    id : kullanımİcerik
                    anchors.centerIn: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignLeft;
                    wrapMode: Text.WordWrap;
                    text:
                          "<ul>"
                        + "<li>Ana sayfada sınırlı sayıda gösterilen etkinliklerin tamamını görüntülemek için sayfayı aşağı kaydırıp <b>Tümünü Gör</b>e tıklayabilir, bu şekilde <b>Tüm Etkinlikler</b>i görebilirsiniz. Tüm Etkinlikler, içerisinde bulunduğunuz ay için sunulan etkinliklerdir. Sonraki ayın etkinlikleri, içerisinde bulunan ayın sonunda görüntülenebilir hale gelir.</li>"
                        + "<li>İlgilendiğiniz etkinliğe tıklayarak, etkinlik detaylarını görüntüleyebilirsiniz.</li>"
                        + "<li>Örneğin haritaya tıklayarak, etkinliğin düzenlendiği yer için adres tarifi alabilirsiniz.</li>"
                        + "<li><b>Paylaş</b> özelliği sayesinde, sevdiklerinizle paylaşarak onların da haberi olmasını sağlayabilirsiniz.</li>"
                        + "<li>Üye olup giriş yaparak, ilgilendiğiniz etkinlikleri <b>Favorileriniz</b>e ekleyebilirsiniz.</li>"
                        + "</ul>"
                }

                color: "transparent";
            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            Rectangle
            {
                height: kullanımBaslik.contentHeight;
                width: parent.width

                Text {
                    id: bilgilendirBaslik
                    anchors.centerIn: parent;
                    width: parent.width;
                    font.bold: true;
                    color: appWindow.colorMain;
                    horizontalAlignment: Text.AlignJustify;
                    wrapMode: Text.WordWrap;
                    text:
                       "Bilgilendirme:";
                }

                color: "transparent";
            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            Rectangle
            {
                height: bilgilendirmeİcerik.contentHeight;
                width: parent.width

                Text {
                    id : bilgilendirmeİcerik;
                    anchors.centerIn: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignLeft;
                    wrapMode: Text.WordWrap;
                    text:
                        "<ul>"
                      + "<li>Üyeliğinizi aktivasyon maili aracılığıyla tamamlamanız gerekmektedir. Mail gelmediyse, <b>Spam</b>, <b>Gereksiz</b>, <b>Junk</b> maillerinizi kontrol etmeniz önerilir.</li>"
                      + "<li>Sunulan etkinlikler için zaman, geçerlilik/iptal olma durumu gibi bilgiler teknik sebeplerden dolayı geç aktarılabileceği için, gitmeden önce teyit etmeniz önerilir.</li>"
                      + "</ul>"
                }

                color: "transparent";
            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            Rectangle
            {
                height: tesekkürİcerik.contentHeight;
                width: parent.width

                Text {
                    id : tesekkürİcerik;
                    anchors.centerIn: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignLeft;
                    wrapMode: Text.WordWrap;
                    text:"Şehir Etkinlikleri'ni tercih ettiğiniz için, teşekkür ederiz! " +
                         "Fikirleriniz bizim için değerli. Tüm görüş, öneri ve düşüncelerinizi bize mail yoluyla iletebilirsiniz, en kısa zamanda dönüş yapılacaktır. "
                         +"İletişim için: "
                }

                color: "transparent";
            }

            // Boşluk
            Rectangle { Layout.fillWidth: true; width: parent.width; height: 10; color: "transparent";}
            Rectangle
            {
                id:  iletisimMetni2
                width: parent.width
                height: iletisimMetni2Icerik.contentHeight;
                Text {
                    id : iletisimMetni2Icerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap;
                    linkColor: "#297fb8";
                    text:
                        "<a href='iletisim@sehir-etkinlikleri.com'>iletisim@sehir-etkinlikleri.com</a>";
                    onLinkActivated:Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bilgi&body=");

                }
            }




        } // ColumnLayout mainLayout




        ScrollIndicator.vertical: ScrollIndicator { }

    }


    function closeSearchPanel()
    {
        searchPopup.close();
    }

    property string lastHeader: "";
    Component.onCompleted:
    {
        console.log("Page about_se is completed");
        lastHeader = appWindow.selectedCategoryTitle;
//        appWindow.selectedCategoryTitle = qsTr("Hakkımızda");
//        appWindow.setHeaderByID(4);
    }


    function whatWasMyTitle()
    {
        return lastHeader;
    }

    function whoAmI()
    {
        return "about";
    }
}

