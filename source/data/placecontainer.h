#ifndef PLACECONTAINER_H
#define PLACECONTAINER_H

#include <QObject>

class PlaceContainer : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString Name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString Address    READ getAddress WRITE setAddress NOTIFY addressChanged)
    Q_PROPERTY(QString Telephone READ getTelephone WRITE setTelephone NOTIFY telephoneChanged)
    Q_PROPERTY(QString Coordinate READ getCoordinate WRITE setCoordinate NOTIFY coordinateChanged)
    Q_PROPERTY(QString Link  READ getLink WRITE setLink NOTIFY linkChanged)
    Q_PROPERTY(QString Image  READ getImage WRITE setImage NOTIFY imageChanged)

public:
    explicit PlaceContainer(QObject *parent = nullptr);
    explicit PlaceContainer(QString pName
                          , QString pAddress
                          , QString pCoordinate
                          , QString pTelephone
                          , QString pLink
                          , QString pImage
                          , QObject *parent = NULL);


    QString getName()               { return mName;}
    QString getAddress()            { return mAddress;}
    QString getCoordinate()         { return mCoordinate;}
    QString getTelephone()          { return mTelephone;}
    QString getLink()               { return mLink;}
    QString getImage()              { return mImage;}

    void setName(QString pValue)        { mName         = pValue; nameChanged();}
    void setAddress(QString pValue)     { mAddress      = pValue; addressChanged();}
    void setCoordinate(QString pValue)  { mCoordinate   = pValue; coordinateChanged();}
    void setTelephone(QString pValue)   { mTelephone    = pValue; telephoneChanged();}
    void setLink(QString pValue)        { mLink         = pValue; linkChanged();}
    void setImage(QString pValue)       { mImage        = pValue; imageChanged();}

signals:
    void nameChanged();
    void addressChanged();
    void coordinateChanged();
    void telephoneChanged();
    void linkChanged();
    void imageChanged();

private:
    QString mName;
    QString mAddress;
    QString mCoordinate;
    QString mTelephone;
    QString mLink;
    QString mImage;
    int SiralamaOlcutu;
public slots:
};

#endif // PLACECONTAINER_H
