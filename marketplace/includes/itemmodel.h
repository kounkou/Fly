#ifndef _ITEM_MODEL_H_
#define _ITEM_MODEL_H_

#include <QAbstractListModel>
#include <QObject>
#include <QDebug>
#include <QDateTime>

namespace mp {
enum ItemsRoles
{
   ExpirationDateRole = Qt::UserRole + 1,
   NameRole           = Qt::UserRole + 2,
   PriceRole          = Qt::UserRole + 3,
   QuantityRole       = Qt::UserRole + 4
};

struct Item {
    QDateTime exp;
    QString   name;
    double    price;
    u_int     quantity;
};

class ItemModel : public QAbstractListModel
{
   Q_OBJECT

public slots:
   void addItem(Item element);

public:
   ItemModel(QObject* parent = 0);
  ~ItemModel();

   static ItemModel* getInstance();
   int    ItemsContainerSize() const;
   void   clearListOfItems();

   int    rowCount(const QModelIndex& parent = QModelIndex()) const;
   QHash<int, QByteArray> roleNames() const;

private:
   QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
   QHash<int, QByteArray> roleIds()   const;

private:
   QList<Item> _itemsContainer;
};
}

#endif
