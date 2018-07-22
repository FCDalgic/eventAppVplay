#include "maincontroller.h"
#include <QQmlApplicationEngine>

MainController::MainController(QQmlContext *pRoot, QObject *parent)
    : QObject(parent)
    , mCategoryEvents(NULL)
    , mEventManager(NULL)
    , mRoot(pRoot)
{

    qmlRegisterType<EventContainer>();
    qmlRegisterType<PlaceContainer>();

}

void MainController::initialize()
{
    initObject();

    initializeConnections();

    register2Meta();

    initHomepage();
}

void MainController::initObject()
{
    mEventManager   = new RequestManager();
    mCategoryEvents = new CategoryEventController();
    mPlacesController = new CompletePlacesController();

}

void MainController::register2Meta()
{
    mRoot->setContextProperty("RequestManager"  , mEventManager );
    mRoot->setContextProperty("CategoryResults" , mCategoryEvents);
    mRoot->setContextProperty("PlacesResults"   , mPlacesController);

}


void MainController::initializeConnections()
{
    connect(mEventManager , SIGNAL(categoryEventsReceived(QList<EventContainer*>))  , mCategoryEvents   , SLOT(addEventData(QList<EventContainer*>)));
    connect(mEventManager , SIGNAL(placesListReceived(QList<PlaceContainer*>))      , mWholePlaces      , SLOT(addPlaces(QList<PlaceContainer*>)));
}

void MainController::initHomepage()
{
    mEventManager->getEventsByType("homepage_recent" , 10);
}
