import QtQuick 2.0
import QtQml.Models 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "../../items"
Rectangle
{
    id:container;
    width:  appWindow.width;
    height: visible ?  appWindow.height * 0.23 : 0;
    color:"transparent";
    /// status definitions:
    /// 0: Default, no action, means loaded
    /// 1: No internet connection
    /// 2: Something went wrong,display message.
    /// 3: Loading


    Component.onCompleted:
    {
        status = 3; // Açılır açılmaz başlangıçta yükleme ekranı gözüksün diye.
    }
    property real status: 0;
    function setStatus(pStatus)
    {
        status = pStatus;
    }

    property string categoryName: "";
    function setCategoryName(pName)
    {

        console.log(pName);
        container.categoryName = pName;
    }

    signal retryClicked();
    onStatusChanged:
    {

        console.log("Listview Mesaj Başlığı durumu değişti, durum değeri : " + status);
        switch(status)
        {
        case 0:
            wentWrong.visible = false;
            noInternetRetryButton.visible = false;
            loadingBusyLoader.visible = false;
            break;
        case 1:
            noInternetRetryButton.visible = true;
            wentWrong.visible = false;
            loadingBusyLoader.visible = false;
            break;
        case 2:
            noInternetRetryButton.visible = false;
            wentWrong.visible = true;
            loadingBusyLoader.visible = false;
            break;
        case 3:
            noInternetRetryButton.visible = false;
            wentWrong.visible = false;
            loadingBusyLoader.visible = true;
            break;

        }

        if (status == 0)
            container.visible = false;
        else
            container.visible = true;

    }

    visible: status !== 0 ? true :false;
    Rectangle
    {
        id: wentWrong;
        width: parent.width;
        height: parent.height;
        color: "white";
        radius: height / 10;
        visible: parent.status === 2;

        ColorableIcon
        {
            id: bilgilendirmeResim;
            width: height;
            iconPath:"../../assets/images/fa/unlem-x256.png";
            height: parent.height / 4;
            color: "transparent";
//            overlayColor: "white";
            anchors.left: parent.left;
            visible: parent.visible;
            anchors.top:parent.top;
        }

        Rectangle
        {
            id: bilgilendirmeMetniTutucu;
            width: parent.width - ( (parent.height / 2) + 10);
            height: parent.height;
            color: "transparent";
            anchors.left: bilgilendirmeResim.right;
            visible: parent.visible;

            Text
            {
                width: parent.width * .95;
                anchors.centerIn: parent;
                height: parent.height;
                text: "Bu kategori altındaki etkinliklerin yüklenmesi tahminimizden uzun sürüyor.\nSorun internet bağlantınızdan "
                + "kaynaklanıyor olabilir.\nFarklı bir sorun olduğunu düşünüyorsanız buraya tıklayarak bize bildirin.";
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap;
                horizontalAlignment: Text.AlignLeft;
                color:"gray";
            }

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                     Qt.openUrlExternally("mailto:?to=iletisim@sehir-etkinlikleri.com&subject=Bir hata buldum&body=");
                }
            }
        }
        ColorableIcon
        {
            id: kapatbutonu;
            width: height;
            iconPath:"../../assets/images/fa/close-x256.png";
            height: parent.height / 4;
            color: "transparent";
//            overlayColor: "white";
            overlayColor: "gray";
            anchors.top:parent.top;
            anchors.left: bilgilendirmeMetniTutucu.right;
            visible: parent.visible;

            MouseArea
            {
                anchors.fill: parent;
                onClicked:
                {
                    parent.parent.height = 0;
                    parent.parent.visible = false;
                }
            }
        }

    }



    Rectangle
    {
        id: noInternetRetryButton
        width: parent.width *.9;
        height: parent.height /2;
        anchors.centerIn: parent;
        color: Qt.lighter(appWindow.colorMain , 1.4);
        visible: parent.status === 1;
        radius: height / 4;


        Text
        {
           width: parent.width
           height: parent.height;
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           anchors.centerIn: parent;
           text: "Tekrar Dene"
           color:"white"

        }
        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                console.log("Listview mesaj header altında tekrarlanacak olan sorgu tipi " + container.categoryName);
                RequestManager.getEventsByType(container.categoryName , 10);
            }
        }
    }

    Rectangle
    {
        id : loadingBusyLoader;
        width: parent.width *.8;
        height: parent.height;
        visible: parent.status === 3;
        color:"transparent";
        anchors.centerIn: parent;
        BusyIndicator
        {
            id : bussy
            running: visible;
            width:  height;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height * 0.3;
            anchors.top: parent.top;
        }
        ColorOverlay
        {
            visible: parent.visible;
            source: bussy;
            anchors.fill: bussy;
            color: "white"
        }

        Text {
            id: busyText
            text: "Etkinlikler Yükleniyor"
            width: parent.width;
            height: parent.height / 4;
            anchors.top: bussy.bottom; //flickablePageSelectedCategory.status != "abort" ? bussy.bottom : parent.top;
            horizontalAlignment: Text.AlignHCenter;
            wrapMode: Text.WordWrap;
            color:"white";


        }

    }
}
