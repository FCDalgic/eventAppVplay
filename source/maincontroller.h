#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include <QQmlContext>

#include <source/communication/requestmanager.h>

#include <source/modelcontrollers/categoryeventcontroller.h>
#include <source/modelcontrollers/completeplacescontroller.h>

class MainController : public QObject
{
    Q_OBJECT
public:
    explicit MainController(QQmlContext *pRoot, QObject *parent = nullptr);

signals:

public slots:


private:
    // To register cpp objects to meta system.
    QQmlContext* mRoot;
    RequestManager *mEventManager;
    CategoryEventController *mCategoryEvents; // Which contains, education, entertainment, outdoor, others, popular, recent.
    CompletePlacesController *mPlacesController;

    void initialize();
    void initObject();
    void register2Meta();
    void initializeConnections();
    void initHomepage();

};

#endif // MAINCONTROLLER_H
