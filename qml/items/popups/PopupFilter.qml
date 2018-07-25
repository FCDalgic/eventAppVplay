import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Popup {
    id: popupFiltrele;
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
            height: popupFiltrele.height / 20;
            Layout.fillWidth: true;
            Rectangle
            {
                width: parent.width;
                height: parent.height;
                color: "transparent";
                Text{
                    text: qsTr("Hızlı Seçenekler");
                    anchors.centerIn: parent;
                    font.pointSize: 7;
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                }
            }
        }

        Row
        {
            anchors.margins: 2;
            height: popupFiltrele.height / 10;
            Layout.fillWidth: true;
            spacing: 5;


            Item {
                width   : parent.width * 0.15 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

            Rectangle{
                color:  popupFiltrele.selectedBtnName == "today" ? "yellow" : appWindow.colorMain  ;
                width   : parent.width * 0.3;
                anchors.margins: 10;
                height: parent.height;

                Text{
                    text: qsTr("Bugün");
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
                         if (popupFiltrele.selectedBtnName == "today")
                             popupFiltrele.selectedBtnName = "";
                         else
                             popupFiltrele.selectedBtnName = "today";
                    }
                }

            }

            Item {
                width   : parent.width * 0.1 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

            Rectangle{
                color:  popupFiltrele.selectedBtnName == "tomorrow" ? "yellow" : appWindow.colorMain  ;
                width   : parent.width * 0.3;
                height: parent.height;
                anchors.margins: 10;
                Text{
                    text: qsTr("Yarın");
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
                        if (popupFiltrele.selectedBtnName == "tomorrow")
                            popupFiltrele.selectedBtnName = "";
                        else
                            popupFiltrele.selectedBtnName = "tomorrow";
                    }
                }
            }
            Item {
                width   : parent.width * 0.15 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

        }

        Row
        {
            anchors.margins: 2;
            height: popupFiltrele.height / 10;
            Layout.fillWidth: true;
            spacing: 5;


            Item {
                width   : parent.width * 0.15 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

            Rectangle{
                color:  popupFiltrele.selectedBtnName == "week" ? "yellow" : appWindow.colorMain  ;
                width   : parent.width * 0.3;
                anchors.margins: 10;
                height: parent.height;

                Text{
                    text: qsTr("Bu Hafta");
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
                        if (popupFiltrele.selectedBtnName == "week")
                            popupFiltrele.selectedBtnName = "";
                        else
                            popupFiltrele.selectedBtnName = "week";
                    }
                }

            }

            Item {
                width   : parent.width * 0.1 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

            Rectangle{
                color:  popupFiltrele.selectedBtnName == "month" ? "yellow" : appWindow.colorMain  ;
                width   : parent.width * 0.3;
                height: parent.height;
                anchors.margins: 10;
                Text{
                    text: qsTr("Hepsi");
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
                        if (popupFiltrele.selectedBtnName == "month")
                           popupFiltrele.selectedBtnName = "";
                        else
                            popupFiltrele.selectedBtnName = "month";
                    }
                }
            }
            Item {
                width   : parent.width * 0.15 -  parent.spacing;
                height  : parent.height;
                enabled: false;
            }

        }

        Row
        {
            height: popupFiltrele.height / 15;
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
                        if (popupFiltrele.selectedBtnName.length < 1)
                            return;

                        appWindow.setDateFilterForCategory(popupFiltrele.selectedBtnName);
                        popupFiltrele.selectedBtnName = "";
                        popupFiltrele.close();

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
