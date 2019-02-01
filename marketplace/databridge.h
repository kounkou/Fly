#ifndef __DATABASE_BRIDGE_H__
#define __DATABASE_BRIDGE_H__

#include <bits/stdc++.h>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

using namespace std;

namespace mp {
class DataBridge : public QObject {

    Q_OBJECT

public:
    DataBridge()
        : _net(new QNetworkAccessManager())
    {
        QObject::connect(_net, SIGNAL(finished(QNetworkReply*)), this, SLOT(onResult(QNetworkReply*)));

        QUrl url("http://api.waqi.info/feed/shanghai/?token=demo");
        sendRESTQuery(url);
    }

    ~DataBridge()
    {
        if (_net != nullptr)
            delete _net;
        _net = nullptr;
    }

    void sendRESTQuery(const QUrl& url)
    {
        cout << "sending request" << endl;
        QNetworkRequest request(url);
        _net->get(request);
    }

    void processItemsList(QVariantMap specMap)
    {
        cout << "number of elements : " << specMap.size() << endl;
        for (auto e : specMap) {
            cout << "name  : " << (e.toMap())["name"]  .toString().toStdString() << endl;
            cout << "price : " << (e.toMap())["price"] .toString().toStdString() << endl;
            cout << "date  : " << (e.toMap())["date"]  .toString().toStdString() << endl;
            cout << endl;
        }
    }

    void processAuthStatus(QVariantMap specMap)
    {
        cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
    }

    void processSubmission(QVariantMap specMap)
    {
        cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
    }

    void processSystemStatus(QVariantMap specMap)
    {
        cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
    }

public slots:

    bool onResult(QNetworkReply* response)
    {
        cout << "receiving data" << endl;
        if (response->error() != QNetworkReply::NoError) {
            cerr << "error reading data" << endl;
            return false;
        }

        QString data = static_cast<QString>(response->readAll());
        // cout << data.toStdString() << endl;

        data = QString("{\"status\": \"ok\",\"type\": \"itemlist\",\"data\": {\"items\": "
                            "{\"item1\": { \"name\": \"orange\", \"price\": 5.00, \"date\": \"2019/01/31\" },"
                             "\"item2\": { \"name\": \"banana\", \"price\": 9.80, \"date\": \"2019/01/30\" },"
                             "\"item3\": { \"name\": \"apple\",  \"price\": 7.10, \"date\": \"2019/02/03\" }}}}");

        QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());

        if (doc.isNull()) {
            qDebug() << "Invalid json document";
            return false;
        } else if (doc.isObject()) {
            QJsonObject jsonObj = doc.object();
            qDebug() << "status : " << jsonObj.value(QString("status"));

            if (jsonObj.value(QString("status")) != "ok") {
                qDebug() << "couldn't find valid data";
                return false;
            }

            QVariantMap mainMap = jsonObj.toVariantMap();
            QVariantMap dataMap = mainMap["data"]  .toMap();
            QVariantMap specMap = dataMap["items"] .toMap();

            if (jsonObj.value(QString("type")) == "status") {
                processSystemStatus(specMap);
            } else if (jsonObj.value(QString("type")) == "submission") {
                processSubmission(specMap);
            } else if (jsonObj.value(QString("type")) == "auth") {
                processAuthStatus(specMap);
            } else if (jsonObj.value(QString("type")) == "itemlist") {
                processItemsList(specMap);
            }
        }
        return true;
    }

private:
    QNetworkAccessManager* _net;
};
}

#endif
