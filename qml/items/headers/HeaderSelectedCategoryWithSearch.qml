import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0
import "../../items"


Rectangle
{
    Layout.fillWidth: true
    property string themeColor: appWindow.colorMain
    property string title: "";
    function setTitle(pTitle)
    {
        title = pTitle;
    }
    width: appWindow.width;
    height: appWindow.height * 0.1

    color: appWindow.colorMain;
    property bool show: true;
    function showFooter() {return show; }
    Row
    {
        anchors.fill: parent;
        width: parent.width;
        height: parent.height;
        spacing: 2;

        Item
        {
            width: 18;
            height: parent.height;
        }

        ColorableIcon
        {
            id: backbutton;
            width:  height;
            height: parent.height;
            color: "transparent";
            overlayColor: "white";
            hRatio: 0.35; wRatio: 0.35;
            iconPath:  "../../assets/images/fa/more_vert.png";

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    appWindow.decreaseSwipeIndex();
                }
            }
        }

        Item
        {
            height: parent.height;
            width:  (parent.width * 0.2) - backbutton.width - 18;
        }

        Rectangle
        {
            id: textAreaContaier;
            width:  parent.width * 0.6;
            height: parent.height;

            radius: height/2;
            color: "transparent";

            anchors.margins: 2;
            // Text area

            TextField{
                id: searchField;
                width: parent.width;
                height: parent.height/2;
                anchors.centerIn: parent;
                placeholderText: qsTr("Bugün ne yapsam?");
                focus: true;


                selectByMouse: true
//                Keys.onPressed:
//                {
//                    if (key == Qt.Key_Back || key == Qt.Key_Close || key == Qt.Key_unknown
//                            || key == Qt.Key_Return || key == Qt.Key_Down)
//                    {
//                        console.log("Detected key");
//                        searchField.focus = false;
//                        Qt.inputMethod.hide();
//                    }
//                }

//                onEditingFinished:
//                {
//                    console.log("editing finished");
//                    searchField.focus = false;
//                    eventManager.search(searchField.text);
//                    searchPopup.open();
//                    Qt.inputMethod.hide();
//                }

//                Keys.onBackPressed:
//                {
//                    searchField.focus = false;
//                    Qt.inputMethod.hide();
//                }
//                Keys.onMenuPressed:
//                {
//                    searchField.focus = false;
//                    Qt.inputMethod.hide();
//                }
//                Keys.onCancelPressed:
//                {
//                    searchField.focus = false;
//                    searchField.text = "";
//                    Qt.inputMethod.hide();
//                }

//                Keys.onBacktabPressed:
//                {
//                    searchField.focus = false;
//                    Qt.inputMethod.hide();
//                }

//                Keys.onEnterPressed:
//                {
//                    // item_list.focus = true;
//                    searchField.focus = false;
//                    eventManager.search(searchField.text);
//                    searchPopup.open();
//                    Qt.inputMethod.hide();
//                    // TODO : eventManager.searchEvents();
//                }

//                Keys.onReturnPressed:
//                {
//                // item_list.focus = true;
//                    Qt.inputMethod.hide();
//                    searchField.focus = false;
//                }
            }
        }

        Item
        {
            height: parent.height;
            width:  (parent.width * 0.2) - backbutton.width - 18;
        }


        ColorableIcon
        {
            width:  height;
            height: parent.height;
            color: "transparent";
            overlayColor: "white";
            hRatio: 0.35; wRatio: 0.35;
            iconPath:  "../../assets/images/fa/more_vert.png";

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    appWindow.openNavDrawer();
                }
            }
        }

        Item
        {
            height: parent.height;
            width:  18;
        }

    }
}
