import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0
import "../../items"

ToolBar{
    id: selectedCategoryHeader;
    Layout.fillWidth: true
    property string themeColor: appWindow.colorMain
    property string title: "";
    function setTitle(pTitle)
    {
        title = pTitle;
    }

    function setEnableMenu(pState)
    {

    }
    function whoAmI()
    {
        return "HeaderSelectedCategory.qml";
    }

    height: appWindow.height * 0.1
    property bool show: true;
    function showFooter() {return show; }
    background: Rectangle{
        anchors.fill: parent
        color: themeColor
    }


    Rectangle
    {
        width: parent.width;
        height: parent.height;
        color: "transparent";
        anchors.verticalCenter: parent.verticalCenter;

        Rectangle
        {
            id:  backbutton; width: parent.width * .1;
            color: "transparent";
            height: parent.height;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            ColorableIcon
            {
                color: "transparent";
                iconPath: "../../assets/images/fa/back-arrow-64.png";
                anchors.centerIn: parent;
                width:  Math.min(parent.width , parent.height);
                height: width;
                wRatio: .65; hRatio: .65;
                overlayColor: "white";

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: {
                        globalBackPressed(); // navPane.popOnePage();
                    }
                }
            }
        }

        Label {
            width: parent.width *.5;
            height: parent.height * .65;
            text: selectedCategoryHeader.title;
            elide: Label.ElideRight
            anchors.centerIn: parent;
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            color: "white";
        }

        Rectangle
        {
            id:  menuButton; width: parent.width * .1;
            color: "transparent";
            height: parent.height;
            anchors.right:  parent.right;
            anchors.rightMargin: 15;
            ColorableIcon
            {
                color: "transparent";
                iconPath: "../../assets/images/fa/more-vert-sub-x64.png";
                anchors.centerIn: parent;
                width:  Math.min(parent.width , parent.height);
                height: width;
                wRatio: .65; hRatio: .65;
                overlayColor: "white";

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: {
                        appWindow.openNavDrawer();
                    }
                }
            }
        }


    }

}
