# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://v-play.net/custom-code-reload-app/
#CONFIG += v-play-live

# configure the bundle identifier for iOS
PRODUCT_IDENTIFIER = tr.com.tusco.mobile.EventApp

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "../../assets/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    source/maincontroller.cpp \
    source/data/eventcontainer.cpp \
    source/data/placecontainer.cpp \
    source/communication/requestmanager.cpp \
    source/communication/restmanager.cpp \
    source/communication/networkmessageparser.cpp \
    source/modelcontrollers/abstracteventcontroller.cpp \
    source/modelcontrollers/abstractplacescontroller.cpp \
    source/modelcontrollers/completeplacescontroller.cpp \
    source/modelcontrollers/categoryeventcontroller.cpp \
    source/modelcontrollers/toprecenteventscontroller.cpp \
    source/auth/profilemanager.cpp \
    source/auth/userinfocontainer.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
    
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

HEADERS += \
    source/maincontroller.h \
    source/data/eventcontainer.h \
    source/data/placecontainer.h \
    source/communication/requestmanager.h \
    source/communication/restmanager.h \
    source/communication/networkmessageparser.h \
    source/modelcontrollers/abstracteventcontroller.h \
    source/modelcontrollers/abstractplacescontroller.h \
    source/modelcontrollers/completeplacescontroller.h \
    source/modelcontrollers/categoryeventcontroller.h \
    source/modelcontrollers/toprecenteventscontroller.h \
    source/auth/profilemanager.h \
    source/auth/seutils.h \
    source/auth/userinfocontainer.h

DISTFILES += \
    qml/MobileApp.qml \
    assets/images/design/logo/Logo Yeni_copy.png \
    qml/IAppProperties.qml \
    qml/items/delegates/EventListItemDelegate.qml \
    qml/items/decoration/icons/LıstItemIcon.qml \
    qml/pages/common/CustomAppPage.qml \
    qml/pages/common/CustomListPage.qml \
    qml/items/delegates/PlaceListItemDelegate.qml \
    qml/items/decoration/spaces/SpaceSelectedEventPageContents.qml \
    qml/items/map/GoogleStaticMapItem.qml \
    qml/pages/auth/PageRequestAuthantication.qml \
    qml/pages/main/PageProfileLoader.qml \
    qml/pages/auth/PageProfile.qml \
    qml/pages/auth/PageFavourites.qml

build_online_docs: {
    QMAKE_DOCS_TARGETDIR = qtota
    QMAKE_DOCS = $$PWD/config/qtota-online.qdocconf
} else {
    QMAKE_DOCS = $$PWD/config/qtota.qdocconf
}

QMAKE_DOCS_OUTPUTDIR = $$OUT_PWD/qtota
