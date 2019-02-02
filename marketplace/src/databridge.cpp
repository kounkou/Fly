#include "databridge.h"

namespace mp {
DataBridge::DataBridge()
    : _net(new QNetworkAccessManager())
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
}
