#include "restmanager.h"



RESTManager::RESTManager(QObject *parent) : QObject(parent)
{
    mAccessManager = new QNetworkAccessManager();
    connect(mAccessManager , SIGNAL(finished(QNetworkReply*)), this ,SLOT(onFinished(QNetworkReply*)));
}


/**
 * @brief RESTManager::GET creates GET request.
 * @param hostName : address of your REST request.
 * @param data : a map which contains parameters and their values to bind paraemeters to that request.
 */
void RESTManager::GET(const QString hostName, QMap<QString, QString> data)
{
    QUrl url(hostName);

    if (data.size() < 1)
    {
        mAccessManager->get(QNetworkRequest(url));
        return;
    }

    QUrlQuery query;
    for(auto key : data.keys())
    {
      query.addQueryItem(key , data.value(key));
    }

    url.setQuery(query.query());


    mAccessManager->get(QNetworkRequest(url));
}

/**
 * @brief RESTManager::POST creates POST request.
 * @param hostName : address of your REST request.
 * @param data : a map which contains parameters and their values to bind paraemeters to that request.
 */
void RESTManager::POST(const QString hostName, QMap<QString, QString> data)
{
    QUrl url(hostName);

    if (data.size() < 1)
    {
        mAccessManager->get(QNetworkRequest(url));
        return;
    }

    QUrlQuery query;
    for(auto key : data.keys())
    {
      query.addQueryItem(key , data.value(key));
    }

    url.setQuery(query.query());

       mAccessManager->post(QNetworkRequest(url), query.toString(QUrl::FullyEncoded).toUtf8());
}

/**
 * @brief RESTManager::onFinished triggers when we got reply from server.
 * @param pReply server's reply
 */
void RESTManager::onFinished(QNetworkReply *pReply)
{
    QString tMessage = pReply->readAll();
    emit messageReady2Parse(tMessage);
}
