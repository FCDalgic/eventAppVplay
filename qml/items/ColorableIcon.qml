import QtQuick 2.0
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Rectangle{

    property string  iconPath: "";
    property string  align: "center";

    // Default values
    property real hRatio: 0.5;
    property real wRatio: 0.5;
    property string overlayColor: appWindow.colorMain;

    onAlignChanged: {
        if (align == "top")
            iconColorable.anchors.top = top;
        else if (align == "bottom")
            iconColorable.anchors.top = bottom;
    }

    Image
    {
        id : iconColorable;
        width: parent.width * parent.wRatio;
        height: parent.height  * parent.hRatio;
        anchors.centerIn: parent;
        source: iconPath;
        sourceSize: Qt.size(width ,height);

    }

    ColorOverlay {
        anchors.fill: iconColorable;
        source: iconColorable;
        color:  parent.overlayColor;// make image like it lays under red glass
    }
}
