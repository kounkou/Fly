
#include "itemmodel.h"

namespace mp {

ItemModel::ItemModel(QObject *parent)
    : QAbstractListModel(parent)
    , _itemsContainer(QList<Item>())
{
}

/*
 * clearing list of Items implies
 * more than just removing the elements for the container.
 * In reality, this implies also sending
 * signals to the view (qml)
 * This is done using the bening and EndRemovingRows
 */
void ItemModel::clearListOfItems()
{
    beginRemoveRows(QModelIndex(), 0, rowCount());
    for (int row = 0; row < rowCount(); ++row) {
        _itemsContainer.removeAt(row);
        _itemsContainer.erase(_itemsContainer.begin(),
                              _itemsContainer.end());
    }
    endRemoveRows();
}

/*
 * addItem will add a Item inside the container
 * This function is made with insert
 * instead and in place of push_back
 * Using insert will garanty the object doesn't call
 * the copy constructor again.
 */
void ItemModel::addItem(Item element)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    _itemsContainer.insert(0, element);
    qDebug() << "new Items size : " << _itemsContainer.count();
    endInsertRows();
}

int ItemModel::ItemsContainerSize() const
{
    return _itemsContainer.count();
}

QHash<int, QByteArray> ItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[ExpirationDateRole] = "expirationDate";
    roles[NameRole]           = "name";
    roles[PriceRole]          = "price";
    roles[QuantityRole]       = "quantity";

    return roles;
}

int ItemModel::rowCount(const QModelIndex &) const
{
    return _itemsContainer.count();
}

QVariant ItemModel::data(const QModelIndex &index, int role) const
{
    const Item& Item = _itemsContainer[index.row()];

    if (index.row() < 0 || index.row() > _itemsContainer.count()) {
        return QVariant();
    }

    if (role == NameRole)           { return Item.name; }
    if (role == ExpirationDateRole) { return Item.exp.toString(); }
    if (role == PriceRole)          { return Item.price; }
    if (role == QuantityRole)       { return Item.quantity; }

    return QVariant();
}

ItemModel::~ItemModel()
{
}
}
