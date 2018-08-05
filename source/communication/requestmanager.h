#ifndef REQUESTMANAGER_H
#define REQUESTMANAGER_H

#include "networkmessageparser.h"
#include "restmanager.h"

#include <QObject>



class RequestManager : public QObject
{
    Q_OBJECT
public:
    explicit RequestManager(QObject *parent = nullptr);

signals:

    // Category signals
    void recentEventsRecevied(QList<EventContainer*> pEvents);
    void categoryEventsReceived(QList<EventContainer*> pEvents);

    // Homepage signals
    void homepageRecentEventsRecevied(QList<EventContainer*> pEvents);

    // Place signals
    void placesListReceived(QList<PlaceContainer*> pPlaces);

    // Profie Signals
    void favouriteEventsRecevied(QList<EventContainer*> pEvents);

public slots:
    void onEventMessageParsed(QString pType, QList<EventContainer*> pEvents);
    void onpPlacesMessageParsed(QString pType, QList<PlaceContainer*> pPlaces);
    void getEventsByType(QString pType, int pCount, QString pFilterType = "", QString pOrderType = "");
    void getPlaces();

private:
    NetworkMessageParser *mParser;
    RESTManager *mRESTManager;
    QMap<QString, QString> mLastReqMap;

    void initializeConnections();
    void prepareAndSend(QMap<QString, QString> pParams);
};

#endif // REQUESTMANAGER_H
