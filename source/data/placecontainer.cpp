#include "placecontainer.h"

PlaceContainer::PlaceContainer(QObject *parent) : QObject(parent)
{

}

PlaceContainer::PlaceContainer(QString pName, QString pAddress, QString pCoordinate, QString pTelephone, QString pLink, QString pImage, QObject *parent)
    : QObject(parent)
    , mName(pName)
    , mAddress(pAddress)
    , mCoordinate(pCoordinate)
    , mTelephone(pTelephone)
    , mLink(pLink)
    , mImage(pImage)
{

}
