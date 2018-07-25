// 
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQml 2.0;
import QtQml.Models 2.2
import QtGraphicalEffects 1.0

import "../../items/delegates"
import "../../items"

Flickable {
    id: flickablePageRecents;
//    width: appWindow.width;
//    height : appWindow.height;
//    anchors.fill: parent
    clip: true
    // StackView manages this, so please no anchors here
    // anchors.fill: parent


    property string modelType: "art";
    property string sectionFilter: "EventDate";

    property Component footerComponent: null;
    Component {
        id: sectionHeading
        Rectangle {
            width: flickablePageRecents.width
            height: sectionContent.height;
            color: "transparent";


            Rectangle {
                id: space1;
                width: parent.width * 0.1;
                height: parent.height;
//                color: "transparent";
            }

            ColorableIcon
            {
                id: border1;
                anchors.left: space1.right;
                width: parent.width *0.25;
                height: parent.height;
                wRatio: 0.9;
                hRatio: 0.6;
                iconPath:"../../assets/images/fa/border5-960x480.png";
            }


            Rectangle
            {
                id: sectionContent;
                anchors.left:  border1.right;
                width: parent.width  * 0.3;
                height: sectionIcerik.contentHeight;

                Text {
                    id: sectionIcerik
                    text: section
                    font.bold: true
                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    color: appWindow.colorMain;
                    anchors.centerIn: parent;
                }
            }


            ColorableIcon
            {
                id: border2;
                anchors.left: sectionContent.right;
                width: parent.width *0.25;
                height: parent.height;
                wRatio: 0.9;
                hRatio: 0.6;
                iconPath:"../../assets/images/fa/border5-right-960x480.png";
            }

            Rectangle {
                anchors.left: border2.right;
                width: parent.width *0.1;
                height: parent.height;
            }

        }

    }

    Component
    {
        id: listFooter;
        Rectangle {
            width: flickablePageRecents.width
            height: appWindow.height / 20;
            color: "transparent";
            visible: false;
            Rectangle
            {
                id: footerContent;
                anchors.left:  border1.right;
                width: parent.width  * 0.4;
                height: footerIcerik.contentHeight;
                anchors.horizontalCenter: parent.horizontalCenter;
                color: "transparent";
                radius: height/2;

                Text {
                    id: footerIcerik
                    text: "Bu sayfada şu an "+ ProfileManager.Favorites.length + " etkinlik görüntülenmektedir.";
                    height: parent.height;
//                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignVCenter;
                    color: "gray";
                    font.bold: true;
                    anchors.centerIn: parent;
                }
            }

            Timer
            {
                repeat: false;
                interval: 1000;
                onTriggered: parent.visible = true;
                running: true;
            }
        }
    }

    // Header - Liste yüklenene kadar busy indicator
    property variant statesNames: ["search", "retry", "abort", "loaded"];
    Timer
    {
        id: loaderTimer;
        interval: 1000;
        running: false;
        repeat: true;

        property real count: 0;
        onTriggered:
        {

            if (listviewSelectedCategory.count > 0)
            {
                console.log("Page Recents State == loaded");
                flickablePageRecents.state = "loaded";
                flickablePageRecents.isBusyVisible = false;
                count = 0;
                loaderTimer.stop();
                return;
            }

            count++;

            if (count == 1)
            {
                console.log("State == search");
                eventManager.getFavourites(ProfileManager.getStoredMail() , ProfileManager.getStoredPass());
                flickablePageRecents.state = "search";
            }
            else if (count > 2 && count <= 5)
            {
                console.log("State == retry");
                flickablePageRecents.state ="retry"
                // şu an tekrar deneme aşamasınd olduğumuz için her iki saniyede bir güncellemeye çalışalım.
                if (count%2 == 0)
                     eventManager.getFavourites(ProfileManager.getStoredMail() , ProfileManager.getStoredPass());
            }
            else if (count > 5)
            {
                console.log("State == abort");
                flickablePageRecents.state = "abort";
                loaderTimer.stop();
            }

            console.log("Timer count = " + count);
        }
    }

    property bool   busyRunning: false;
    property string busyText: "";
    property bool isBusyVisible: false;

    states: [
        State {
            name: "search"
            PropertyChanges {
                target: flickablePageRecents;
                busyText: "Lütfen bekleyin bağlantı kuruluyor";
                isBusyVisible: true;
                busyRunning: true;
            }
        },
        State {
            name: "retry"
            PropertyChanges {
                target: flickablePageRecents;
                busyText: "Bağlantı tekrar kurulmaya çalışılıyor.";
                isBusyVisible: true;
                busyRunning: true;
            }
        },
        State {
            name: "abort"
            PropertyChanges {
                target: flickablePageRecents;
                busyText: "Bağlantı kurulamadı.\nTekrar denemek için lütfen tıklayın.";
                isBusyVisible: true;
                busyRunning: false;
            }
        },
        State {
            name: "loaded"
            PropertyChanges {
                target: flickablePageRecents;
                busyText: "";
                isBusyVisible: false;
                busyRunning: false;

            }
        }
    ]

    Component.onCompleted:
    {
        footerComponent = listFooter;
        if (listviewSelectedCategory.count ==  0)
        {
            loaderTimer.start();
        }
    }


    ListView {
        id: listviewSelectedCategory;
        focus: true
        clip: true
        anchors.fill: parent
        orientation: ListView.Vertical

        property real previousContentY: 0;
        spacing: 18;  // Google Materia refence.

        currentIndex: 0

        delegate: DelegateEventListViewVertical{
            id: evetListDelegate;
        }
        model: categoryResults.eventList

        section.property: flickablePageRecents.sectionFilter;
        section.criteria: ViewSection.FullString

        section.delegate: sectionHeading

        ScrollIndicator.vertical: ScrollIndicator { }

        footer:  listFooter;

        header:  Rectangle
        {
            id : bussyContaier;
            width:  appWindow.width;
            height: visible ?  appWindow.height * 0.15 : 0;
            visible: flickablePageRecents.isBusyVisible;
            color: "transparent";
            Rectangle
            {
                width: parent.width / 1.1;
                height: parent.height;
                anchors.centerIn: parent;
                color: "transparent";

                BusyIndicator
                {
                    id : bussy
                    running: flickablePageRecents.busyRunning;
                    width:  height;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    visible:flickablePageRecents.isBusyVisible;
                    height: parent.height * 0.4;
                    anchors.top: parent.top;
                }

                Text {
                    id: busyText
                    text: flickablePageRecents.busyText;
                    width: parent.width;
                    height: parent.height / 3;
                    anchors.top: bussy.bottom;
                    horizontalAlignment: Text.AlignHCenter;
                    wrapMode: Text.WordWrap;
                    color: "gray";
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (flickablePageRecents.state != "abort")
                            return;


                        loaderTimer.stop();
                        loaderTimer.count = 0; // Resetlemek için;
                        loaderTimer.restart();
                    }
                }
            }
        }

        cacheBuffer: appWindow.height * 5;

        highlightMoveVelocity : appWindow.height  * 10;
        maximumFlickVelocity: appWindow.height  * 10;



    } // end listView



    function setDelegate(pDelegateName)
    {
        if (pDelegateName == "art")
        {
            listviewSelectedCategory.model = categoryResults.eventList;
        }
    }


    function goTop()
    {
        animationToTop.start();
    }
    function canGoTop()
    {
        return listviewSelectedCategory.contentY > 20 ? true : false;
    }

    NumberAnimation
    {
        id: animationToTop;
        target: listviewSelectedCategory;
        properties: "contentY";
        from: listviewSelectedCategory.contentY;
        to: 0;
        running: false;
        duration: appWindow.scrollTopInterval;
    }

    function whoAmI() {
        return qsTr("Message from Page One")
    }
    // called immediately after push()
    function init() {
        console.log(qsTr("Init done from One"))
    }
    // called immediately after pop()
    function cleanup() {
        console.log(qsTr("Cleanup done from One"))
    }
} // flickable
