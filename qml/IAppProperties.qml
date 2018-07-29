import VPlayApps 1.0
import QtQuick 2.4

import "items"
import "navigation"
import "pages"

App {
    visible: true;
    id: mobileWindow;


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
    property bool loggedIn: false;
    // Kullanıcının Anasayfaya Dönmesi İçin
    signal goHomepage();
    // Kullanıcı login olduğunda direkt olarak sinyalin algılanması için

}
