import VPlayApps 1.0
import VPlayPlugins 1.0

import QtQuick 2.4

import "items"
import "navigation"
import "pages"
import "pages/others"
import "pages/selections"
IAppProperties {

    function setSelectedEventName(pName)
    {
        selectedEventTitle = pName;
        if (selectedEventTitle.length > 33)
        {
            var parts = selectedEventTitle.split(" ");
            var count = parts.length;

            selectedEventTitle = parts[0];
            for (var i = 1 ; i < count; i++)
            {
                var str   = parts[i];
                var total = selectedEventTitle.length  + str.length;

                if (total <= 33)
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
        globalNavStack.popAllExceptFirst();

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
    Component { id: selectedPlacePageComponent;  PageSelectedPlace {  model: selectedPlaceModelData } }
    Component { id: selectedCategoryPageComponent;  PageSelectedCategory { title: selectedCategoryTitle } }
    Component { id: aboutPageComponent;  PageAbout {  } }

    function eventSelected(pEventData)
    {
        closeSearchPanelReceived();
        selectedEventModelData =  pEventData;
        selectedEventTitle = pEventData.modelData.Name;
        globalNavStack.popAllExceptFirstAndPush(selectedEventPageComponent, {});
    }
    // Mekan listesi ekranında herhangi bir mekan seçildiğinde ekranın güncellenmesi için.
    function selectPlace(pPlaceData)
    {
        console.log("place selected");
        selectedPlaceModelData =  pPlaceData;
        globalNavStack.popAllExceptFirstAndPush(selectedPlacePageComponent, {});
    }

    function categorySelected(pCategoryName)
    {

        closeSearchPanelReceived();
        currentlySelectedCategoryName = pCategoryName;

        // StackView'a ait olanlar.
        if (pCategoryName === "concert")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("concert", 10);
            selectedCategoryTitle = qsTr("Art & Entertainment");
        }
        else if (pCategoryName === "academic")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("academic", 10);
            selectedCategoryTitle = qsTr("Academic");
        }
        else if (pCategoryName === "kids")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("kids",10);
            selectedCategoryTitle = qsTr("Kids");
        }
        else if (pCategoryName === "food")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("food",10);
            selectedCategoryTitle = qsTr("Foods & Workshops");
            //lastSelectedCategoryTitle = pCategoryName;

            // setFooterByID(11);
            // setHeaderByID(11 , selectedCategoryTitle);
            // navPane.pushPageByPageNumber(11);
            // return;
        }
        else if (pCategoryName === "about")
        {
            globalNavStack.popAllExceptFirstAndPush(aboutPageComponent, {});
            return;
        }
        else if (pCategoryName === "recent")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("recent", 10);
            selectedCategoryTitle = qsTr("En Yeni Etkinlikler");
            return;
        }
        else if (pCategoryName === "popular")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("popular", 10);
            selectedCategoryTitle = qsTr("En Popüler Etkinlikler");
            return;
        }
        else if (pCategoryName === "missed")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("missed", 10);
            selectedCategoryTitle = qsTr("Kaçırdığınız Etkinlikler")
            // return;
        }
        else if (pCategoryName === "all")
        {
            CategoryResults.clear();
            RequestManager.getEventsByType("all", 10);
            selectedCategoryTitle = qsTr("All Events")
        }
        else
        {
            return;
        }

        lastSelectedCategoryTitle = pCategoryName;
        globalNavStack.popAllExceptFirstAndPush(selectedCategoryPageComponent, {});
        console.log("Category Seleted : " + pCategoryName);
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
        if (pIndex === 0)
        {
            RequestManager.getEventsByType("homepage_recent");
        }
        else if (pIndex === 1)
        {
            RequestManager.getEventsByType("all", 10);
        }
        else if (pIndex === 2)
        {
            console.log("Trying to get places");
            RequestManager.getPlaces();
        }

    }


    function timerInstance() {
        return Qt.createQmlObject("import QtQuick 2.0; Timer {}", appWindow);
    }

    function delay(delayTime, cb) {
        var timer =  timerInstance();
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();

    }

    // #################################### Alerts and Dialogs ##########################################

    // #################################### Authatication Management ####################################
    // enum UserStatus
    // {
    //     GENERAL_NOT_LOGGED = 0,
    //     LOGIN_MAIL_CONFIRMATION_NEED = 1,
    //     LOGIN_NOT_REGISTERED = 2,
    //     LOGIN_LOGGED = 3,
    //     SIGNUP_ALREADY_EXIST = 4,
    //     RESET_PASSWORD_MAIL_SENT = 5,
    //     RESET_PASSWORD_NOT_REGISTERED = 6,
    //     RESET_PASSWORD_UPDATED = 7,
    //     RESET_PASSWORD_CODE_NOT_MATCHED = 8
    // };
    Connections
    {
        target: ProfileManager;
        onLoginStatusChanged:
        {
            var status = ProfileManager.getUserStatusID();
            if (status === 3 || status === 1 || status === 7)
            {
                isUserLogged = true;
                nativeUtils.displayMessageBox(qsTr("Succesfully logged in"), "", 2);
            }
            else
            {
                isUserLogged = fbComponent.loggedIn;
            }

            switch(status)
            {
            case 2:
                console.info("Trying to open display alert for user not exists");
                nativeUtils.displayAlertDialog(qsTr("Signin Failed"), qsTr("User not exists."), qsTr("OK"), qsTr(""))
                break
            case 4:
                nativeUtils.displayAlertDialog(qsTr("SignUp Failed"), qsTr("User already exists."), qsTr("OK"), qsTr("Cancel"))
                break;
            case 5:
                nativeUtils.displayAlertDialog(qsTr("Reset Password"), qsTr("Password is successfuly reset. Please login with your new password"), qsTr("OK"), qsTr("Cancel"))
                break;
            }
        }
    }

    function loginWithFB()
    {
        if (!fbComponent.loggedIn)
        {
            fbComponent.openSession()
        }
    }

    // ###################### Social Logins ###############################
    Facebook
    {
        id: fbComponent;
        readonly property bool loggedIn: sessionState === Facebook.SessionOpened
        appId: "313153156090949";
        readPermissions: [ "public_profile", "email", "user_friends" ]
        publishPermissions: ["publish_actions"]

        // fetch data after log in
        onSessionStateChanged: {
            if (sessionState === Facebook.SessionOpened) {
                fetchUserDetails() // get user details
                ProfileManager.signUp(fbComponent.profile.firstName + "-" + fbComponent.profile.firstName , "seFb" + fbComponent.profile.userId);
                facebook.getGraphRequest("me/friends", { fields: "id,name,picture" }) // get friends that use the app
            }
        }

        // handle completed get-friends graph request
        onGetGraphRequestFinished: {
            if(resultState !== Facebook.ResultOk)
                NativeDialog.confirm("Retrieving Friends Failed", "", function(){}, false)

            // show friends
            if(graphPath === "me/friends") {
                friendsList.model = JSON.parse(result).data
            }
        }

        // handle completed post-message graph request
        onPostGraphRequestFinished: {
            if(resultState !== Facebook.ResultOk)
                NativeDialog.confirm("Post Request Failed", "", function(){}, false)
            else
                NativeDialog.confirm("Message Posted Successfully", "", function(){}, false)
        }
    }
}
