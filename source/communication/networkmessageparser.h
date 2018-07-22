#ifndef NETWORKMESSAGEPARSER_H
#define NETWORKMESSAGEPARSER_H

#include <source/data/eventcontainer.h>
#include <source/data/placecontainer.h>

#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QList>
#include <QTextDocument>

class NetworkMessageParser : public QObject
{
    Q_OBJECT
public:
    explicit NetworkMessageParser(QObject *parent = nullptr);

public slots:
    void parseNetworkMessage(QString pMessage);
signals:
    void requestMessageParsed(QString pType, QList<EventContainer*> pEvents);
    void placesMessageParsed(QString pType, QList<PlaceContainer*> pPlaces);
public slots:

private:
    QTextDocument mUnicodeDecoder;
};

#endif // NETWORKMESSAGEPARSER_H
