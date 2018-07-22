#ifndef ABSTRACTPLACESCONTROLLER_H
#define ABSTRACTPLACESCONTROLLER_H

#include <QObject>
#include <qqmllist.h>
#include <data/placecontainer.h>

class AbstractPlacesController : public QObject
{
    Q_OBJECT
public:
    explicit AbstractPlacesController(QObject *parent = nullptr);

    Q_PROPERTY(QQmlListProperty<PlaceContainer> placeList READ getPlaces NOTIFY placesListChanged)

    QQmlListProperty<PlaceContainer> getPlaces();


signals:
    void placesListChanged();
    void RefreshScreen();
public slots:
    void addPlaces(QList<PlaceContainer*> pEvents);
    void addPlace(PlaceContainer* pEvent);

    void cleanData();

    Q_INVOKABLE int getSectionCount(QString pSectionName, QString pSectionCriteria = "EventDate");

    Q_INVOKABLE void clear();
public:
    QList<PlaceContainer*> mEventList;
};

#endif // ABSTRACTPLACESCONTROLLER_H
