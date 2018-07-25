#ifndef TOPRECENTEVENTSCONTROLLER_H
#define TOPRECENTEVENTSCONTROLLER_H

#include "abstracteventcontroller.h"

#include <QObject>


class TopRecentEventsController : public AbstractEventController
{
    Q_OBJECT
public:
    explicit TopRecentEventsController(QObject *parent = nullptr);

signals:

public slots:
};

#endif // TOPRECENTEVENTSCONTROLLER_H
