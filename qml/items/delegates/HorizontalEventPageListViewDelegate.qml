import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"

Rectangle {

    id : elements

    signal viewAllSelected();
    Row
    {
        spacing: 30;
        anchors.verticalCenter:  parent.verticalCenter;



        Rectangle {
            id: eventIcon
            width:  elements.width * .3
            height: elements.height;
            anchors.margins: 5;
            property string src: model.modelData.ImageURL;

            Image {
                source: model.modelData.ImageURL;
                width: parent.width    * 0.75;
                height: parent.height  * 0.75;
                anchors.centerIn: parent;
                sourceSize: Qt.size(width, height);
            }
            Rectangle
            {
                width: parent.width    * 0.75;
                height: parent.height  * 0.75;
                anchors.centerIn: parent;
                color: parent.src.length > 5 ? "transparent"  : "black";
                visible: parent.src.length > 5 ? "false"  : "true";
            }
        }

        Rectangle{
            id: container
            height: eventIcon.height;
            anchors.margins: 5;
            width:  elements.width - eventIcon.width - 30; //  - space.width

            ColumnLayout{
                spacing: 1
                anchors.fill: parent
                Row{
                    Text {
                        id: name
                        font.pointSize:  11
                        text: model.modelData.Name;
                        verticalAlignment: Text.AlignBottom;
                        height: container.height * 0.3;
                        width: container.width *.9;
                        wrapMode: Text.WordWrap;
                    }
                }
                Row{
                    Text {
                        id: date
                        font.pointSize:  11
                        text: model.modelData.EventDate;
                        verticalAlignment: Text.AlignBottom;
                        height: container.height * 0.3;
                        width: container.width *.9;
                        wrapMode: Text.WordWrap;
                    }
                }
                Row{
                    Text {
                        id: place
                        font.pointSize:  11
                        text: model.modelData.Yer;
                        verticalAlignment: Text.AlignBottom;
                        height: container.height * 0.3;
                        width: container.width *.9;
                        wrapMode: Text.WordWrap;
                    }


                }

            }

        }


    }


} // Rectangle ends
