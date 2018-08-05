import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../items"
import "../../items/delegates"
import "../../items/decoration/spaces"

import VPlayApps 1.0
import VPlayPlugins 1.0

Page
{
    id: requestAuthPage;
    width: appWindow.width;
    height : appWindow.height;

    property string mail: "";
    property string pass: "";
    property string err : "";
    title: "Login";
    rightBarItem:NavigationBarItem {

        // we specify the width of the item with the contentWidth property
        // the item width then includes the contentWidth and a default padding
        contentWidth: contentRect.width

        // the navigation bar item shows a colored rectangle
        Rectangle {
          id: contentRect
          width: dp(Theme.navigationBar.defaultIconSize)
          height: width
          anchors.centerIn: parent
          color: "transparent";


          Icon {
            anchors.fill: parent
            icon: IconType.navicon
            color: Theme.navigationBar.itemColor

            MouseArea
            {
                onClicked: appWindow.openNavDrawer();
                anchors.fill: parent;
            }
          }
        }
      } // NavigationBarItem


    property real restHeight: appWindow.height * .8;

    AppFlickable {
        id: flickablePageAbout;
        anchors.fill: parent;
        //    anchors.fill: parent
        clip: true
        contentHeight: myButtons.height + 200;
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        maximumFlickVelocity: appWindow.height  * 5;

        property var locale: Qt.locale()    // Get the local language

        Column
        {
            id: myButtons
            focus: false
            width: appWindow.width;
            spacing: 0;

            // Banner
            Rectangle
            {
                color: "transparent";
                width: appWindow.width;
                height: requestAuthPage.restHeight * .36;

                Rectangle
                {
                    color:"transparent";
                    width: parent.width;
                    height: parent.height;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    Image
                    {
                        id : imgImza;
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent;
                        source:  "../../../assets/images/v3/Logo_.png";

                    }
                    ColorOverlay
                    {
                        source:imgImza;
                        anchors.fill:  imgImza;
                        color: "white";
                    }

                }


            }


            Rectangle
            {
                color:"transparent";
                width: appWindow.width;
                height: requestAuthPage.restHeight / 20;


            }




            // Login text fields and buttons.
            Rectangle
            {
                id : tbAndButtonContainer;
                width: appWindow.width;
                height: requestAuthPage.restHeight / 3;
                color: "transparent";

                Column
                {
                    id : tbAndButtonLayout;
                    spacing: 0;
                    anchors.fill: parent;

                    Rectangle
                    {

                        AppText
                        {
                            anchors.centerIn: parent;
                            text: "Login with Facebook";
                            color: "white";
                        }

                        color : "#3B5998"
                        id: fbLoginButton;
                        width:  appWindow.width * .8;
                        height: tbAndButtonContainer.height / 6;
                        radius: height *.25;

                        anchors.horizontalCenter: parent.horizontalCenter;
                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked: appWindow.loginWithFB();
                        }

                    }

                    Rectangle { width: tbAndButtonContainer.width; height: tbAndButtonContainer.height / 10; color: "transparent"; }

                    //
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 6;
                        color: "transparent";

                        AppText
                        {
                            id: textSignup
                            anchors.centerIn: parent;
                            text: "OR SIGN IN"
                            color: "white";
                        }

                    }

                    Rectangle { width: tbAndButtonContainer.width; height: tbAndButtonContainer.height / 10; color: "transparent"; }

                    // Mail Input
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 6;
                        color: "transparent";
                        TextField
                        {
                            id:  mailEntry;
                            height: parent.height;
                            width: parent.width * .8;
                            anchors.centerIn: parent;
                            background: Rectangle
                            {
                                color: "white";
                                opacity: 0.5;
                                width: mailEntry.width;
                                height: mailEntry.height;

                                radius: height *.25;

                            }
                            color: "lightgray";
                            placeholderText: "Mail:"
                            onTextChanged: requestAuthPage.mail = text;

                            KeyNavigation.tab: passEntry;
                            Keys.onBackPressed:
                            {
                                console.info("Hiding keyboard");
                                InputMethod.hide();
                            }
                            onFocusChanged:
                            {
                                if (!focus)
                                    InputMethod.hide();
                            }
                        }

                    }
                    // Space
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 8;
                        color: "transparent";
                    }
                    // Password Input
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 6;
                        color: "transparent";
                        TextField
                        {
                            id:  passEntry;
                            height: parent.height;
                            width: parent.width * .8;
                            echoMode: TextField.Password;
                            anchors.centerIn: parent;
                            background: Rectangle
                            {
                                color: "white";
                                opacity: 0.5;
                                width: mailEntry.width;
                                height: mailEntry.height;

                                radius: height *.25;

                            }
                            color: "lightgray";
                            placeholderText: "Password:"
                            onTextChanged: requestAuthPage.pass = text;

                        }

                    }
                    // Space
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 8;
                        color: "transparent";
                    }
                    // Login Button
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 6;
                        color: "transparent";

                        Rectangle
                        {
                            id:  loginButton;
                            height: parent.height;
                            width: parent.width * .8;
                            radius: height *.25;
                            anchors.centerIn: parent;
                            color: appWindow.colorMain;
                            opacity: 0.7;
                            Text
                            {
                                anchors.centerIn: parent;
                                height: parent.height;
                                text: qsTr("Login");
                                color: "white";
                            }

                            MouseArea
                            {
                                anchors.fill: parent;
                                onClicked: ProfileManager.login(requestAuthPage.mail , requestAuthPage.pass);
                            }

                        }
                    }
                    // Space
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 20;
                        color: "transparent";
                    }
                    // Forget Password? Text - Button
                    Rectangle
                    {
                        width: tbAndButtonContainer.width;
                        height: tbAndButtonContainer.height / 4;
                        color: "transparent";
                        Text
                        {
                            anchors.centerIn: parent;
                            height: parent.height;
                            text: qsTr("Forgot my password!");
                            color: "lightgray";
                        }

                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked:
                            {
                                appWindow.categorySelected("page_forgot_my_password");
                            }
                        }
                    }
                }
            }



            Rectangle
            {
                color:"transparent";
                width: appWindow.width;
                height: requestAuthPage.restHeight / 20;
            }
            // SignUp Field
            Rectangle
            {

                width: appWindow.width;
                height: requestAuthPage.restHeight / 3;
                color: "transparent";

                Rectangle
                {
                    id : errorContainer;
                    width: parent.width;
                    height: parent.height / 8;
                    anchors.top: parent.top;
                    color: "transparent";

                    Text
                    {
                        anchors.centerIn: parent;
                        height: parent.height;
                        text: "Error"
                        color: "#730505"

                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked:
                            {
                                appWindow.categorySelected("page_signin");
                            }
                        }
                    }


                }
                Rectangle
                {
                    id : errorSpace;
                    width: parent.width;
                    height: parent.height / 8;
                    anchors.top: errorContainer.bottom;
                    color: "transparent";
                }

                Rectangle
                {
                    width: parent.width;
                    height: parent.height / 8;
                    anchors.top: errorSpace.bottom;
                    color: "transparent";

                    Text
                    {
                        anchors.centerIn: parent;
                        height: parent.height;
                        text: qsTr("SignUp Şehir Etkinlikleri!");
                        color: "lightgray";

                        MouseArea
                        {
                            anchors.fill: parent;
                            onClicked:
                            {
                                appWindow.categorySelected("page_signin");
                            }
                        }
                    }


                }
            }


        }

    }

}
