#include "networkmessageparser.h"

NetworkMessageParser::NetworkMessageParser(QObject *parent) : QObject(parent)
{

}

/**
 * @brief NetworkMessageParser::parseNetworkMessage
 * Parses the given network reply according to their type
 * @param pMessage
 * Server reply.
 */
void NetworkMessageParser::parseNetworkMessage(QString pMessage)
{
    mUnicodeDecoder.setHtml(pMessage);
    QString decoded = mUnicodeDecoder.toPlainText();

    QJsonDocument document = QJsonDocument::fromJson(decoded.toUtf8());
    QJsonObject  jsonObject = document.object();

    QJsonArray  jsonArray;

    qDebug() << "Network Reply . " << pMessage;

    try
    {
        QString tType =  jsonObject["request_type"].toString();

        if (tType == "places_view")
        {

            jsonArray = jsonObject["places"].toArray();
            QList<PlaceContainer*> tList;

            if (jsonArray.size() > 0)
            {
                PlaceContainer *tContainer;

                foreach (const QJsonValue & value, jsonArray) {

                    tContainer = new PlaceContainer();

                    QJsonObject obj = value.toObject();

                    tContainer->setName             (obj["name"].toString());
                    tContainer->setAddress          (obj["address"].toString());
                    tContainer->setCoordinate       (obj["coordinate"].toString());
                    tContainer->setTelephone        (obj["phone"].toString());
                    tContainer->setLink             (obj["website"].toString());
                    tContainer->setImage            (obj["image"].toString());

                    tList.append(tContainer);
                }

                if (tList.size() > 0)
                    emit placesMessageParsed(tType , tList);
            }
        }
        else
        {
            jsonArray = jsonObject["events"].toArray();
            QList<EventContainer*> tList;

            if (jsonArray.size() > 0)
            {

                QString tEventTime; QStringList tStringList;
                EventContainer *tContainer;
                foreach (const QJsonValue & value, jsonArray) {

                    tContainer = new EventContainer();

                    QJsonObject obj = value.toObject();

                    tContainer->setID               (obj["id"].toString());
                    tContainer->setName             (obj["name"].toString());
                    // Etkinlik Tarihinin alıştığımız formatta gösterilmesi için.
                    QString tDate = obj["eventDate"].toString().replace(" ", "");
                    QStringList dates= tDate.split("-");
                    tDate = dates[2] + "." +  dates[1] + "." + dates[0];
                    tContainer->setEventDate(tDate);

                    // Tarihe göre sıralamada daha hızlı gruplama sağlayabilemek adına.
                    int tSiralamaDegeri = QString(dates.at(2)).toInt()
                                        + QString(dates.at(1)).toInt() * 20
                                        + QString(dates.at(0)).toInt() * 10;
                    tContainer->setSiralamaOlcutu(tSiralamaDegeri);
                    // Diğer değerler
                    tEventTime = obj["eventTime"].toString();
                    if (tEventTime == "00:00:00")
                        tEventTime = "Belirtilmemiş";
                    else
                    {
                        tStringList = tEventTime.split(":");
                        tEventTime = tStringList[0] + ":" + tStringList[1];
                    }
                    tContainer->setEventTime        (tEventTime);
                    tContainer->setCategory1        (obj["category1"].toString());
                    tContainer->setCategory2        (obj["category2"].toString());
                    tContainer->setYer              (obj["yer"].toString());
                    tContainer->setAddress          (obj["address"].toString());
                    tContainer->setCoordinate       (obj["coordinate"].toString());
                    tContainer->setTelephone        (obj["telefon"].toString());
                    tContainer->setLink             (obj["link"].toString());
                    tContainer->setRezervasyon      (obj["biletRezevasyon"].toString());
                    tContainer->setDescription      (obj["description"].toString());
                    tContainer->setTag1             (obj["tag1"].toString());
                    tContainer->setTag2             (obj["tag2"].toString());
                    tContainer->setTag3             (obj["tag3"].toString());
                    tContainer->setImageURL         (obj["imageURL"].toString());
                    tContainer->setModifiedDate     (obj["modifiedDate"].toString());

                    tList.append(tContainer);
                }

            }

            if (tList.size() > 0)
                emit requestMessageParsed(tType , tList);
        }

    }
    catch (...)
    {
        qCritical() << "An error occured while trying to parse given server reply.";
    }

}

