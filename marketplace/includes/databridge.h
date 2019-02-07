#ifndef __DATA_BRIDGE_H__
#define __DATA_BRIDGE_H__

#include <bits/stdc++.h>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include "itemmodel.h"

using namespace std;

namespace mp {
class DataBridge : public QObject {

    Q_OBJECT

public:
    DataBridge(ItemModel *listItems);
    ~DataBridge();

    void sendRESTQuery(const QUrl& url);
    void processItemsList(QVariantMap specMap);
    void processAuthStatus(QVariantMap specMap);
    void processSubmission(QVariantMap specMap);
    void processSystemStatus(QVariantMap specMap);

public slots:
    bool onResult(QNetworkReply* response);

private:
    QNetworkAccessManager* _net;
    ItemModel* _currlist;
};
}

#endif
