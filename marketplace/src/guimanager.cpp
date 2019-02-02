#include "guimanager.h"

namespace mp {
GuiManager::GuiManager(QObject* parent)
    : QObject(parent)
    , _view(nullptr)
    , _item(nullptr)
    , _currentPage("")
{
}

void GuiManager::requestAuthentification(const QString& username, const QString& password)
{
    if (_auth.manual_login(username.toStdString(), password.toStdString())) {
        setCurrentPage("home.qml");
        QUrl url("http://api.waqi.info/feed/shanghai/?token=demo");
        _net.sendRESTQuery(url);
    }
}

QString GuiManager::getCurrentPage() const
{
    return _currentPage;
}

void GuiManager::setCurrentPage(const QString& currentPage)
{
    if (_currentPage != currentPage) {
        _currentPage  = currentPage;
        emit currentPageChanged();
    }
}

void GuiManager::initInterface()
{
    _view  = new QQuickView();
    _view->rootContext()->setContextProperty("backend", this);
    _view->setSource(QUrl("qrc:/main.qml"));
    _item = _view->rootObject();
    _view->setResizeMode(QQuickView::SizeRootObjectToView);

    if (!_auth.automatic_login()) {
        setCurrentPage("login.qml");
    } else {
        setCurrentPage("home.qml");
        QUrl url("http://api.waqi.info/feed/shanghai/?token=demo");
        _net.sendRESTQuery(url);
    }
}

GuiManager::~GuiManager()
{
    if (_view  != nullptr) delete _view;
    if (_item  != nullptr) delete _item;
}
}
