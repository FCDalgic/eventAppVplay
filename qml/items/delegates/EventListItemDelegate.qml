import VPlayApps 1.0
import QtQuick 2.0
import "../decoration/icons"

Rectangle {
  id: eventRow
  height: row.height + dp(10) * 2
  width: !parent ? 0 :(small ? parent.width - dp(25) : parent.width) // dp(25) is section selection width
  color: Theme.listItem.backgroundColor
  radius:  height * .2;
  property var eventModel
  property bool small
  signal clicked

  property StyleSimpleRow style: StyleSimpleRow { }

  RippleMouseArea {
    anchors.fill: parent
    circularBackground: false
    onClicked: {
      eventRow.clicked()
    }
  }


  Row {
    id: row
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 4
    anchors.centerIn: parent
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)

    LıstItemIcon {
      id: avatar
      width: dp(eventRow.style.fontSizeText) * 2.5
      height: width
      source: eventModel === undefined ? "" : eventModel.ImageURL;
    }

    Column {
      width: parent.width - avatar.width - row.spacing
      anchors.verticalCenter: parent.verticalCenter

      AppText {
        text: eventModel === undefined ? "" : eventModel.Name;
        color: appWindow.colorMain;
        width: parent.width
      }

      AppText {
        width: small? parent.width - dp(Theme.navigationBar.defaultBarItemPadding) : parent.width
        elide: AppText.ElideRight
        maximumLineCount: 1
        text: eventModel === undefined ? "" : "Place   : " + eventModel.Yer;
        color: Theme.secondaryTextColor
        font.pixelSize: sp(12)
      }

      AppText {
        width: small? parent.width - dp(Theme.navigationBar.defaultBarItemPadding) : parent.width
        elide: AppText.ElideRight
        maximumLineCount: 1
        text: eventModel === undefined ? "" : "Time    : " + eventModel.EventTime;
        color: Theme.secondaryTextColor
        font.pixelSize: sp(12)
      }


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
