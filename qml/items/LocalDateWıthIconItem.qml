import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent
    id: container
    property string mDate: ""
    property string mDateConverted: ""
    property date tDate: new Date()
    property real day  : 0
    property real month: 0
    property real year : 0

    RowLayout{
        anchors.fill: parent
        spacing: 10

        property var imageSize :Math.min( width*.4, height*.6)

        Rectangle{
            id: iconContainer
            width : parent.imageSize
            height: parent.imageSize
            anchors.verticalCenter:  parent.verticalCenter
            color: "transparent"
            Image {
                id: tImage
                source: "../../assets/images/fa/calendar-x64.png"
                sourceSize: Qt.size(parent.width, parent.height)
            }


            ColorOverlay{
                source: tImage
                anchors.fill: tImage
                color: appWindow.colorMain
            }
        }
        Rectangle{
            Layout.fillWidth: true
            anchors.left : iconContainer.right
            anchors.margins:  parent.spacing
            height: parent.height
            Text{
                wrapMode: Text.WordWrap
                anchors.verticalCenter : parent.verticalCenter
                text: container.mDateConverted
                Component.onCompleted: {
                    var tExpectedWidth = parent.width -parent.parent.spacing * 2;
                    if (width > tExpectedWidth) {
                        width = tExpectedWidth
                    }
                }
            }
        }
    }

    onMDateChanged: {
        print("Date changed")
        createLocalDate(mDate);
    }

    function createLocalDate(date){
        var tDayMonthYear = date.split(".");

        print("Deneme")
        day   =  parseInt(tDayMonthYear[0]);
        month =  parseInt(tDayMonthYear[1]);
        year  =  parseInt(tDayMonthYear[2]);

        tDate.setDate(year,month, day);

        mDateConverted = tDate.toLocaleDateString();
        print(mDateConverted)
    }
}
