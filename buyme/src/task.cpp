
#include "buyme/includes/task.h"

namespace bm {

//======================================================
Task::Task(QObject* parent)
    : QObject(parent)
    , _item()
    , _details() 
    , _color()
{
}

Task::Task(const QString& item, const QString& details, const QString& color)
    : _item(item)
    , _details(details)
    , _color(color)
{
}

//======================================================
QString Task::getItem() const
{
    return _item;
}

//======================================================
void Task::setItem(const QString &other)
{
    if (other != _item) {
        _item = other;
        emit itemChanged();
    }
}


//======================================================
QString Task::getDetails() const
{
    return _details;
}

//======================================================
void Task::setDetails(const QString &other)
{
    if (other != _details) {
        _details = other;
        emit detailsChanged();
    }
}

//======================================================
QString Task::getColor() const
{
    return _color;
}

//======================================================
void Task::setColor(const QString &other)
{
    if (other != _color) {
        _color = other;
        emit colorChanged();
    }
}

Task::~Task()
{
}
}
