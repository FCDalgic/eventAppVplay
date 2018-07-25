import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    property string src: ""
    property string displayName: ""
    property bool setVisible: false
    property bool setActive: false
    property double scaleFactor: 0.5
    property variant borderColor: "gray"

    anchors.fill: parent
    color: "white";
    Rectangle{
        id: line;
        width: parent.width
        height: 10;
        color: setActive ? appWindow.colorMain : borderColor
    }
    

    Image {
        id: bug
        source: src
        sourceSize: Qt.size(parent.width * scaleFactor, parent.height * scaleFactor)
        smooth: true
        visible: setVisible
//        anchors.top: line.bottom;
        anchors.topMargin: 10;
        anchors.centerIn: parent

    }

    ColorOverlay {
        anchors.fill: bug
        source: bug
        color: setActive ? appWindow.colorMain : "lightgray"  // make image like it lays under red glass
    }

    Text {
        id: name
        text: displayName;

        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: parent.width * 0.9;
        color: setActive ? appWindow.colorMain : "lightgray"
        height: parent.height * (1 - scaleFactor - 0.2) - 20;
        horizontalAlignment: Text.AlignHCenter;
        font.pixelSize:  height * 1.2;
    }
}
