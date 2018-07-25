import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0
import "../../items"

ToolBar{
    id: authanticationHeader;
    Layout.fillWidth: true
    property string themeColor: appWindow.colorMain
    property string title: "";
    height: appWindow.height * 0.1

    function setTitle(pTitle)
    {
        title = pTitle;
    }

    function setEnableMenu(pState)
    {

    }

    property bool show: false;
    function showFooter() {return show; }

    background: Rectangle{
        anchors.fill: parent
        color: themeColor
    }

    function whoAmI()
    {
        return "HeaderAuthantication.qml";
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
            text: authanticationHeader.title;
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

//    RowLayout{
//        id : topRow
//        focus : false
//        spacing : 4
//        anchors.fill: parent

//        Item {
//            height: parent.height;
//            width: 10;
//        }
//        ToolButton { background: Rectangle { color: "transparent";}
//            width: parent.width * 0.2;
//            height: parent.height *.65;
//            focusPolicy: Qt.NoFocus
//            contentItem: Image{
//                id: content1;
//                source: "../../assets/images/fa/back-arrow-64.png"
//                sourceSize: Qt.size(height, height);
//            }

//            ColorOverlay{
//                source: content1
//                anchors.fill: content1
//                color: "white"
//            }
//            onClicked: {
//                appWindow.globalBackPressed();

//            }
//        }
//        ToolButton { background: Rectangle { color: "transparent";}
//            width: parent.width * 0.55;
//            focusPolicy: Qt.NoFocus
//            height: parent.height

//            contentItem: Label {
//                text: authanticationHeader.title;
//                elide: Label.ElideRight
//                horizontalAlignment: Qt.AlignHCenter
//                verticalAlignment: Qt.AlignVCenter
//                color: "white";

//            }
//            Layout.fillWidth: true

//        }
//        ToolButton { background: Rectangle { color: "transparent";}
//            height: parent.height *.65;
//            width: parent.width * 0.1;
//            focusPolicy: Qt.NoFocus
//            contentItem: Image{
//                id: drawerbtn;
//                source: "../../assets/images/fa/more-vert-sub-x64.png"
//                sourceSize: Qt.size(height, height);
//                anchors.centerIn: parent;
//            }
//            onClicked: {
//                appWindow.openNavDrawer()
//            }
//        }
//        Item{
//            height: parent.height;
//            width: parent.width * 0.02;
//        }
//        Item{
//            height: parent.height;
//            Layout.fillWidth: true;
//        }
//    }
}
