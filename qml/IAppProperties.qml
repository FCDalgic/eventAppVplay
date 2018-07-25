import VPlayApps 1.0
import QtQuick 2.4

import "items"
import "navigation"
import "pages"
import "items/popups"
import "items/headers"
import "items/footers"
import "items/main"
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
        Theme.navigationAppDrawer.backgroundColor =colorMain;
        Theme.navigationAppDrawer.itemBackgroundColor = colorMain;
        Theme.update();
    }

    property string iconFolder: "fa"
    property string selectedEventTitle: "";
    property string selectedCategoryTitle: "";
    property string lastSelectedCategoryTitle: "";
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



    /// Note :it is not supported in VPlay thereore theme properties are used instead
    /// background: Rectangle
    /// {
    ///     width: mobileWindow.width;
    ///     height: mobileWindow.height;
    ///
    ///     color: "transparent";
    ///
    ///     Image {
    ///         source: "../../assets/images/v3/arkaplan.jpg" // "qrc:/images/v3/arkaplan.jpg"
    ///         width: parent.width;
    ///         height: parent.height;
    ///         fillMode: Image.PreserveAspectCrop
    ///     }
    /// }


    function openPopupSignUp() { popupSignup.open(); }
    function openPopupFavError(pCase) { popupFavourites.open()}
    function openPopupUserNotRegistered(pStatus) {popupResetPassMail.showCase(pStatus); }
    function openPopupUpdatePassword(pStatus) {popupUpdatePassword.showCase(pStatus); }
    function openPopupInternetConnection() { popupInternetConnection.open()}
    function openPopupLoginSucess() { popupLoginSuccess.open() }
    function checkInternetConnection()
    {
        if (!SehirUtils.checkInternetConnection())
        {
            openPopupInternetConnection();
            return false;
        }
        return true;
    }

    // Checked
    PopupSignupSuccess
    {
        id: popupSignup;
        visible: false;
    }


    PopupAddFavourite
    {
        id: popupFavourites;
        visible: false;
    }

    PopupResetPasswordMail
    {
        id: popupResetPassMail;
        visible: false;
    }
    PopupUpdatePassword
    {
        id : popupUpdatePassword;
        visible: false;
    }
    PopupInternetConnection
    {
        id: popupInternetConnection;
        visible: false;
    }

    PopupLoginSuccess
    {
        id: popupLoginSuccess;
        visible: false;
    }
}
