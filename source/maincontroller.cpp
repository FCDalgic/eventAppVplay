#include "maincontroller.h"
#include <QQmlApplicationEngine>

/*!
   \brief Controls bindings between Cpp and QML

   This control class handles binding betweeen C++ and QML


   \section1 Setting default text and capitalization

   To set the default text, auto-capitalized input and password mode - use the properties:
*/

MainController::MainController(QQmlContext *pRoot, QObject *parent)
    : QObject(parent)
    , mRoot(pRoot)
    , mCategoryEvents(NULL)
    , mRequestManager(NULL)
    , mHomepageRecents(NULL)
    , mProfileManager(NULL)
{

    qmlRegisterType<EventContainer>();
    qmlRegisterType<PlaceContainer>();


    initialize();

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
    mRequestManager   = new RequestManager();
    mCategoryEvents   = new CategoryEventController();
    mPlacesController = new CompletePlacesController();
    mHomepageRecents  = new TopRecentEventsController();
    mProfileManager   = new ProfileManager();

}

void MainController::register2Meta()
{
    mRoot->setContextProperty("RequestManager"  , mRequestManager );
    mRoot->setContextProperty("CategoryResults" , mCategoryEvents);
    mRoot->setContextProperty("PlacesResults"   , mPlacesController);
    mRoot->setContextProperty("HomeRecentEvents", mHomepageRecents);
    mRoot->setContextProperty("ProfileManager"  , mProfileManager);
}


void MainController::initializeConnections()
{
    connect(mRequestManager , SIGNAL(categoryEventsReceived(QList<EventContainer*>))  , mCategoryEvents   , SLOT(addEventData(QList<EventContainer*>)));
    connect(mRequestManager , SIGNAL(placesListReceived(QList<PlaceContainer*>))      , mPlacesController , SLOT(addPlaces(QList<PlaceContainer*>)));
    connect(mRequestManager , SIGNAL(homepageRecentEventsRecevied(QList<EventContainer*>))  , mHomepageRecents       , SLOT(addEventData(QList<EventContainer*>)));
    connect(mRequestManager , SIGNAL(favouriteEventsRecevied(QList<EventContainer*>)) , mProfileManager   , SLOT(addEventData(QList<EventContainer*>)));

}

void MainController::initHomepage()
{
    mRequestManager->getEventsByType("homepage_recent" , 10);

    mProfileManager->autoLoginOnStart();

}
