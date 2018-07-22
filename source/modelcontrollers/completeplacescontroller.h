#ifndef COMPLETEPLACESCONTROLLER_H
#define COMPLETEPLACESCONTROLLER_H

#include "abstractplacescontroller.h"

#include <QObject>

class CompletePlacesController : public AbstractPlacesController
{
public:
    explicit CompletePlacesController(QObject *parent = nullptr);
};

#endif // COMPLETEPLACESCONTROLLER_H
