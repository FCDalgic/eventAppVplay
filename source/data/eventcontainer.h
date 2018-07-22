#ifndef EVENTCONTAINER_H
#define EVENTCONTAINER_H

#include <QObject>
#include <QDebug>

class EventContainer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString EventDate    READ getEventDate WRITE setEventDate NOTIFY eventDateChanged)
    Q_PROPERTY(QString EventTime READ getEventTime WRITE setEventTime NOTIFY evetTimeChanged)
    Q_PROPERTY(QString ID READ getID WRITE setID NOTIFY idChanged)
    Q_PROPERTY(QString Name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString Category1 READ getCategory1 WRITE setCategory1 NOTIFY category1Changed)
    Q_PROPERTY(QString Category2 READ getCategory2 WRITE setCategory2 NOTIFY category2Changed)
    Q_PROPERTY(QString Yer READ getYer WRITE setYer NOTIFY yerChanged)
    Q_PROPERTY(QString Address    READ getAddress WRITE setAddress NOTIFY addressChanged)
    Q_PROPERTY(QString Coordinate READ getCoordinate WRITE setCoordinate NOTIFY coordinateChanged)
    Q_PROPERTY(QString Telephone READ getTelephone WRITE setTelephone NOTIFY telephoneChanged)
    Q_PROPERTY(QString Link  READ getLink WRITE setLink NOTIFY linkChanged)
    Q_PROPERTY(QString Rezervasyon READ getRezervasyon WRITE setRezervasyon NOTIFY rezervasyonChanged)
    Q_PROPERTY(QString Description  READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString Tag1  READ getTag1 WRITE setTag1 NOTIFY tag1Changed)
    Q_PROPERTY(QString Tag2  READ getTag2 WRITE setTag2 NOTIFY tag2Changed)
    Q_PROPERTY(QString Tag3  READ getTag3 WRITE setTag3 NOTIFY tag3Changed)
    Q_PROPERTY(QString ImageURL  READ getImageURL WRITE setImageURL NOTIFY imageURLChanged)
    Q_PROPERTY(QString ModifiedDate READ getModifiedDate WRITE setModifiedDate NOTIFY modifiedDateChanged)
    Q_PROPERTY(int SiralamaOlcutu READ getSiralamaOlcutu WRITE setSiralamaOlcutu NOTIFY siralamaOlcutuChanged)

public:
    explicit EventContainer(QObject *parent = nullptr);
    explicit EventContainer(QString pID
                          , QString pEventDate
                          , QString pEventTime
                          , QString pName
                          , QString pCategory1
                          , QString pCategory2
                          , QString pYer
                          , QString pAddress
                          , QString pCoordinate
                          , QString pTelephone
                          , QString pLink
                          , QString pRezervasyon
                          , QString pDescription
                          , QString pTag1
                          , QString pTag2
                          , QString pTag3
                          , QString pImageURL
                          , QString pModifiedDate
                          , QObject *parent = NULL);


    QString getEventDate()          { return EventDate;}
    QString getEventTime()          { return EventTime;}
    QString getID()                 { return ID;}
    QString getName()               { return Name;}
    QString getCategory1()          { return Category1;}
    QString getCategory2()          { return Category2;}
    QString getYer()                { return Yer;}
    QString getAddress()            { return Address;}
    QString getCoordinate()         { return Coordinate;}
    QString getTelephone()           { return Telephone;}
    QString getLink()               { return Link;}
    QString getRezervasyon()        { return Rezervasyon;}
    QString getDescription()        { return Description;}
    QString getTag1()               { return Tag1;}
    QString getTag2()               { return Tag2;}
    QString getTag3()               { return Tag3;}
    QString getImageURL()           { return ImageURL;}
    QString getModifiedDate()       { return ModifiedDate;}
    int getSiralamaOlcutu()     { return SiralamaOlcutu;}

    void setEventDate(QString pValue)   { EventDate    = pValue   ;}
    void setEventTime(QString pValue)   { EventTime    = pValue   ;}
    void setID(QString pValue)          { ID           = pValue   ;}
    void setName(QString pValue)        { Name         = pValue   ;}
    void setCategory1(QString pValue)   { Category1    = pValue   ;}
    void setCategory2(QString pValue)   { Category2    = pValue   ;}
    void setYer(QString pValue)         { Yer          = pValue   ;}
    void setAddress(QString pValue)     { Address      = pValue   ;}
    void setCoordinate(QString pValue)  { Coordinate   = pValue   ;}
    void setTelephone(QString pValue)   { Telephone    = pValue   ;}
    void setLink(QString pValue)        { Link         = pValue   ;}
    void setRezervasyon(QString pValue) { Rezervasyon  = pValue   ;}
    void setDescription(QString pValue) { Description  = pValue   ;}
    void setTag1(QString pValue)        { Tag1         = pValue   ; /*qDebug() << "Ücret bilgisi : " << Tag1; */}
    void setTag2(QString pValue)        { Tag2         = pValue   ;}
    void setTag3(QString pValue)        { Tag3         = pValue   ;}
    void setImageURL(QString pValue)    { ImageURL     = pValue   ;}
    void setModifiedDate(QString pValue){ ModifiedDate = pValue   ;}
    void setSiralamaOlcutu(int pValue)  {SiralamaOlcutu= pValue   ;}
signals:
    void eventDateChanged();
    void evetTimeChanged();
    void idChanged();
    void nameChanged();
    void category1Changed();
    void category2Changed();
    void yerChanged();
    void addressChanged();
    void coordinateChanged();
    void telephoneChanged();
    void linkChanged();
    void rezervasyonChanged();
    void descriptionChanged();
    void tag1Changed();
    void tag2Changed();
    void tag3Changed();
    void imageURLChanged();
    void modifiedDateChanged();
    void siralamaOlcutuChanged();

private:
    QString EventDate,EventTime,ID,Name,Category1,Category2,Yer,Address,Coordinate,Telephone,Link, Rezervasyon ,Description,Tag1, Tag2 , Tag3, ImageURL, ModifiedDate;
    int SiralamaOlcutu;
public slots:
};

#endif // EVENTCONTAINER_H
