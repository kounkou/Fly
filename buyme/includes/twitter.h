#include <QtCore>
#include <QtNetwork>
#include <QtNetworkAuth>

namespace bm {
class Twitter : public QOAuth1
{
    Q_OBJECT

public:
    Twitter(QObject *parent = nullptr);
    Twitter(const QPair<QString, QString> &clientCredentials, QObject *parent = nullptr);
    Twitter(const QString &screenName,
            const QPair<QString, QString> &clientCredentials,
            QObject *parent = nullptr);

signals:
    void authenticated();

private:
    Q_DISABLE_COPY(Twitter)

    QOAuthHttpServerReplyHandler *replyHandler = nullptr;
};
}
