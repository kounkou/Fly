
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

#### Item submission to the store

After submitting an item on the store, the following answers are possible

```json
{
  "status": "ok",
  "type": "submission",
  "data": {
    "items": {
      "item1": { "reason": "submission failure" }
    }
  }
}
```


```json
{
  "status": "ok",
  "type": "submission",
  "data": {
    "items": {
      "item1": { "reason": "submission successful" }
    }
  }
}
```

#### System updating/maintenance

When the system is performing update of maintenance, the following json is sent.
System failure limit access to some features of the application

```json
{
  "status": "ok",
  "type": "status",
  "data": {
    "items": {
      "item1": { "reason": "maintenance in progress" }
    }
  }
}
```

#### System failure

In case of system failure, no feature is available

```json
{
  "status": "nok",
  "type": "status",
  "data": {
    "items": {
      "item1": { "reason": "system failure" }
    }
  }
}
```
