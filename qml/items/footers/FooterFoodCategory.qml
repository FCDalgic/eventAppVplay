import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import "../../items"

ToolBar {
    id: myTitleBar
    property string themeColor: appWindow.colorMain
    height: appWindow.height * 0.1

    visible: false;
    property real iconSize: height * .65;
    property bool show: false;
    function showFooter() {return myTitleBar.show; }
    function whoAmI() {return "Footer Selected Category";}
//    background: Rectangle{
//        color: themeColor
//    }

    background: Rectangle
    {
        color: "transparent";
    }

    RowLayout{
        id : topRow
        focus : false
        spacing : 5
        anchors.fill: parent

        ToolButton {
            id:  drawerTool
            visible: false
            focusPolicy: Qt.NoFocus
            Layout.fillWidth: true;

            RowLayout
            {
                spacing: 10;
                anchors.fill: parent;

                Item
                {
                    Layout.fillWidth: true;
                    height: parent.height;
                }

                Label
                {
                    text : qsTr("Filtrele");
                    height: myTitleBar.height;
                    color: "white";
//                    anchors.verticalCenter: myTitleBar.verticalCenter;
                }

                Image
                {
                    source: "../../assets/images/fa/filter-x64.png";
                    sourceSize: Qt.size(iconSize, iconSize);
                }

                Item
                {
                    Layout.fillWidth: true;
                    height: parent.height;
                }
            }


            MouseArea
            {
                anchors.fill: parent;
                onClicked: appWindow.openPopupByName("etkinlik_filtrele");
            }


        }

        ToolButton{
            visible: false
            focusPolicy: Qt.NoFocus
            Layout.fillWidth: true;

            RowLayout
            {
                spacing: 10;
                anchors.fill: parent;

                Item
                {
                    Layout.fillWidth: true;
                    height: parent.height;
                }

                Label
                {
                    text : qsTr("Sırala");
                    color: "white";
                    height: myTitleBar.height;
//                    anchors.verticalCenter: myTitleBar.verticalCenter;
                }

                Image
                {
                    source: "../../assets/images/fa/sort-64.png";
                    sourceSize: Qt.size(iconSize, iconSize);
                }

                Item
                {
                    Layout.fillWidth: true;
                    height: parent.height;
                }
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked: appWindow.openPopupByName("etkinlik_sirala");
            }

        }
    } // end RowLayout

    // Tabbar begins



} // end ToolBar
