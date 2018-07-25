import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

import "../../items"
import "../../items/delegates"
import "../../items/decoration/messages/termsandconditions"
Page
{
    id: termsAndConditions;
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
            // Başlık
//            Rectangle
//            {
//                id: girisMetni;
//                height: girisMetniIcerik.contentHeight;
//                width: parent.width
//                Text {
//                    id: girisMetniIcerik;
//                    anchors.centerIn: parent;
//                    width: parent.width;
//                    font.bold: true;
//                    horizontalAlignment: Text.AlignLeft;
//                    wrapMode: Text.WordWrap;
//                    color: appWindow.colorMain;
//                    text:
//                        "Kullanım Koşulları:";
//                }

//                color: "transparent";
//            }

            Rectangle { Layout.fillWidth: true; width: parent.width; height: 14; color: "transparent";}
            // Giriş metninin yer alacağım kısım.
            HeaderTermsAndConditions
            {
                 text:"1. Koşulların Kabul Edilmesi";
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text:"Şehir Etkinlikleri’ne Hoş Geldiniz! Kullanım Koşulları, siz ve Şehir Etkinlikleri arasındadır. Yazılım içeriği, sunduğu hizmetler ve web sitesi içeriği dahil olmak üzere akıllı telefon uygulamasını kullanmanız ile "
+"ilgili yasal anlaşmayı düzenler. Bu sebeple, uygulamayı kullanarak Kullanım Koşulları’nı kabul etmiş "
+"olursunuz.";
            }

            SpaceTermsAndConditions{}

            // 2. Madde
            HeaderTermsAndConditions
            {
                 text:"2. Yasal Yetki";
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text:"Uygulamanın kullanımı ya da giriş yapılması, sadece reşit olan kullanıcılar için uygundur. Kullanım Koşulları’nı kabul ederek, şartları anladığınızı kabul ve beyan etmiş olursunuz.";
            }

            SpaceTermsAndConditions{}

            // 3. Madde
            HeaderTermsAndConditions
            {
                text:"3. Güncellemeler";

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Kullanım Koşulları’nın bir parçası olarak, Şehir Etkinlikleri; güncellemeler yapmayı tercih edebilir. "+
                      "Bu güncellemeler, 3. parti cihazlar ve platformlar tarafından otomatik olarak indirilebilir ve yüklenebilir. "+
                      "Uygulamadaki güncellemeler; yazılımsal sorunların giderilmesi, eklenecek özelliklerle ilgili geliştirmeler yapılması ya da tamamıyla farklı bir versiyon çıkarmak amacıyla olabilir.";
            }

            SpaceTermsAndConditions{}

            // 4. Madde
            HeaderTermsAndConditions
            {
                text:"4. Kullanım Koşulları’nın Değiştirilmesi"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, Kullanım Koşulları’nın tamamını veya bir kısmını geçici ya da kalıcı olarak değiştirme hakkını gizli tutar.";
            }

            SpaceTermsAndConditions{}

            // 5. Madde
            HeaderTermsAndConditions
            {
                text:"5. Kullanım Kısıtları"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, Ankara’da gerçekleşen etkinlikleri herhangi bir siyasi ya da dini amaç taşımaksızın "
                      +"kullanıcıya ulaştıran bir uygulamadır. Uygulamanın illegal yollarla ya da insanları rahatsız etmek için "
                      +"kullanılması yasaktır. Etkinlikler bağımsızdır. Kullanım Koşulları’nı kabul ederek, doğabilecek herhangi bir "
                      +"riskten Şehir Etkinlikleri’nin sorumlu tutulamayacağını kabul etmiş olursunuz.";
            }

            SpaceTermsAndConditions{}

            // 6. Madde
            HeaderTermsAndConditions
            {
                text:"6. İçerik"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "İçerik, uygulamada üretilen ve kullanıcıya sunulan etkinlik, etkinlik detayları, konum, "
                    + "resim gibi bilgilerdir. Kullanım Koşulları’nı kabul ederek, içeriğin özel ya da herkese "
                    + "açık olarak paylaşılmasının, yalnızca paylaşan kişinin sorumluluğunda olduğunu "
                    + "anladığınızı kabul ve beyan etmiş olursunuz. Şehir Etkinlikleri; içeriğin "
                    + "paylaşılmasından, çeşitli internet platformlarına yüklenmesinden, taşınmasından, "
                    + "saklanmasından ya da diğer yöntemlerle yayılmasından sorumlu değildir. "
                    + "Uygulamanın içeriği gerçek zamanlı olarak kontrol edilememektedir. Bu sebeple "
                    + "içeriğin doğruluğu, bütünlüğü ve kalitesinin garantisi verilememektedir. Buna "
                    + "rağmen, Şehir Etkinlikleri her zaman içeriğin kalitesine ve uygunluğuna karar verme "
                    + "hakkına sahiptir. İçeriği düzenleyebilir, itiraz edebilir, hatta ön ihtar vermeksizin "
                    + "içeriği kaldırabilir."
            }

            SpaceTermsAndConditions{}

            // 7. Madde
            HeaderTermsAndConditions
            {
                text:"7. Uygulamanın Kullanımı"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Bu Kullanım Koşulları’nı kabul ederek, Şehir Etkinlikleri’ni yasalara aykırı, taciz edici, tehdit edici, zararlı, hileli, iftira niteliğinde, küfürlü, şiddet içeren herhangi bir içeriği "
                     + "yüklemek, indirmek, postalamak, e-postayla göndermek, iletmek, saklamak için "
                     + "kullanmayacağınızı kabul edersiniz. Müstehcen, kaba, başkalarının mahremiyetine "
                     + "karşı saygısız, nefret dolu, ırkçı veya etnik olarak saldırgan, taciz edici, tehdit edici ya "
                     + "da başka birine zarar vermek gibi amaçlarla kullanmayacağınızı taahhüt etmiş "
                     + "olursunuz. Hiç bir yasa dışı faaliyeti planlamak ya da bunlarla meşgul olmak için Şehir "
                     + "Etkinlikleri’ni kullanmanıza izin verilmez. Kendinizi başka bir kişi, kurum, başka bir "
                     + "hizmet abonesi, bir Şehir Etkinlikleri çalışanı olarak tanımlayamaz veya yanlış temsil "
                     + "edemezsiniz. Şehir Etkinlikleri, herhangi bir akıllı telefon uygulamasını reddetme veya "
                     + "engelleme hakkını saklı tutar. Lütfen sadece telif hakkına sahip olduğunuz içeriği "
                     + "kullanın; çünkü Şehir Etkinlikleri, telif hakkı ihlali için herhangi bir sorumluluk kabul "
                     + "etmez. Raporlanabilir veriler ile ilgili olarak, yetkili makamlara uygulamanın yanlış "
                     + "kullanımı hakkındaki bilgileri ve içeriği verme hakkını saklı tutar."
            }

            SpaceTermsAndConditions{}

            // 8. Madde
            HeaderTermsAndConditions
            {
                text:"8. İçerikteki Değişiklikler"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, içeriği çeşitli medya ağlarında, çeşitli ortamlarda iletebilir ve içeriği "
                     +"teknik gereksinimlere uygun şekilde değiştirebilir. Buradaki lisans ile, Şehir "
                     +"Etkinlikleri’nin böyle bir eylemi gerçekleştirmesine izin verdiğinizi kabul edersiniz."
            }

            SpaceTermsAndConditions{}

            // 9. Madde
            HeaderTermsAndConditions
            {
                text:"9. İçeriğin Kaldırılması"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri'nin, başkaları tarafından sağlanan herhangi bir içerik için sorumlu "
                    + "olmadığını ve bu içeriği önceden taramakla yükümlü olmadığını kabul etmektesiniz. "
                    + "Bununla birlikte, Şehir Etkinlikleri; içeriğin uygun olup olmadığını ve bu Kullanım "
                    + "Koşulları'na uygun olup olmadığını belirleme hakkını saklı tutar. Eğer böyle bir içeriğin "
                    + "bu Kullanım Koşulları’nı ihlal ettiği tespit edilirse veya başka bir şekilde sakıncalıysa; "
                    + "Şehir Etkinlikleri önceden haber vermeksizin içeriği görüntüleyebilir, yayınlamayı reddedebilir veya "
                    + "yayınlanan içeriği kaldırabilir."
            }

            SpaceTermsAndConditions{}

            // 10. Madde
            HeaderTermsAndConditions
            {
                text:"10. Verileriniz"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Size sadece iyi bir hizmet sunmak için ihtiyaç duyduğumuz verileri toplar, yönetir ve "
                    + "saklarız. Bu verilerin üçüncü taraflarla paylaşımına herhangi bir şekilde ve/veya "
                    + "koşulda izin verilmez."
            }

            SpaceTermsAndConditions{}

            // 11. Madde
            HeaderTermsAndConditions
            {
                text:"11.Hesap Yükümlülükleri"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Kayıt işlemi ve hizmet kullanımı sırasında Şehir Etkinlikleri'ne sağladığınız tüm hesap bilgilerinizin doğru, tam, eksiksiz ve güncel bilgiler olacağını ve hizmet kullanımınız boyunca ihtiyaç duyduğunuz şekilde hesap bilgilerinizi koruyacağınızı ve güncelleyeceğinizi kabul etmektesiniz. Doğru, güncel ve eksiksiz bir hesap bilgisinin sağlanamaması, hesabınızın askıya alınması ve/veya feshedilmesine neden olabilir. Şehir Etkinlikleri, hesap bilgilerinizi ve içeriğinizi yasal olarak gerekli olması durumunda erişebilir, kullanabilir, saklayabilir ve/veya ifşa edebilir."
            }

            SpaceTermsAndConditions{}

            // 12. Madde
            HeaderTermsAndConditions
            {
                text:"12. Lokasyon Bazlı Hizmetlerin Kullanımı"

            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, ortakları ve lisans verenleri, hizmet aracılığıyla cihaz tabanlı konum "
                    + "bilgilerine dayanan belirli özellikler veya hizmetler sağlayabilir. Şehir Etkinlikleri, iş "
                    + "ortakları ve lisans verenleri, varsa, bu tür özellikleri veya hizmetleri sağlamak için, cihazınızın gerçek zamanlı coğrafi konumu dahil olmak üzere konum verilerinizi "
                    + "toplayabilir, kullanabilir, iletebilir ve işleyebilir. Buna ek olarak, servis içindeki "
                    + "herhangi bir yere dayalı hizmet veya özelliği etkinleştirerek ve/veya kullanarak "
                    + "(örneğin, uygulamanın konumunuzu kullanmasına izin vererek), Şehir Etkinlikleri’nin "
                    + "hesabınızla ilgili bilgileri toplamasını, kullanmasını, işlemesini ve bakımını yapmasını "
                    + "kabul edersiniz. Bu bilgiler, isteğiniz sırasında cihazınızın uygulama kimliği, cihaz "
                    + "kimliği ve adı, cihaz türü ve cihazınızın gerçek zamanlı coğrafi konumunu içerebilir, ancak bunlarla sınırlı değildir. Bu onayı, konuma dayalı özellikleri kullanmayarak veya "
                    + "cihazınızdaki Konum Servisleri ayarlarını (uygunsa) kapatarak, istediğiniz zaman geri "
                    + "çekebilirsiniz. Hizmetin bir parçası olarak konum verilerini kullanan veya sağlayan "
                    + "üçüncü taraf hizmetlerini kullanırken, söz konusu üçüncü taraf hizmetlerinin konum "
                    + "verilerinin kullanımıyla ilgili üçüncü tarafın şartlarını ve gizlilik politikasını izlemeye "
                    + "tabi tutulmalı ve gözden geçirmelisiniz. Servis tarafından sağlanan herhangi bir "
                    + "konum bilgisinin, kesin konum bilgilerinin gerekli olduğu veya hatalı, yanlış, zaman "
                    + "gecikmeli veya eksik konum verilerinin ölüme, kişisel yaralanmaya, mülke veya "
                    + "çevresel hasara yol açabileceği durumlarda güvenilir olması amaçlanmamıştır. Ne "
                    + "Şehir Etkinlikleri ne de içerik sağlayıcılarından herhangi biri, konum verilerinin "
                    + "kullanılabilirliği, doğruluğu, eksiksizliği, güvenilirliği veya güncelliğini, veya servis "
                    + "tarafından görüntülenen diğer verileri garanti etmez."
            }

            SpaceTermsAndConditions{}

            // 13. Madde
            HeaderTermsAndConditions
            {
                text:"13. Gizlilik Politikası"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Bu uygulamayı kullanarak, Şehir Etkinlikleri’nin Gizlilik Politikasına uygun olarak, hizmeti kullanımınızla ilgili bilgilerin toplanmasını ve kullanılmasını onaylar ve kabul "
                     +"edersiniz. Ayrıca, Şehir Etkinlikleri’nin, hesabınıza ilişkin bilgileri, hizmeti ve buradaki "
                     +"tüm özellikleri size sağlamak amacıyla, kullanabileceğini, iletebileceğini, "
                     +"işleyebildiğini ve sürdürdüğünü kabul edersiniz. Hizmeti kullanırken Şehir Etkinlikleri "
                     +"tarafından toplanan bilgiler, Şehir Etkinlikleri tarafından sunulan hizmeti korumak, "
                     +"iyileştirmek ve geliştirmek için kullanabileceğiniz, kullanımınızla ilgili teknik veya tanı "
                     +"bilgilerini de içerebilir. Ayrıca, Şehir Etkinlikleri Gizlilik Politikasına bağlı olmayı kabul "
                     +"edersiniz."

            }

            SpaceTermsAndConditions{}

            // 14. Madde
            HeaderTermsAndConditions
            {
                text:"14. Fatura ve Ödeme Bilgileri"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, herhangi bir ücret ödemeden indirebileceğiniz ve kullanabileceğiniz ücretsiz bir yazılımdır. Uygulamayı indirmek için internet erişimine ihtiyacınız vardır, sağlayıcınız size ne ücret talep edebilir ki?"
            }

            SpaceTermsAndConditions{}

            // 15. Madde
            HeaderTermsAndConditions
            {
                 text:"15. Şehir Etkinlikleri ticari markaları için telif hakkı";
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri, Şehir Etkinlikleri logosu, akıllı telefon uygulaması logosu ve diğer "
                    + "Şehir Etkinlikleri markaları, hizmet markaları, grafikler ve hizmet ile bağlantılı olarak "
                    + "kullanılan logolar, Şehir Etkinlikleri ticari markaları veya tescilli ticari markalarıdır. Hizmet ile bağlantılı olarak kullanılan diğer ticari markalar, hizmet markaları, grafikler "
                    + "ve logolar kendi sahiplerinin ticari markaları olabilir. Söz konusu ticari markaların "
                    + "hiçbirinde hak veya lisans verilmez. Ayrıca hizmete eklenmiş veya uygulama içinde "
                    + "yer alan herhangi bir mülkiyet hakkını (ticari marka ve telif hakkı bildirimleri dahil) "
                    + "kaldırmayacağınızı, gizlemeyeceğinizi veya değiştirmeyeceğinizi kabul edersiniz."
            }

            SpaceTermsAndConditions{}

            // 16. Madde
            HeaderTermsAndConditions
            {
                text:"16. Şehir Etkinlikleri mülkiyet hakları"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri ve/veya lisans verenlerinin; hizmet dahilinde ve/veya hizmetin "
                    + "(yazılımın) bir parçası olarak size sunulan herhangi bir yazılımı, ve kayıtlı olsun "
                    + "olmasın dünyanın neresinde olursa olsun, tüm fikri mülkiyet haklarına ve hizmete "
                    + "ilişkin tüm yasal haklara, unvanlara ve menfaatlere sahip olduğunu kabul ve beyan "
                    + "etmektesiniz. Ayrıca, hizmetin (yazılım veya diğer bölümleri dahil), geçerli fikri "
                    + "mülkiyet hakları ve diğer yasalar tarafından korunan tescilli ve gizli bilgiler içerdiğini "
                    + "kabul edersiniz."
            }

            SpaceTermsAndConditions{}

            // 17. Madde
            HeaderTermsAndConditions
            {
                 text:"17. Şehir Etkinlikleri Lisans"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Şehir Etkinlikleri size, uygulamanın bir parçası olarak Şehir Etkinlikleri tarafından "
                     +"sağlanan ve bu Kullanım Koşulları'na uygun olarak uygulamanın kullanımı için "
                     +"münhasır olmayan, devredilemez, sınırlı bir lisans vermektedir. Kaynak kodu "
                     +"kopyalamayacağınızı, değiştirmeyeceğinizi, türetilmiş bir iş yaratmayacağınızı, tersine "
                     +"mühendislik yapmayacağınızı, kaynak koda dönüştürmeyeceğinizi veya kaynak "
                     +"kodunu satmayacağınızı, kiralamayacağınızı, kabul ve beyan edersiniz."
            }

            SpaceTermsAndConditions{}

            // 18. Madde
            HeaderTermsAndConditions
            {
                 text:"18. İhracat Kontrolü"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Hizmet, veri, yazılım veya diğer içeriğin uygulama yoluyla aktarılması, gönderilmesi veya yüklenmesi dahil hizmetin kullanımı, ihracat ve ithalat yasalarına tabi olabilir. Geçerli tüm ihracat ve ithalat yasalarına ve düzenlemelerine uymayı kabul edersiniz."
            }

            SpaceTermsAndConditions{}

            SpaceTermsAndConditions{}

            // 19. Madde
            HeaderTermsAndConditions
            {
                 text:"19. Bağlantılar ve Diğer Üçüncü Taraf Materyalleri"
            }
            SpaceTermsAndConditions{}

            ContentTermsAndConditions
            {
                text: "Hizmetin belirli içeriği, bileşenleri veya özellikleri, üçüncü şahıslara ait materyalleri "
                    + "ve/veya diğer web sitelerine, kaynaklara veya içeriğe ait linkler içerebilir. Şehir "
                    + "Etkinlikleri’nin bu tür üçüncü taraf siteleri ve/veya materyalleri üzerinde herhangi bir "
                    + "kontrolü olmadığı için, bu tür sitelerin veya kaynakların kullanılabilirliğinden sorumlu "
                    + "olmadığını ve bu tür sitelerin veya kaynakların doğruluğunu onaylamadığını veya "
                    + "garanti etmediğini onaylar ve kabul edersiniz. Bu tür siteler veya kaynaklarda "
                    + "bulunan veya bunlardan elde edilen herhangi bir İçerik, reklam, ürün veya "
                    + "materyalden hiçbir şekilde sorumlu olmayacaktır. Ayrıca, Şehir Etkinlikleri’nin, kullanımınızın sonucu olarak ve / veya herhangi bir İçerik, reklam, ürüne bağlı olarak "
                    + "doğrudan veya dolaylı olarak maruz kaldığınız veya maruz kaldığınız iddia edilen "
                    + "zararlardan hiçbir şekilde sorumlu veya yükümlü olmayacağını kabul ve taahhüt "
                    + "etmektesiniz."
            }

            SpaceTermsAndConditions{}

            // 19. Madde
            HeaderTermsAndConditions
            {
                text:"20. Etkinliklerinizin Paylaşılması Hakkında"
            }


            SpaceTermsAndConditions{}

            Rectangle
            {
                id:  iletisimMetni
                width: parent.width
                height: iletisimMetniIcerik.contentHeight;
                Text {
                    id: iletisimMetniIcerik;
                    anchors.fill: parent;
                    width: parent.width;
                    horizontalAlignment: Text.AlignLeft;
                    wrapMode: Text.WordWrap;
                    text:"Organize ettiğiniz etkinliklerin paylaşılması konusunda bilgi almak için lütfen bizimle mail yoluyla iletişime geçin :"
                }
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


        maximumFlickVelocity: appWindow.height *4;

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


