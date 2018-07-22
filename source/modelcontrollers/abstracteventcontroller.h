#ifndef ABSTRACTEVENTCONTROLLER_H
#define ABSTRACTEVENTCONTROLLER_H

#include <QObject>
#include <qqmllist.h>
#include <data/eventcontainer.h>

class AbstractEventController : public QObject
{
    Q_OBJECT
public:
    explicit AbstractEventController(QObject *parent = nullptr);

    Q_PROPERTY(QQmlListProperty<EventContainer> eventList READ getEvents NOTIFY eventListChanged)

    QQmlListProperty<EventContainer> getEvents();


signals:
    void eventListChanged();
    void RefreshScreen();
public slots:
    void addEventData(QList<EventContainer*> pEvents);
    void addEventData(EventContainer* pEvent);
    void addEventData(QString pID,QString pName,QString pCategory1
                     ,QString pCategory2,QString pEventDate,QString pAddress
                     ,QString pCoordinate,QString pModifiedDate,QString pDescription
                     ,QString pLink,QString pTags,QString pImageURL);

    void cleanData();

    Q_INVOKABLE int getSectionCount(QString pSectionName, QString pSectionCriteria = "EventDate");

    Q_INVOKABLE void clear();
public:
    QList<EventContainer*> mEventList;
};

#endif // ABSTRACTEVENTCONTROLLER_H
