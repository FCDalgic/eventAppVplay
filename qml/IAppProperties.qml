import VPlayApps 1.0
import QtQuick 2.4

import "items"
import "navigation"
import "pages"

App {
    visible: true;
    id: mobileWindow;

    licenseKey: "074F875E0E88F025BEFED9EC0A42FB5107D3A9645B07F0E8ACE65246F783C007329B967763E107F526E98922EB77590706B806C6031A06CCA72ACF209DFE70952E0B98DA0395F02351A8677698AA0413215C9DD92463A7DAB6AE9EB5C3862C55B640D6DB7CA5790E4D8408F6484CB3F0E1D8D40FA493D6F8592FAF64F59A591A976AC685E95D3ABE937D4F6F907D8404B4A795EE892944C6862115931D71016D6A6EE2B875169E3D23E2DEB508BE6C36D62AA310F1248F6158C891E6D07267873D57DF7FA1430BD1E812ADEC4DDBFE2A5E98ECD98596F5602A201822E413435D39670EAF3E006FE3105828302895C37ED18642E7C42B2E53EBDB82C12642C08E1FF491BA43DEE9988B9FED9915C5710B884BB96D98F9E419B24923875B033305CD0DC8E69800141A3D3CE541D83E997D";
    property real scrollTopInterval: 500;
    property string colorMain : "#661349" // "#de2875" //"#e84c3d";
    property string colorDrawer : "white" //"#e84c3d";   //32292F
    property string colorDrawerIcon : "#29698c";

    onInitTheme:
    {
        Theme.colors.backgroundColor = colorMain;
        // Theme.navigationAppDrawer.backgroundColor =colorMain;
        // Theme.navigationAppDrawer.itemBackgroundColor = colorMain;
         Theme.navigationBar.itemColor = "white"
         Theme.navigationBar.backgroundColor =colorMain;

        Theme.navigationBar.dividerColor = colorMain;
        Theme.navigationBar.titleColor = "white";
        Theme.tabBar.backgroundColor = "white";
        Theme.colors.tintColor = colorMain;
        Theme.tabBar.markerColor = colorMain;
        Theme.listSection.backgroundColor = colorMain;
        Theme.listSection.textColor = "white";

        Theme.platform = "ios";

        Theme.update();

    }

    property string iconFolder: "fa"
    property string selectedEventTitle: "";
    property string selectedCategoryTitle: "";
    property string lastSelectedCategoryTitle: "";

    property string currentAppTitle: "";
    function setAppTitle(pValue)
    {
        currentAppTitle =  pValue;
    }
    function getAppTitle()
    {
        return currentAppTitle;
    }

    property real lastSwipeViewIndex: 0;
    property var selectedEventModelData;
    property var selectedPlaceModelData;
    property real globalSwipeIndex : 0;
    signal closeSearchPanelReceived();
    signal footerBack();
    signal headerBack();
    signal stackBack();
    // Uygulamanın herhangi bir yerinde geri tuşuna basıldığı algılandığında bu event tetiklenecektir.
    signal globalBackPressed();
    // Tabbarda ikona basıldığı zaman değişen indeksin swipview tarafından algılanmasını sağlayacak olan sinyal
    signal swipeViewFooterTabbarIndexChanged(var pIndex);
    // SwipeView'da ekranlar arası geçiş sağlandığı zaman bu indeksin Tabbar tarafından algılanmasını sağlayacak olan sinyaldir.
    signal swipeViewIndexChanged(var pIndex);
    // Açıklaması yukarıda vardır.
    signal setSwiperViewBack();
    // Yandan açılan menüde ilgili sayfaya tıklandığında, eğer sayfa swipeview içerisindeki bir element ise
    // aşağıdaki event aracılığı ile komut swipeview'a iletilir. Aradaki köprüyü sağlar.
    signal setSwipeIndexManually(var pIndex);
    signal decreaseSwipeIndex();
    // Herhangi bir sayfada geriye basıldığında, eğer sayfa yukarı kaydırılmaya müsait ise veya footerda zaten seçili olan
    // ikon seçilmiş ise o sayfada yukarı çıkmak için gerekli olan fonksiyonun çağırılmasını sağlar.
    signal scrollTop();

    // Kullanıcının Login olup olmadığı bilgisini tutar.
    property bool isUserLogged: false;
    // Kullanıcının Anasayfaya Dönmesi İçin
    signal goHomepage();
    // Kullanıcı login olduğunda direkt olarak sinyalin algılanması için

}
