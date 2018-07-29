import VPlayApps 1.0
import QtQuick 2.0
import "../decoration/icons"

Rectangle {
  id: placeRow
  height: row.height + dp(10) * 2
  width: !parent ? 0 :(small ? parent.width - dp(25) : parent.width) // dp(25) is section selection width
  color: Theme.listItem.backgroundColor
  radius:  height * .2;
  property var placeModel
  property bool small
  signal clicked

  property StyleSimpleRow style: StyleSimpleRow { }

  RippleMouseArea {
    anchors.fill: parent
    circularBackground: false
    onClicked: {
      placeRow.clicked()
    }
  }


  Row {
    id: row
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 4
    anchors.centerIn: parent
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)

    AppText {
      width: parent.width - row.spacing
      anchors.verticalCenter: parent.verticalCenter
      id: placeName;
      text: placeModel === undefined ? "" : placeModel.Name;
      color: appWindow.colorMain;
    }
  }


  Icon {
    icon: IconType.angleright
    anchors.right: parent.right
    anchors.rightMargin: Theme.navigationBar.defaultBarItemPadding
    anchors.verticalCenter: parent.verticalCenter
    color: Theme.dividerColor
    visible: Theme.isIos
    size: dp(24)
  }
}
