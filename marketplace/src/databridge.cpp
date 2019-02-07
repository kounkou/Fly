#include "databridge.h"
#include <QJsonArray>
#include "itemmodel.h"

namespace mp {
DataBridge::DataBridge(ItemModel* listItems)
    : _net(new QNetworkAccessManager())
    , _currlist(listItems)
{
    QObject::connect(_net, SIGNAL(finished(QNetworkReply*)), this, SLOT(onResult(QNetworkReply*)));
}

DataBridge::~DataBridge()
{
    if (_net != nullptr)
        delete _net;
    _net = nullptr;
}

void DataBridge::sendRESTQuery(const QUrl& url)
{
    cout << "sending request" << endl;
    QNetworkRequest request(url);
    _net->get(request);
}

void DataBridge::processItemsList(QVariantMap specMap)
{
    cout << "number of elements : " << specMap.size() << endl;
    for (auto e : specMap) {
        cout << "name  : " << (e.toMap())["name"]  .toString().toStdString() << endl;
        cout << "price : " << (e.toMap())["price"] .toString().toStdString() << endl;
        cout << "date  : " << (e.toMap())["date"]  .toString().toStdString() << endl;

        Item it;
        it.name = (e.toMap())["name"]  .toString();
        _currlist->addItem(it);

        cout << endl;
    }
}

void DataBridge::processAuthStatus(QVariantMap specMap)
{
    cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
}

void DataBridge::processSubmission(QVariantMap specMap)
{
    cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
}

void DataBridge::processSystemStatus(QVariantMap specMap)
{
    cout << (specMap["item1"].toMap())["reason"].toString().toStdString() << endl;
}

bool DataBridge::onResult(QNetworkReply* response)
{
    cout << "receiving data" << endl;
    if (response->error() != QNetworkReply::NoError) {
        cerr << "error reading data" << endl;
        return false;
    }

    QString data = static_cast<QString>(response->readAll());
    cout << data.toStdString() << endl;
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());

    if (doc.isNull()) {
        qDebug() << "Invalid json document";
        return false;
    } else if (doc.isObject()) {
        QJsonObject jsonObj = doc.object();
        qDebug() << "status : " << jsonObj.value(QString("status"));

        if (jsonObj.value(QString("status"))[0] != "ok") {
            qDebug() << "couldn't find valid data";
            return false;
        }

        qDebug() << "processing valid data";

        if (jsonObj.value(QString("type"))[0] == "status") {
            qDebug() << "processing status";
            auto t = jsonObj.value(QString("data"))[0].toObject().toVariantMap()["items"].toMap();
            for (auto e : t) qDebug() << e;
            processSystemStatus(t);
        } else if (jsonObj.value(QString("type"))[0] == "submission") {
            qDebug() << "processing submission";
            auto t = jsonObj.value(QString("data"))[0].toObject().toVariantMap()["items"].toMap();
            for (auto e : t) qDebug() << e;
            processSubmission(t);
        } else if (jsonObj.value(QString("type"))[0] == "auth") {
            qDebug() << "processing auth";
            auto t = jsonObj.value(QString("data"))[0].toObject().toVariantMap()["items"].toMap();
            for (auto e : t) qDebug() << e;
            processAuthStatus(t);
        } else if (jsonObj.value(QString("type"))[0] == "itemlist") {
            qDebug() << "processing itemlist";
            auto t = jsonObj.value(QString("data"))[0].toObject().toVariantMap()["items"].toMap();
            for (auto e : t) qDebug() << e;
            processItemsList(t);
        }
    }
    return true;
}
}
