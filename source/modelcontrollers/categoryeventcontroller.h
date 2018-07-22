#ifndef CATEGORYEVENTCONTROLLER_H
#define CATEGORYEVENTCONTROLLER_H

#include "abstracteventcontroller.h"

#include <QObject>

class CategoryEventController : public AbstractEventController
{
    Q_OBJECT
public:
    explicit CategoryEventController(QObject *parent = nullptr);

signals:

public slots:
};

#endif // CATEGORYEVENTCONTROLLER_H
