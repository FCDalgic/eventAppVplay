import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.2

import "../../items"
import "../../items/delegates"


Popup
{

    id: searchPopup;

    width: parent.width

    function doSearch()
    {
        searchResults.cleanData();
        open();
    }

    Column
    {
        id:  searchContainer;
        anchors.fill: parent;
        spacing: 5;

        Rectangle
        {
            id: searchTitle;
            height: searchTitleContent.implicitHeight;
            width: parent.width;
            anchors.leftMargin: 10;


            Text {
                id: searchTitleContent;
                anchors.fill: parent;
                text: qsTr("Arama Sonuçları");
                color : appWindow.colorMain;
            }

            Text {
                id: closeSearch;
                anchors.fill: parent;
                text: qsTr("Kapat  X");
                color : appWindow.colorMain;
                anchors.right: parent.right;
                horizontalAlignment: Text.AlignRight;
            }

            MouseArea
            {
                anchors.fill: closeSearch;
                onClicked: searchPopup.close();
            }

            color: "transparent";
        }


        // Search area container;
        Rectangle
        {
            width: parent.width;
            height: appWindow.height * 0.48;

            color: "transparent";
            ListView {
                id: homePageSearchEventsListview;
                clip: true;
                focus: true;
                width: parent.width;
                height: parent.height - 50;
                orientation: ListView.Vertical;
                delegate: EventPageListViewDelegate{

                }
                model: searchResults.eventList

                ScrollIndicator.vertical: ScrollIndicator { }


            }

        }

        Rectangle {
            id: listFooter;
            width: searchPopup.width
            height: appWindow.height / 20;
            color: "transparent";
            visible: true;
            Rectangle
            {
                id: footerContent;
                width: parent.width  * 0.4;
                height: footerIcerik.contentHeight;
                anchors.centerIn: parent;
                color: "transparent";
                radius: height/2;

                Text {
                    id: footerIcerik
                    text: searchResults.eventList.length > 0 ?  (searchResults.eventList.length + " Etkinlik") : "Sonuç bulunamadı !";
                    height: parent.height;
                    //                    width: parent.width;
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignVCenter;
                    color: "gray";
                    anchors.centerIn: parent;
                }
            }

        }





    }
}
