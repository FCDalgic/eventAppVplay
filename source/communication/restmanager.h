#ifndef RESTMANAGER_H
#define RESTMANAGER_H

#include <QNetworkAccessManager>
#include <QObject>
#include <QUrlQuery>
#include <QNetworkReply>
/*!
    \class RESTManager
    \brief The RESTManager class is a class that handles RESTFUL communication between mobile devices and server.
    \since 0.1



    \ingroup sourcers
    \ingroup communication


    RESTManager handles GET and POST requests by given parameters as a QMap.
*/
/**
 * @brief The RESTManager class
 * Handles REST request including POST and GET types.
 * Emits messageReady2Parse signal when we get response from the server.
 */
class RESTManager : public QObject
{
    Q_OBJECT
public:
    explicit RESTManager(QObject *parent = nullptr);

    QUrl mURL;
    QNetworkAccessManager *mAccessManager;
    QNetworkReply *mReply;

    bool mIsAborted;

    void GET(QString hostName , QMap<QString, QString> data);
    void POST(QString hostName, QMap<QString, QString> data);
    void testFN();

protected:

public slots:

    void onFinished(QNetworkReply *pReply);
private:
    QUrlQuery constructPostData(QMap<QString, QString> data);
signals:
    void messageReady2Parse(QString pMessage);
};

#endif // RESTMANAGER_H
