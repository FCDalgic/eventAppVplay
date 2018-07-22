#include "abstractplacescontroller.h"
#include <QDebug>

AbstractPlacesController::AbstractPlacesController(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<PlaceContainer> AbstractPlacesController::getPlaces()
{
    return QQmlListProperty<PlaceContainer>(this, mEventList);
}

void AbstractPlacesController::addPlaces(QList<PlaceContainer *> pEvents)
{
    mEventList.clear();
    mEventList.append(pEvents);

    qDebug() << "abstractplacescontroller list changed";
    emit placesListChanged();
}

void AbstractPlacesController::addPlace(PlaceContainer *pEvent)
{
    mEventList.append(pEvent);

    emit placesListChanged();
}

void AbstractPlacesController::cleanData()
{
    mEventList.clear();
    emit placesListChanged();
}

int AbstractPlacesController::getSectionCount(QString pSectionName , QString pSectionCriteria)
{
    int counter = 0;

    return counter;
}

void AbstractPlacesController::clear()
{
    mEventList.clear();
    emit placesListChanged();
}
