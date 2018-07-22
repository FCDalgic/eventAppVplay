#include "eventcontainer.h"

EventContainer::EventContainer(QObject *parent) : QObject(parent)
{

}

EventContainer::EventContainer(QString pID, QString pName, QString pEventTime, QString pCategory1
                              , QString pCategory2, QString pEventDate, QString pYer, QString pAddress
                              , QString pCoordinate, QString pTelephone, QString pLink, QString pRezervasyon, QString pDescription
                              , QString pTag1, QString pTag2, QString pTag3, QString pImageURL , QString pModifiedDate, QObject *parent)
    : QObject(parent)
    , ID(pID)
    , Name(pName)
    , EventTime(pEventTime)
    , EventDate(pEventDate)
    , Category1(pCategory1)
    , Category2(pCategory2)
    , Yer(pYer)
    , Address(pAddress)
    , Coordinate(pCoordinate)
    , Telephone(pTelephone)
    , Link(pLink)
    , Rezervasyon(pRezervasyon)
    , Description(pDescription)
    , Tag1(pTag1)
    , Tag2(pTag2)
    , Tag3(pTag3)
    , ImageURL(pImageURL)
    , ModifiedDate(pModifiedDate)
{

}

