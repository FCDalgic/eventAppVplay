import QtQuick 2.0
import QtQuick.Controls.Material 2.1

Rectangle{
    property string header: ""

    width : parent.width
    height:  name.height + space.height
    signal viewAllSelected(string value)
    Rectangle{
        id: space
        width: parent.width
        height: 20
        color: "#ece3e3"

    }
    Text {
        id: name
        text: header
        anchors{
            left : parent.left
            top  : space.bottom
        }
    }
    Text {
        id: viewall
        text: qsTr("Hepsi");
        anchors{
            right: parent.right
            top  : space.bottom
        }

        color: appWindow.colorMain

        MouseArea{
            anchors.fill: parent;
            onClicked:  viewAll();
        }
    }


    function viewAll(){
        console.log(name.text + "is selected to view all");
        listContiner.selectPage(name.text);
    }

}
