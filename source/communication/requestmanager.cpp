#include "requestmanager.h"

/*!
    \class RequestManager
    \brief The RequestManager class
        * Handles whole data requests.
        * Registered to Meta System in order to be used by QML elements
    \ingroup communication
    \inmodule EventApp
    The PreviewWindow class inherits QObject. The class receives raw server response and then
    tries to parse it. If input can be parsed succesfully, related signal will be emited according to desired data type.
    ...

*/



/*!
    \fn void RequestManager::recentEventsRecevied(QList<EventContainer*> pEvents)
    This signal is emited when we get recent type new event list from NetworkMessageParser.
    \a pEvents; event list
*/
/*!
    \fn void RequestManager::categoryEventsReceived(QList<EventContainer*> pEvents)
    This signal is emited when we get new category type event list from NetworkMessageParser.
    \a pEvents; event list
*/
/*!
    \fn void RequestManager::homepageRecentEventsRecevied(QList<EventContainer*> pEvents)
    This signal is emited when we get homepage recent type event list from NetworkMessageParser.
    \a pEvents; event list
*/
/*!
    \fn void RequestManager::placesListReceived(QList<PlaceContainer*> pPlaces)
    This signal is emited when we get new place list from NetworkMessageParser.
    \a pPlaces; place list
*/
RequestManager::RequestManager(QObject *parent) : QObject(parent)
{
    mRESTManager = new RESTManager();
    mParser = new NetworkMessageParser();

    initializeConnections();
}

/*!
    \fn void RequestManager::initializeConnections()
    * Initialize signal slot connections.
*/

//1
void RequestManager::initializeConnections()
{
    connect(mRESTManager , SIGNAL(messageReady2Parse(QString)), mParser, SLOT(parseNetworkMessage(QString)));

    connect(mParser , SIGNAL(requestMessageParsed(QString,QList<EventContainer*>)), this , SLOT(onEventMessageParsed(QString,QList<EventContainer*>)));
    connect(mParser , SIGNAL(placesMessageParsed(QString,QList<PlaceContainer*>)) , this , SLOT(onpPlacesMessageParsed(QString,QList<PlaceContainer*>)));
}


/*!
    \fn void RequestManager::onEventMessageParsed(QString pType, QList<EventContainer *> pEvents)
   Triggers when we get event request response from server. Then emits the appropriate signal which is related with transmitted event type to server.
   Each emitable signal are corresponding to related container which are used in QML elements
   \a pEvents; List of events received from server reply.
   \a pType; Received request type
*/
void RequestManager::onEventMessageParsed(QString pType, QList<EventContainer *> pEvents)
{
    if (pType == "homepage_recent")
        emit homepageRecentEventsRecevied(pEvents);
    else
        emit categoryEventsReceived(pEvents);
}

/*!
    \fn void RequestManager::onpPlacesMessageParsed(QString pType, QList<PlaceContainer *> pPlaces)
   Triggers when we get place_view request response from server. Then emits the appropriate signal which is related with transmitted  type to server.
   Each emitable signal are corresponding to related container which are used in QML elements
   \a pPlaces; List of places received from server reply.
   \a pType; Received request type
*/
void RequestManager::onpPlacesMessageParsed(QString pType, QList<PlaceContainer *> pPlaces)
{
    if (pType == "places_view")
        placesListReceived(pPlaces);
}
/*!
    \fn void RequestManager::getEventsByType(QString pType, int pCount, QString pFilterType, QString pOrderType)
    Send GET Request to server in order to get \e{events} from database according to given type, count, filterType and/or order type.
    \a pOrderType; Ordering info for SQL search
    \a pFilterType; Filter type for SQL search
    \a pCount; #events we want to get.
    \a pType; Desired type of event.
*/
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

/*!
    \fn void RequestManager::getPlaces()
    Send GET Request to server in order to get \e{places} from database.
*/
void RequestManager::getPlaces()
{
    QString hostname = "http://sehir-etkinlikleri.com/vplay/places.php";
    QMap<QString,QString> tmap;
    tmap.insert("type", "places_view");

    mRESTManager->GET(hostname, tmap);
}


