
#include "buyme/includes/buyme.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>

namespace bm {

//======================================================
BuyMe::BuyMe(QObject* parent)
    : QObject(parent)
    , _view(nullptr)
    , _item(nullptr)
    , _task(nullptr)
    , _taskId()
{
}

//======================================================
void BuyMe::initInterface()
{
    _view  = new QQuickView();
    _view->rootContext()->setContextProperty("backend", this);
    _view->setSource(QUrl("qrc:/main.qml"));
    _item = _view->rootObject();
    _view->setResizeMode(QQuickView::SizeRootObjectToView);
}

//======================================================
BuyMe::~BuyMe()
{
    if (_view  != nullptr) delete _view;
    if (_item  != nullptr) delete _item;
}
}
