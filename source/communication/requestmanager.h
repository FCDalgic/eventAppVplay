#ifndef REQUESTMANAGER_H
#define REQUESTMANAGER_H

#include "networkmessageparser.h"
#include "restmanager.h"

#include <QObject>


/**
 * @brief The RequestManager class
 * Handles whole data requests.
 * Registered to Meta System in order to be used by QML elements
 */
class RequestManager : public QObject
{
    Q_OBJECT
public:
    explicit RequestManager(QObject *parent = nullptr);

signals:

    // Category signals
    void artEventsRecevied(QList<EventContainer*> pEvents);
    void concertEventsRecevied(QList<EventContainer*> pEvents);
    void foodEventsReceived(QList<EventContainer*> pEvents);
    void eatEventsRecevied(QList<EventContainer*> pEvents);
    void academicEventsRecevied(QList<EventContainer*> pEvents);
    void outdoorEventsRecevied(QList<EventContainer*> pEvents);
    void recentEventsRecevied(QList<EventContainer*> pEvents);
    void popularEventsRecevied(QList<EventContainer*> pEvents);
    void favouriteEventsRecevied(QList<EventContainer*> pEvents);
    void otherEventsRecevied(QList<EventContainer*> pEvents);
    void categoryEventsReceived(QList<EventContainer*> pEvents);

    // Homepage signals
    void searchResultsReceived(QList<EventContainer*> pEvents);
    void homepageRecentEventsRecevied(QList<EventContainer*> pEvents);
    void homepagePopularEventsReceived(QList<EventContainer*> pEvents);
    void missedEventsReceived(QList<EventContainer*> pEvents);

    // Place signals
    void placesListReceived(QList<PlaceContainer*> pPlaces);
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
