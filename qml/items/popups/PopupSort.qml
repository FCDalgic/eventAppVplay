import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Popup {
    id: popupSirala;
     property string selectedBtnName: "";
//    modal: true
//    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property date currentDate: new Date()
    property string dateString


    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    width  : appWindow.width  * 0.6;
    height : appWindow.height * 0.4;

    background: Rectangle
    {
        color: "#191d27"
        anchors.fill: parent;
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 1;

        Row
        {
            height: popupSirala.height / 20;
            Layout.fillWidth: true;
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }

            Rectangle
            {
                width: parent.width * .5;
                height: parent.height;
                color:  popupSirala.selectedBtnName == "dateInc" ? "yellow" : appWindow.colorMain  ;
                Text{
                    text: qsTr("Tarihe Göre Artan");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (popupSirala.selectedBtnName == "dateInc")
                           popupSirala.selectedBtnName = "";
                        else
                            popupSirala.selectedBtnName = "dateInc";
                    }
                }
            }
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }
        }


        Row
        {
            height: popupSirala.height / 20;
            Layout.fillWidth: true;
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }

            Rectangle
            {
                width: parent.width * .5;
                height: parent.height;
                color:  popupSirala.selectedBtnName == "dateDec" ? "yellow" : appWindow.colorMain  ;
                Text{
                    text: qsTr("Tarihe Göre Azalan");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (popupSirala.selectedBtnName == "dateDec")
                           popupSirala.selectedBtnName = "";
                        else
                            popupSirala.selectedBtnName = "dateDec";
                    }
                }
            }
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }
        }

        Row
        {

            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }

            height: popupSirala.height / 20;
            Layout.fillWidth: true;
            Rectangle
            {
                width: parent.width * 0.5;
                height: parent.height;
                color:  popupSirala.selectedBtnName == "popInc" ? "yellow" : appWindow.colorMain  ;
                Text{
                    text: qsTr("Popülerliğe Göre Artan");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (popupSirala.selectedBtnName == "popInc")
                           popupSirala.selectedBtnName = "";
                        else
                            popupSirala.selectedBtnName = "popInc";
                    }
                }
            }
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }
        }


        Row
        {
            height: popupSirala.height / 20;
            Layout.fillWidth: true;
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }

            Rectangle
            {
                width: parent.width *.5;
                height: parent.height;
                color:  popupSirala.selectedBtnName == "popDec" ? "yellow" : appWindow.colorMain  ;
                Text{
                    text: qsTr("Popülerliğe Göre Azalan");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (popupSirala.selectedBtnName == "popDec")
                           popupSirala.selectedBtnName = "";
                        else
                            popupSirala.selectedBtnName = "popDec";
                    }
                }
            }
            Item
            {
                width: parent.width *.25;
                height: parent.height;
            }

        }

        Row
        {
            height: popupSirala.height / 15;
            Layout.fillWidth: true;

            Item {
                width   : parent.width * 0.3 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }
            Rectangle
            {
                width: parent.width * .4;
                height: parent.height;
                color: "#08e225"
                Text{
                    text: qsTr("Uygula");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }

                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        if (popupSirala.selectedBtnName.length < 1)
                            return;

                        appWindow.sortEvents(popupSirala.selectedBtnName);
                        popupSirala.selectedBtnName = "";
                        popupSirala.close();

                    }
                }
            }

            Item {
                width   : parent.width * 0.3 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }
        }

    }


}
