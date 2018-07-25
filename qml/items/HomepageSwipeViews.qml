import QtQuick 2.0
import QtQuick.Controls 2.2
import "../../delegates"

ListView {
    id: view
    currentIndex: 1
    orientation:  ListView.Horizontal
    maximumFlickVelocity: 600
    implicitWidth: parent.implicitWidth

    SwipeViewDelegates{
        id: swDelegate
    }
    model: categoryResults.eventList
    delegate: swDelegate
}
