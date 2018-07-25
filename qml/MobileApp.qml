import VPlayApps 1.0
import QtQuick 2.4

import "items"
import "navigation"
import "pages"
import "pages/others"
import "items/popups"
import "items/headers"
import "items/footers"
import "items/main"
import "pages/selections"
IAppProperties {

    function setSelectedEventName(pName)
    {
        selectedEventTitle = pName;
        if (selectedEventTitle.length > 21)
        {
            var parts = selectedEventTitle.split(" ");
            var count = parts.length;

            selectedEventTitle = parts[0];
            for (var i = 1 ; i < count; i++)
            {
                var str   = parts[i];
                var total = selectedEventTitle.length  + str.length;

                if (total <= 21)
                    selectedEventTitle +=  " " + parts[i];
                else
                {
                    selectedEventTitle += ".."
                    break;
                }
            }
        }

        console.debug("setSelectedEventName  : " + pName);
    }




    function setIndeks(pindeks)
    {
        footerSelector.item.setCurrentIndex(pindeks);
    }



    onGoHomepage:
    {
        navPane.pop(null);
        stackedHeader.backHome();
        stackedFooter.backHome();
    }

    function changeCurrentIndex(id){
        navPane.currentIndex = id;
    }

    function openNavDrawer(){
        navigationBar.open()
    }

    function setFooterByID(pID)
    {
        footerStacked.insertFooterByID(pID);
    }

    function setHeaderByID(pID , pTitle)
    {
        if (pID === 1)
        {
            stackedHeader.setHeader(1, pTitle);
        }
        else if (pID === 2)
        {
            stackedHeader.setHeader(2, pTitle);
        }
        else if (pID === 3)
        {
            stackedHeader.setHeader(3, pTitle);
        }
        else if (pID === 4)
        {
            stackedHeader.setHeader(4, pTitle);
        }
        // Giriş yap ekranı - authantication
        else if (pID === 5)
        {
            stackedHeader.setHeader(5 , "Giriş Yap");
        }
        else if (pID === 6)
        {
            stackedHeader.setHeader(6, pTitle);
        }
        else if (pID === 7)
        {
            stackedHeader.setHeader(7, pTitle);
        }
        else if (pID === 9)
        {
            stackedHeader.setHeader(9 , "Şehir Etkinlikleri Hakkında");
        }
        else if (pID === 10)
        {
            stackedHeader.setHeader(10 , "Kullanım Koşulları");
        }
        else if (pID === 11) // Yemek kategorisi
        {
            stackedHeader.setHeader(pID, pTitle);
        }
        else if (pID === 12) // Neler yaptık.
        {
            stackedHeader.setHeader(11 , "Neler Yaptık?");
        }

        else
            stackedHeader.setHeader(pID, pTitle);
    }



    Component { id: selectedEventPageComponent;  PageSelectedEvent { selectedEventModel: selectedEventModelData; } }
    Component { id: aboutPageComponent;  PageAbout {  } }
    function eventSelected(pEventData)
    {
        console.log("Event selected called in main.qml");
        closeSearchPanelReceived();
        selectedEventModelData =  pEventData;
        // eventManager.increaseHitCount(pEventData.modelData.ID);
        // setHeaderByID(3 , "");
        // setFooterByID(3);
        // navPane.pushPageByPageNumber(3);
        globalNavStack.popAllExceptFirstAndPush(selectedEventPageComponent, { });
        // globalNavStack.push(Qt.resolvedUrl(selectedEventPageComponent))

    }
    // Mekan listesi ekranında herhangi bir mekan seçildiğinde ekranın güncellenmesi için.
    function selectPlace(pPlaceData)
    {
        console.log("Place selected called in main.qml");
        closeSearchPanelReceived();
        selectedPlaceModelData =  pPlaceData;

        setHeaderByID(13 , "");
        setFooterByID(13);
        navPane.pushPageByPageNumber(13);
        setSelectedEventName(pPlaceData.modelData.Name);
    }

    function categorySelected(pCategoryName)
    {

        closeSearchPanelReceived();
        currentlySelectedCategoryName = pCategoryName;

        // StackView'a ait olanlar.
        if (pCategoryName === "concert")
        {
            categoryResults.clear();

            RequestManager.getEventsByType("concert", 10);
            selectedCategoryTitle = qsTr("Sanat Eğlence");
        }
        else if (pCategoryName === "admin")
        {
            RequestManager.getEventsByType("admin", 10);
            selectedCategoryTitle = qsTr("Admin");
        }
        else if (pCategoryName === "academic")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("academic", 10);
            selectedCategoryTitle = qsTr("Eğitim");
        }
        else if (pCategoryName === "kids")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("kids",10);
            selectedCategoryTitle = qsTr("Çocuk");
        }
        else if (pCategoryName === "food")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("food",10);
            selectedCategoryTitle = qsTr("Yemek");
            lastSelectedCategoryTitle = pCategoryName;

            setFooterByID(11);
            setHeaderByID(11 , selectedCategoryTitle);
            navPane.pushPageByPageNumber(11);
            return;
        }
        else if (pCategoryName === "outdoor")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("outdoor", 10);
            selectedCategoryTitle = qsTr("Açık Hava Etkinlikleri");
        }
        else if (pCategoryName === "other")
        {
            RequestManager.getEventsByType("other", 10);
            selectedCategoryTitle = qsTr("Diğer Etkinlikler");
        }
        else if (pCategoryName === "about")
        {
            selectedCategoryTitle = qsTr("Hakkımızda");
            setHeaderByID(4 , selectedCategoryTitle);
            setFooterByID(4);
            navPane.pushPageByPageNumber(4 , "Hakkımızda");
            return;
        }
        else if (pCategoryName === "about_se")
        {
            selectedCategoryTitle = "Şehir Etkinlikleri Hakkında";
            setHeaderByID(9,selectedEventTitle);
            setFooterByID(9);
            navPane.pushPageByPageNumber(9);
            return;
        }
        else if (pCategoryName === "about_contributions")
        {
            selectedCategoryTitle = "Neler Yaptık?";
            setHeaderByID(12,selectedEventTitle);
            setFooterByID(12);
            navPane.pushPageByPageNumber(12);
            return;
        }
        else if (pCategoryName === "terms")
        {
            selectedCategoryTitle = "Kullanım Koşulları";
            setHeaderByID(10,selectedEventTitle);
            setFooterByID(10);
            navPane.pushPageByPageNumber(10);
            return;
        }
        // SwipeView 'e ait olanlar.
        else if (pCategoryName === "recent")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("recent", 10);
            selectedCategoryTitle = qsTr("En Yeni Etkinlikler");
            return;
        }
        else if (pCategoryName === "popular")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("popular", 10);
            selectedCategoryTitle = qsTr("En Popüler Etkinlikler");
            return;
        }
        else if (pCategoryName === "missed")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("missed", 10);
            selectedCategoryTitle = qsTr("Kaçırdığınız Etkinlikler")
            // return;
        }
        else if (pCategoryName === "all")
        {
            categoryResults.clear();
            RequestManager.getEventsByType("all", 10);
            selectedCategoryTitle = qsTr("Tüm Etkinlikler")
        }
        else if (pCategoryName === "page_authantication")
        {
            categoryResults.clear();
            setHeaderByID(5 , "Giriş Yap");
            setFooterByID(5);
            navPane.pushPageByPageNumber(5 , "Giriş Yap");
            return;
        }
        else if (pCategoryName === "page_signin")
        {
            categoryResults.clear();
            setHeaderByID(6 , "Kayıt Ol");
            setFooterByID(6);
            navPane.pushPageByPageNumber(6 , "Kayıt Ol");
            return;
        }
        else if (pCategoryName === "page_forgot_my_password")
        {
            setHeaderByID(7 , "Şifremi Unuttum");
            setFooterByID(7);
            navPane.pushPageByPageNumber(7 , "Şifremi Unuttum");
            return;
        }
        else if (pCategoryName === "page_update_my_password")
        {
            setHeaderByID(8 , "Şifremi Güncelle");
            setFooterByID(8);
            navPane.pushPageByPageNumber(8 , "Şifremi Güncelle");
            return;
        }
        else
        {
            return;
        }

        lastSelectedCategoryTitle = pCategoryName;

        setFooterByID(2);
        setHeaderByID(2 , selectedCategoryTitle);
        navPane.pushPageByPageNumber(2);
        console.log("Category Seleted : " + pCategoryName);
        //            eventListComponent.setDelegate("art");

    }

    property string currentlySelectedCategoryName: "";
    function setDrawerIndex(pIndex)
    {
        navigationBar.index = pIndex;
    }


    function openPageByName(pName)
    {
        if(pName === "Authantication")
        {

        }
    }

    function canGoUp()
    {
        navPane.canGoUp();
    }



    function tryToExit()
    {
        console.log("Try to exit.");
        Qt.quit();

    }


    function whoAmI()
    {
        return "main";
    }



    // Geri tuşuna basıldığı taktirde ilgili header ve footer kısmı zaten otomatik olarak işlevini yerine getirmektedir.
    // Ancak sayfanın otomatik bir şekilde yukarı kaydırılabilmesi için aşağıdaki kontrollerden sonra setSwiperViewBack()
    // sinyalinin tetiklenmesi gerekmektedir.
    property bool amk: false;
    onGlobalBackPressed:
    {
        // Eğer sayfa yukarı çıkmaya uygunsa yukarı çıkılır
        if (navPane.canGoUp())
        {
            navPane.scrollTop();
            return;
        }

        // Eğer stakview derinliği (içindeki sayfa sayısı 1'den fazla ise sadece popOnePage işlemi gerçekleştirilecektir.
        if (navPane.depth > 1)
        {
            navPane.popOnePage();
            footerBack();
            headerBack();
        }

        // Aksi durumda, zaten anasayfadayız anlamını içermektedir ve yukarıda bahsedilen event tetiklenecektir.
        else
        {
            setSwiperViewBack();
        }
    }

    // Indeksin değişmesi durumunda tekrar edilecek sorguların kontrol edileceği slot aşağıdaki gibidir. Yukarıdaki
    // Sinyal tetiklendiği zaman aynı zamanda aşağıdaki komut dizini de yerine getirelecektir.
    onSwipeViewIndexChanged:
    {
        console.log("Swipeview index changed" + pIndex);
        if (pIndex === 1)
        {
            RequestManager.getEventsByType("all", 10);
        }
        else if (pIndex === 2)
        {
            if (loggedIn)
                eventManager.getFavourites(ProfileManager.getStoredMail() , ProfileManager.getStoredPass());
        }
        else if (pIndex === 3)
        {
            //RequestManager.getEventsByType("missed", 10);
            eventManager.getPlaces();
            // categorySelected("missed");
        }

        setDrawerIndex(pIndex);

    }

}
