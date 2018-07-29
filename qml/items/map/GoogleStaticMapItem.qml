import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

/*!
    \qmltype GoogleStaticMapItem
    \since 0.1
    \brief A component that creates static map image with using Google's Static Map API.
*/
Rectangle
{
    /*!
       \qmlproperty string GoogleStaticMapItem::staticApiKey
       The API Key generated from Developer Google Console.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit
    */
    property string staticApiKey: "";
    /*!
       \qmlproperty string GoogleStaticMapItem::latitude
       Latitude of desired coordinate.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa longitude
    */
    property real latitude: 0;
    /*!
       \qmlproperty string GoogleStaticMapItem::longitude
       Latitude of desired coordinate.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa latitude
    */
    property real longitude: 0;
    /*!
       \qmlproperty string GoogleStaticMapItem::pictureWidth
       Output image width taken from server.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa pictureHeight
    */
    property real pictureWidth: 800;
    /*!
       \qmlproperty string GoogleStaticMapItem::pictureHeight
       Output image height taken from server.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa pictureWidth
    */
    property real pictureHeight: 500;
    /*!
       \qmlproperty string GoogleStaticMapItem::zoom
       Output image zoom ratio taken from server.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa scale
    */
    property real zoom: 16;
    /*!
       \qmlproperty string GoogleStaticMapItem::scale
       Output image scale taken from server.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

       \sa zoom
    */
    property real scale: 2;
    /*!
       \qmlproperty string GoogleStaticMapItem::title
       The text will be overlayed on output image which is taken from server.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit

    */
    property string title: "";
    /*!
       \qmlproperty string GoogleStaticMapItem::enableGetDirection
       Enables or disables ability to open Direction API of GoogleMaps when user click on the image.
       \omit
           The "\qmlproperty <type> <property name>" is needed because
           property alias need to have their types manually entered.

           QDoc will not publish the documentation within omit and endomit.
       \endomit
    */
    property bool enableGetDirection: false;

    color: "transparent";

    Image {
        id: googleMapStaticImage;
        property string constant: "https://maps.googleapis.com/maps/api/staticmap?key=";
        property string url:        constant + parent.staticApiKey
                                  + "&center=" + parent.latitude + ", " + parent.longitude
                                  + "&zoom=" + parent.zoom
                                  + "&size=" + Math.ceil(parent.pictureWidth) + "x"  + Math.ceil(parent.pictureHeight)
                                  + "&markers=color:red|label:A|"
                                  + "scale:2|"
                                  + "title:" + parent.title;
        property variant temp;
        property string latitude: "-34.397";
        property string longitude: "150.644";

        source: url;
        width: parent.width;
        height: parent.height;
        sourceSize: Qt.size(width ,  height);

    }

    MouseArea
    {
        anchors.fill: parent;
        onClicked:
        {
            if (parent.enableGetDirection)
            {
                var directionURL =  "https://www.google.com/maps?saddr=My+Location&daddr=" + parent.latitude + "," + parent.longitude;
                Qt.openUrlExternally(directionURL);
            }
        }
    }
}
