#include "abstracteventcontroller.h"

AbstractEventController::AbstractEventController(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<EventContainer> AbstractEventController::getEvents()
{
    return QQmlListProperty<EventContainer>(this, mEventList);
}

void AbstractEventController::addEventData(QList<EventContainer *> pEvents)
{
    mEventList.clear();
    mEventList.append(pEvents);

    emit eventListChanged();
}

void AbstractEventController::addEventData(EventContainer *pEvent)
{
    mEventList.append(pEvent);

    emit eventListChanged();
}

void AbstractEventController::addEventData(QString pID, QString pName, QString pCategory1, QString pCategory2, QString pEventDate, QString pAddress, QString pCoordinate, QString pModifiedDate, QString pDescription, QString pLink, QString pTags, QString pImageURL)
{
//    EventContainer *tContainer = new EventContainer(pID, pName, pCategory1, pCategory2 , pEventDate , pAddress, pCoordinate, pModifiedDate, pDescription, pLink,pTags,pImageURL);

//    mEventList.append(tContainer);

//    mEventList.clear();
//    mEventList.append(tContainer);
    //    emit eventListChanged();
}

void AbstractEventController::cleanData()
{
    mEventList.clear();
    emit eventListChanged();
}

int AbstractEventController::getSectionCount(QString pSectionName , QString pSectionCriteria)
{
    int counter = 0;
    foreach (EventContainer *container, mEventList) {
        if (pSectionCriteria == "EventDate")
            if (pSectionName == container->getEventDate())
                counter++;
    }

    return counter;
}

void AbstractEventController::clear()
{
    mEventList.clear();
    emit eventListChanged();
}
