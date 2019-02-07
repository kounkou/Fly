
## Json Interface description

The application uses REST API to manage the communication between the client app
and the server. The following REST responses show the expected data to be
received and processed by the client application.
The application show cases 4 different types of REST responses :

- itemlist 
- auth
- submission
- status



#### 1. Items list

The list of items to be displayed

```json
{
  "status": [ "ok"],
  "type": [ "itemlist" ],
  "data": [ {
    "items": {
      "item1": { "name": "orange", "price": 5.00, "date": "2019/01/31" },
      "item2": { "name": "banana", "price": 9.80, "date": "2019/01/30" },
      "item3": { "name": "apple",  "price": 7.10, "date": "2019/02/03" }
    } 
  } ]
}
```

#### 2. Auth statuses

Access denied response

```json
{
  "status": [ "ok" ],
  "type": [ "auth" ],
  "data": [ {
    "items": {
      "item1": { "reason": "access denied" }
    }
  } ]
}
```

Access granted response

```json
{
  "status": [ "ok" ],
  "type": [ "auth" ],
  "data": [ {
    "items": {
      "item1": { "reason": "access granted" }
    }
  } ]
}
```

registration successful

```json
{
  "status": [ "ok" ],
  "type": [ "auth" ],
  "data": [ {
    "items": {
      "item1": { "reason": "registration successful" }
    }
  } ]
}
```

registration failure

```json
{
  "status": [ "ok" ],
  "type": [ "auth" ],
  "data": [ {
    "items": {
      "item1": { "reason": "registration failure" }
    }
  } ]
}
```

#### 3. Item submission to the store

After submitting an item on the store, the following answers are possible

```json
{
  "status": [ "ok" ],
  "type": [ "submission" ],
  "data": [ {
    "items": {
      "item1": { "reason": "submission failure" }
    }
  } ]
}
```


```json
{
  "status": [ "ok" ],
  "type": [ "submission" ],
  "data": [ {
    "items": {
      "item1": { "reason": "submission successful" }
    }
  } ]
}
```

#### 4. System updating/maintenance (status)

When the system is performing update of maintenance, the following json is sent.
System failure limit access to some features of the application

```json
{
  "status": [ "ok" ],
  "type": [ "status" ],
  "data": [ {
    "items": {
      "item1": { "reason": "maintenance in progress" }
    }
  } ]
}
```

In case of system failure, no feature is available

```json
{
  "status": [ "nok" ],
  "type": [ "status" ],
  "data": [ {
    "items": {
      "item1": { "reason": "system failure" }
    }
  } ]
}
```
