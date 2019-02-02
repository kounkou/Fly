#ifndef __GUI_MANAGER_H__
#define __GUI_MANAGER_H__

#include <QQmlContext>
#include <QQuickItem>
#include <QQuickView>

#include "authentifier.h"
#include "databridge.h"

namespace mp {
class GuiManager : public QObject {

    Q_OBJECT

    Q_PROPERTY(QString currentPage READ getCurrentPage WRITE setCurrentPage NOTIFY currentPageChanged)

public:
    GuiManager(QObject* parent = 0);
   ~GuiManager();

    void initInterface();
    void setCurrentPage(const QString &page);
    QString getCurrentPage() const;

    Q_INVOKABLE void requestAuthentification(const QString& username, const QString& password);

signals:
    void currentPageChanged();

private:
    QQuickItem*  _item;
    QQuickView*  _view;
    QString      _currentPage;
    Authentifier _auth;
    DataBridge   _net;
};
}

#endif
