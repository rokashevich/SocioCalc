QT += qml quick
TARGET = sociocalc
!android: !ios: !blackberry: qtHaveModule(widgets): QT += widgets

SOURCES += \
    src/main.cpp

HEADERS += \
		src/qtquickcontrolsapplication.h

OTHER_FILES +=

RESOURCES += \
    resources.qrc
