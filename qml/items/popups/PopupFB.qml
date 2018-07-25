import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "../social/fb"
Popup {
    id: popupfb;
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



    Facebook {
        id: facebook
        property string facebook_display_style: "touch" // or "wap"
        property string facebook_application_id: "<YOUR FACEBOOK APP ID>"

        function whenUserIsAuthenticated(userid, usertoken){
            console.log("do something if u want to.");
        }
    }


}
