import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

import "../auth"
import VPlayApps 1.0

Item
{
    id: loaderProfile;
    width: appWindow.width;
    height : appWindow.height;
    property bool showLoginScreen: false;

//    background:Rectangle
//    {
//        color: "white";
//        opacity: 0.5;
//    }

    // Sayfa Yukarı Kaydırılabilir mi?
    function canGoTop()
    {
        console.log("Can go Top Called About");
        return profileLoader.item.canGoTop();
    }
    function goTop()
    {
        profileLoader.item.scrollTop();
    }

    Loader
    {
        id: profileLoader;
        anchors.fill: loaderProfile;
        sourceComponent: loaderProfile.showLoginScreen? favouritesComponent : authanticationComponent;
    }

    Component
    {
        id: authanticationComponent;
        PageRequestAuthantication
        {

        }
    }

    Component
    {
        id: favouritesComponent;
        PageProfile
        {

        }
    }


    Connections
    {
        target: appWindow;
        onIsUserLoggedChanged:
        {
            console.log("Login Status Changed received to page favourites laoder, the app logged in = " + appWindow.isUserLoggedChanged) ;
            profileLoader.sourceComponent = appWindow.isUserLoggedChanged ? favouritesComponent : authanticationComponent;
        }
    }

    onVisibleChanged:
    {
        if (visible)
            profileLoader.sourceComponent = appWindow.loggedIn ? favouritesComponent : authanticationComponent;
    }

    property bool buttonStatus: false;


    function whatWasMyTitle()
    {
        return lastHeader;
    }
    function init() {
        console.log(qsTr("Init done from One"))
    }
    // called immediately after pop()
    function cleanup() {
        console.log(qsTr("Cleanup done from One"))
    }

    function whoAmI()
    {
        return "Favourites Component";
    }
}
