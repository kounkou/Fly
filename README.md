
## Json Interface description

#### Items list

The list of items to be displayed

```json
{
  "status": "ok",
  "type": "itemlist",
  "data": {
    "items": {
      "item1": { "name": "orange", "price": 5.00, "date": "2019/01/31" },
      "item2": { "name": "banana", "price": 5.00, "date": "2019/01/31" },
      "item3": { "name": "apples", "price": 5.00, "date": "2019/01/31" }
    }
  }
}
```

#### Auth statuses

Access denied response

```json
{
  "status": "ok",
  "type": "auth",
  "data": {
    "items": {
      "item1": { "reason": "access denied" }
    }
  }
}
```

Access granted response

```json
{
  "status": "ok",
  "type": "auth",
  "data": {
    "items": {
      "item1": { "reason": "access granted" }
    }
  }
}
```

registration successful

```json
{
  "status": "ok",
  "type": "auth",
  "data": {
    "items": {
      "item1": { "reason": "registration successful" }
    }
  }
}
```

registration failure

```json
{
  "status": "ok",
  "type": "auth",
  "data": {
    "items": {
      "item1": { "reason": "registration failure" }
    }
  }
}
```

