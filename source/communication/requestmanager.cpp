#include "requestmanager.h"

RequestManager::RequestManager(QObject *parent) : QObject(parent)
{
    mRESTManager = new RESTManager();
    mParser = new NetworkMessageParser();

    initializeConnections();
}

/**
 * @brief RequestManager::initializeConnections
 * Initialize signal slot connections.
 */
void RequestManager::initializeConnections()
{
    connect(mRESTManager , SIGNAL(messageReady2Parse(QString)), mParser, SLOT(parseNetworkMessage(QString)));

    connect(mParser , SIGNAL(requestMessageParsed(QString,QList<EventContainer*>)), this , SLOT(onEventMessageParsed(QString,QList<EventContainer*>)));
    connect(mParser , SIGNAL(placesMessageParsed(QString,QList<PlaceContainer*>)) , this , SLOT(onpPlacesMessageParsed(QString,QList<PlaceContainer*>)));
}

/**
 * @brief RequestManager::onEventMessageParsed
 * Triggers when we get event request response from server. Then emits the appropriate signal which is related with transmitted event type to server.
 * Each emitable signal are corresponding to related container which are used in QML elements.
 * @param pType
 * Received request type
 * @param pEvents
 * List of events received from server reply.
 */
void RequestManager::onEventMessageParsed(QString pType, QList<EventContainer *> pEvents)
{
    if (pType == "homepage_recent")
        emit homepageRecentEventsRecevied(pEvents);
    else if (pType == "homepage_popular")
        emit homepagePopularEventsReceived(pEvents);
    else if (pType == "search")
        emit searchResultsReceived(pEvents);
    else if (pType == "food")
        emit foodEventsReceived(pEvents);
    else if (pType == "getFav" || pType == "addFav" || pType == "delFav")
        emit favouriteEventsRecevied(pEvents);
    else
        emit categoryEventsReceived(pEvents);
}

/**
 * @brief RequestManager::onpPlacesMessageParsed
 * Triggers when we get places request response from server. Then emits the appropriate signal which is related with transmitted event type to server.
 * Each emitable signal are corresponding to related container which are used in QML elements.
 * @param pType
 * Received request type
 * @param pEvents
 * List of events received from server reply.
 */
void RequestManager::onpPlacesMessageParsed(QString pType, QList<PlaceContainer *> pPlaces)
{
    if (pType == "places_view")
        placesListReceived(pPlaces);
}

void RequestManager::getEventsByType(QString pType, int pCount, QString pFilterType, QString pOrderType)
{
    QString hostname = "http://sehir-etkinlikleri.com/vplay/events.php";
    QMap<QString,QString> tmap;
    tmap.insert("type", pType);
    tmap.insert("total",QString::number(pCount));
    if (pFilterType.length() > 1)
        tmap.insert("filterType",  pFilterType);

    mLastReqMap = tmap;
    mRESTManager->GET(hostname, tmap);
}

void RequestManager::getPlaces()
{
    QString hostname = "http://sehir-etkinlikleri.com/vplay/places.php";
    QMap<QString,QString> tmap;
    tmap.insert("type", "places_view");

    mRESTManager->GET(hostname, tmap);
}


