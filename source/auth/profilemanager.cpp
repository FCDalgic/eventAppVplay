#include "profilemanager.h"

ProfileManager::ProfileManager(QObject *parent)
    : QObject(parent)
    , mThread(NULL)
    , mTimer(NULL)
    , mRESTManager(NULL)
{
    mUserStatus = UserStatus::GENERAL_NOT_LOGGED;
    mInfo = new UserInfoContainer();
    mRESTManager = new RESTManager();

    mPath = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    QString filename = "se.ini";
    mPath = mPath + "/" + filename;

    connect(mRESTManager , SIGNAL(messageReady2Parse(QString)) , this , SLOT(parseMessage(QString)) );
}

QQmlListProperty<EventContainer> ProfileManager::getEvents()
{
    return QQmlListProperty<EventContainer>(this, mEventList);
}

void ProfileManager::addEventData(QList<EventContainer *> pEvents)
{

    qCritical() << "Adding Event Data to Favourites ........" << endl << endl << endl;
    mEventList.clear();
    mFavList.clear();

    mEventList.append(pEvents);

    foreach (auto event, pEvents) {
        mFavList.append(event->getID());
    }

    emit eventListChanged();
}

void ProfileManager::autoLoginOnStart()
{
    QSettings settings(mPath , QSettings::NativeFormat);

    QString mail  = settings.value("ŞehirEtkinlikleri/Mail" , "").toString();
    QString pass  = settings.value("ŞehirEtkinlikleri/Pass" , "").toString();

    qDebug() << "Stored Mail : " << mail << " pass : " << pass;

    if (mail.length() < 1 || pass.length() < 1)
        return;

    login(mail , pass);
}

bool ProfileManager::isEventFavourite(QString pEventID)
{
    bool flag = false;

    qDebug() << "is event favourite called , id : " << pEventID;
    foreach (QString id, mFavList) {
        qDebug() << "Current id = " << id;
        if (id == pEventID)
        {
            flag = true;
            break;
        }
    }

    return flag;
}

int ProfileManager::getUserStatusID()
{
    int value = mUserStatus;
    return value;
}

void ProfileManager::logOut()
{
    // Kayıtlı verileri temizle.
    resetRegistery();
    // Favorileri temizle
    mFavList.clear();
    // Ekran arayüzlerinin güncellenmesi için (Etkinliğin favori olarak gözükmesi)
    // ilgili event'i tetikle.
    eventListChanged();

    setLoginStatus(UserStatus::GENERAL_NOT_LOGGED);
    setLoggedIn(false);

}

QString ProfileManager::getStoredMail()
{
    QSettings settings(mPath , QSettings::NativeFormat);
    QString mail  = settings.value("ŞehirEtkinlikleri/Mail" , "").toString();
    return mail;
}

QString ProfileManager::getStoredPass()
{
    QSettings settings(mPath , QSettings::NativeFormat);
    QString pass  = settings.value("ŞehirEtkinlikleri/Pass" , "").toString();
    return pass;
}

void ProfileManager::sendResetMail(QString pMail)
{
    mStoredResetMail = pMail;

    QString hostname = "http://sehir-etkinlikleri.com/auth/register.php";
    QMap<QString,QString> tmap;
    tmap.insert("mail",pMail);
    tmap.insert("fid" , "4"); // Şifre yenileme maili için function id = 4
    mRESTManager->GET(hostname, tmap);
}

QString ProfileManager::getStoredResetMail()
{
    return mStoredResetMail;
}

void ProfileManager::updatePassword(QString pMail, QString pPassword, QString pKey)
{
    mStoredResetMail = "";

    QString hostname = "http://sehir-etkinlikleri.com/auth/register.php";
    QMap<QString,QString> tmap;
    tmap.insert("mail",pMail);
    tmap.insert("pass",pPassword);
    tmap.insert("key" ,pKey);
    tmap.insert("fid" , "5"); // Şifre güncellemek için function id = 5
    mRESTManager->GET(hostname, tmap);
}

void ProfileManager::login(QString pMail, QString pPassword)
{
    QString hostname = "http://sehir-etkinlikleri.com/auth/register.php";
    qDebug() << "Trying to login with given information "<< pMail << " - "  << pPassword << endl;
    QMap<QString,QString> tmap;
    tmap.insert("mail",pMail);
    tmap.insert("pass",pPassword);
    tmap.insert("fid" , "2"); // Login için function id = 2
    mRESTManager->GET(hostname, tmap);

}

void ProfileManager::signUp(QString pMail, QString pPassword)
{
    QString hostname = "http://sehir-etkinlikleri.com/auth/register.php";
    QMap<QString,QString> tmap;
    tmap.insert("mail",pMail);
    tmap.insert("pass",pPassword);
    tmap.insert("fid" , "1"); // Register için function id = 1
    mRESTManager->GET(hostname, tmap);

}

void ProfileManager::parseMessage(QString pMessage)
{
    mUnicodeDecoder.setHtml(pMessage);
    QString decoded = mUnicodeDecoder.toPlainText();
    QJsonDocument document = QJsonDocument::fromJson(decoded.toUtf8());
    QJsonObject  jsonObject = document.object();

    QString fid = jsonObject["fid"].toString();
    bool error = jsonObject["error"].toBool();
    qDebug() <<"Profile Manager Mesaj Geldi :" << pMessage << endl << endl << "Function ID " << fid;
    QString msg = jsonObject["message"].toString();
    if (error)
    {

        if (msg == "User not registered" || msg.contains("not registered"))
        {
            setLoginStatus(UserStatus::LOGIN_NOT_REGISTERED);
            qWarning() << "User Status :  Not Registered";
            return;
        }
        else if (msg == "User already registered" || msg.contains("alread registered"))
        {
            setLoginStatus(UserStatus::SIGNUP_ALREADY_EXIST);
            qWarning() << "User already registered";
            return;
        }
        else if (fid == "4")
        {
            setLoginStatus(UserStatus::RESET_PASSWORD_NOT_REGISTERED);
            qWarning() << "Could not sent the reset mail, user not registered";
            return;
        }

    }
    else
    {


        if (fid == "4") // Şifre yenileme mailinin cevabı...
        {
            setLoginStatus(UserStatus::RESET_PASSWORD_MAIL_SENT);
            return;
        }
        qDebug() << "no error , received message :" << msg << endl;
        QJsonObject  userObject = jsonObject["user"].toObject();

        if (!userObject.isEmpty())
        {
            qDebug() << "Parsing Array" << endl << userObject.toVariantMap();


            qDebug() << "id taken";
            QString Username = userObject["username"].toString();
            setUsername(Username);
            qDebug() << "username taken";
            QString EMail = userObject["mail"].toString();
            setEMail(EMail);
            qDebug() << "mail taken";
            setName(userObject["surname"].toString());
            qDebug() << "surname taken";
            setLastname(userObject["lastname"].toString());
            qDebug() << "lastname taken";
            setJob(userObject["job"].toString());
            qDebug() << "job taken";
            setPicture(userObject["profilepicpath"].toString());

            setAge(userObject["age"].toInt());

            setMailConfirmed(userObject["mailconfirmed"].toBool());


            qDebug()  << "Kullanıcı Bilgileri geldi " << Username  << EMail;


            setLoginStatus(UserStatus::LOGIN_LOGGED);
            setLoggedIn(true);

//            if (MailConfirmed())
//            {
//                setLoginStatus(UserStatus::LOGIN_LOGGED);
//                setLoggedIn(true);
//                stopMailConfirmation();
//            }
//            else
//            {
//                setLoginStatus(UserStatus::LOGIN_MAIL_CONFIRMATION_NEED);
//                startMailConfirmation();
//            }



        }


        mMail = jsonObject["received_mail"].toString();
        mPass = jsonObject["received_pass"].toString();

        saveToRegistery();
    }


}

void ProfileManager::saveToRegistery()
{
    QSettings settings(mPath , QSettings::NativeFormat);
    settings.setValue("ŞehirEtkinlikleri/Mail" , mMail);
    settings.setValue("ŞehirEtkinlikleri/Pass" , mPass);

    qDebug() << "Registerye kayıt yapıldı";
    settings.sync();
}
void ProfileManager::resetRegistery()
{
    QSettings settings(mPath , QSettings::NativeFormat);
    settings.setValue("ŞehirEtkinlikleri/Mail" , "");
    settings.setValue("ŞehirEtkinlikleri/Pass" , "");

    settings.sync();
}

void ProfileManager::startMailConfirmation()
{

    if (mTimer == NULL)
        return;

    if (mTimer->isActive())
        return;

    connect(mTimer , SIGNAL(timeout()) , this , SLOT(onMailConfirmationTimeout()));
    mTimer->start(8000);

}
void ProfileManager::stopMailConfirmation()
{
    if (!mTimer->isActive())
        return;

    mTimer->stop();
    mTimer = new QTimer();

}

void ProfileManager::onMailConfirmationTimeout()
{
    autoLoginOnStart();
}
