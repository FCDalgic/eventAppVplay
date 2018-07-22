#ifndef RESTMANAGER_H
#define RESTMANAGER_H

#include <QNetworkAccessManager>
#include <QObject>
#include <QUrlQuery>
#include <QNetworkReply>

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

    void GET(const QString hostName , QMap<QString, QString> data);
    void POST(const QString hostName, QMap<QString, QString> data);

protected:

public slots:

    void onFinished(QNetworkReply *pReply);
private:
    QUrlQuery constructPostData(QMap<QString, QString> data);
signals:
    void messageReady2Parse(QString pMessage);
};

#endif // RESTMANAGER_H
