import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "../../items"

TabBar{
    id: mainFooter;
//    Layout.fillWidth: true
    property string themeColor: appWindow.colorMain
    currentIndex: 0

//    height: appWindow.height * 0.1

    property bool show: true;
    function showFooter() {return mainFooter.show; }
    function whoAmI() {return "Footer Main";}
    signal tabbarClicked();



    onCurrentIndexChanged: {
        console.log("Tabbar Current index changed from footer main");
        appWindow.swipeViewFooterTabbarIndexChanged(currentIndex);
    }

    Connections
    {
        target: appWindow;
        onSwipeViewIndexChanged:
        {
            console.log("Swipe view swiped index received from footerMain");
            if (pIndex == currentIndex)
                return;
            else
                currentIndex = pIndex;
        }

    }

    background: Rectangle{
        anchors.fill: parent
        color: "white";
    }



    spacing: 0;

    TabButton {
        height: parent.height
        focusPolicy: Qt.NoFocus
        anchors.verticalCenter: parent.verticalCenter;
        contentItem: TabButtonWithIconAndTextItem{
            anchors.bottom: parent.bottom;
            setVisible: true
            src : "../../assets/images/fa/home-x64.png"
            displayName: "Anasayfa"
            setActive: parent.checked
        }

        onClicked:
        {
            mainFooter.tabbarClicked();
            if (mainFooter.currentIndex == 0)
            {
                if (navPane.canGoUp())
                {
                    navPane.scrollTop();
                    return;
                }
            }
        }

    }
    TabButton {
        focusPolicy: Qt.NoFocus
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter;
        contentItem: TabButtonWithIconAndTextItem{
            anchors.bottom: parent.bottom;
            src : "../../assets/images/v3/Tümü.png"
            displayName: "Tümü"
            setVisible: true
            setActive: parent.checked

        }
        onClicked:
        {

            if (mainFooter.currentIndex == 1)
            {
                if (navPane.canGoUp())
                {
                    navPane.scrollTop();
                    return;
                }
            }
        }
    }
    TabButton {
        focusPolicy: Qt.NoFocus
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter;
        contentItem: TabButtonWithIconAndTextItem{
            anchors.bottom: parent.bottom;
            src : "../../assets/images/fa/love-x64.png"
            displayName: "Favoriler"
            setVisible: true
            setActive: parent.checked
        }
        onClicked:
        {

            if (mainFooter.currentIndex == 2)
            {
                if (navPane.canGoUp())
                {
                    navPane.scrollTop();
                    return;
                }
            }
        }
    }
    TabButton {
        height: parent.height
        focusPolicy: Qt.NoFocus
        anchors.verticalCenter: parent.verticalCenter;
        contentItem: TabButtonWithIconAndTextItem{
            anchors.bottom: parent.bottom;
            setVisible: true
            displayName: "Mekanlar"
            src: "../../assets/images/v3/building-x512.png"
            setActive: parent.checked
        }

        onClicked:
        {

            if (mainFooter.currentIndex == 3)
            {
                if (navPane.canGoUp())
                {
                    navPane.scrollTop();
                    return;
                }
            }
        }
    }

}
