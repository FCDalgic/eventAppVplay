import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "../../items"

ToolBar{
    id: mainHeader;
    Layout.fillWidth: true
    property string themeColor: appWindow.colorMain
    height: appWindow.height * 0.1

    visible: false;
    background: Rectangle{
        anchors.fill: parent
        color: themeColor
    }
    function whoAmI()
    {
        return "HeaderMain.qml";
    }
    property bool show: false;
    function showFooter() {return show; }


    property string title: "";
    property bool showCategories: false;
    function setTitle(pTitle)
    {
        title = pTitle;
    }

    function setEnableMenu(pState)
    {
        //       if (showCategories === pState)
        //           return;

        //       showCategories = pState;
    }

    property real tabIndex: 1;
    Connections
    {
        target: appWindow;
        onSwipeViewIndexChanged:
        {
            console.log("Swipe view swiped index received from footerMain");

            if (pIndex == 0 || pIndex == 2)
                mainHeader.show = false;
            else
                mainHeader.show = true;

            switch(pIndex)
            {
            case 0:
                mTitle =  qsTr("Hoşgeldiniz");
                break;
            case 1:
                mTitle =  qsTr("Tüm Etkinlikler");
                break;
            case 2:
                mTitle =  qsTr("");
                break;
            case 3:
                mTitle =  qsTr("Kaçırdıklarınız");
                break;
            }
        }

    }

    property string mTitle: "Hoşgeldiniz";
    property real pHeight: height;
    property real length:  width * 0.25;
//    RowLayout{
//        id : topRow
//        focus : false
//        anchors.fill: parent
//        spacing: 10;

//        ToolButton {
//            height: parent.height;
//            focusPolicy: Qt.NoFocus
//            width: parent.width * 0.1;
//            background: Rectangle { color: "transparent";}
//        }
//        ToolButton {
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            contentItem: Image{
//                id: content1;
//                source: "../../assets/images/fa/more_vert.png"
//                sourceSize: Qt.size(height, height);
//                anchors.centerIn: parent;
//                opacity: 1;
//            }
//            background: Rectangle { color: "transparent";}
//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }
//        // Category Ikonları gözükmezken gösterilecektir.
//        ToolButton {
//            focusPolicy: Qt.NoFocus
//            height: parent.height
//            width: parent.width * 0.6;
//            visible: !showCategories;
//            background: Rectangle { color: "transparent";}
//            contentItem: Text{
//                text:  mainHeader.mTitle ; // qsTr("Şehir Etkinlikleri");
//                elide: Label.ElideRight
//                color: "white"
//                font.family: "Vivaldi"
//                opacity: 1;
//                horizontalAlignment: Qt.AlignHCenter
//                verticalAlignment: Qt.AlignVCenter
//                anchors.centerIn: parent;

//            }
//            //            Text{
//            //                text: qsTr("Sehir Etkinlikleri");
//            ////                font.family: "Blackadder ITC"
//            //                //                font.family: "Edwardian Script ITC"
//            //            }

//            Layout.fillWidth: true

//        }
//        // Bundan sonrakiler anasayfada kullanıcı sayfayı aşağı kaydırdıktan sonra gösterilecektir.
//        // Bunu da showCategories değişkeninin durumundaki değişime göre sağlayacaktır.
//        ToolButton {height: parent.height;visible: showCategories;focusPolicy: Qt.NoFocus; width: parent.width * 0.3; }
//        ToolButton
//        {
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            visible: showCategories;
//            background: Rectangle { color: "transparent";}
//            contentItem:  CategoryIconHomepage
//            {
//                width: mainHeader.length;
//                height: mainHeader.pHeight;
//                iconPath: "../../assets/images/v2/hepsi_icon.png";
//                categoryName: "Tüm Etkinlikler";
//                //                        overlayColor: "#297fb8";
//                onCategorySelected:
//                {
//                    appWindow.categorySelected("all");
//                    appWindow.setDrawerIndex(4);
//                }
//            }

//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }

//        ToolButton {height: parent.height;visible: showCategories;focusPolicy: Qt.NoFocus; width: parent.width * 0.1; }
//        ToolButton
//        {
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            visible: showCategories;
//            background: Rectangle { color: "transparent";}
//            contentItem: Image{
//                source: "../../assets/images/fa/concert.png"
//                sourceSize: Qt.size(height, height);
//                anchors.centerIn: parent;
//            }
//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }

//        ToolButton {height: parent.height;visible: showCategories;focusPolicy: Qt.NoFocus; width: parent.width * 0.1; }
//        ToolButton
//        {
//            id: tb2;
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            visible: showCategories;
//            background: Rectangle { color: "transparent";}
//            contentItem: Image{
//                height: tb2.height;
//                source: "../../assets/images/v2/bilim_icon.png";
//                sourceSize: Qt.size(height, height);
//                anchors.centerIn: parent;
//            }
//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }

//        ToolButton {height: parent.height;visible: showCategories;focusPolicy: Qt.NoFocus; width: parent.width * 0.1; }
//        ToolButton
//        {
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            visible: showCategories;
//            background: Rectangle { color: "transparent";}
//            contentItem: Image{
//                source: "../../assets/images/v2/child-x64.png"
//                sourceSize: Qt.size(height, height);
//                anchors.centerIn: parent;
//            }
//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }



//        ToolButton {
//            height: parent.height *.65;
//            focusPolicy: Qt.NoFocus
//            width: parent.width * 0.2;
//            background: Rectangle { color: "transparent";}
//        }
//        ToolButton
//        {
//            Layout.fillWidth: true;
//            height: parent.height;
//            background: Rectangle { color: "transparent";}
//        }
//    }
}
