#ifndef __TASK_H__
#define __TASK_H__

#include <QObject>

namespace bm {

class Task : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString item     READ getItem    WRITE setItem       NOTIFY itemChanged)
    Q_PROPERTY(QString details  READ getDetails WRITE setDetails    NOTIFY detailsChanged)
    Q_PROPERTY(QString color    READ getColor   WRITE setColor      NOTIFY colorChanged)

public:
    /////////////////////////////////////////////////////
    /// @brief constructor
    /////////////////////////////////////////////////////
    Task(QObject *parent = 0);

    Task(const QString& item, const QString& details, const QString& color);

    /////////////////////////////////////////////////////
    /// @brief destructor
    /////////////////////////////////////////////////////
    virtual ~Task();

    void setItem(const QString& other);
    void setDetails(const QString& other);
    void setColor(const QString& other);

    QString getItem() const;
    QString getDetails() const;
    QString getColor() const;

signals:
    void itemChanged();
    void detailsChanged();
    void colorChanged();

private:
    QString _item;
    QString _details;
    QString _color;
};
}

#endif // __TASK_H__
