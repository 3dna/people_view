Webhooks API
============

Use the webhooks API to manage callback requests that you wish to receive on the following types of events:

* Person creation - "person_creation"
* Person update - "person_update"
* Person contact - "person_contact"
* Donation success - "donation_success"
* Donation update - "donation_update"
* Donation cancelation - "donation_cancellation"

Each webhook instance has a single URL and event type. A webhook sends an HTTP POST with a message body containing data about the person or donation created. The POST is sent to the URL whenever the event occurs.

Index endpoint
--------------
Returns a paginated list of the webhooks the nation has already registered with this endpoint

### Attributes

* `page` - page number
* `per_page` - the number of results to show per page (default 10, max 100)


### Example

```
GET https://foobar.nationbuilder.com/api/v1/webhooks
```

Should get you a 200 response with body like this:

```json
{
  "page": 1,
  "total_pages": 1,
  "per_page": 10,
  "total": 1,
  "results": [
    {
      "id": "51f6d14dba6d1d31c0000003",
      "url": "http://requestb.in/1hupspb1",
      "event": "person_contact"
    }
  ]
}
```

Show Endpoint
-------------
Show the details of an individual webhook, retrieved by its id

### Example

```
GET https://foobar.nationbuilder.com/api/v1/webhooks/51f6d14dba6d1d31c0000003
```

Should get you a 200 response with body like this:

```json
{
  "webhook": {
    "id": "51f6d14dba6d1d31c0000003",
    "url": "http://requestb.in/1hupspb1",
    "event": "person_contact"
  }
}
```

Create Endpoint
---------------
Use this endpoint to register a webhook to fire on the occurance of a certain event.

### Attributes

* `url` - the URL you want to have the webhook fire towards
* `event` - the event you want to observe (listed at top of page)

### Example

Issuing this request:

```
POST https://foobar.nationbuilder.com/api/v1/webhooks
```

With this body:

```json
{
  "webhook": {
    "url": "https://example.com/webhook_reception",
    "event": "person_contact"
  }
}
```

Should create the webhook, respond with 200 and a body like this:

```json
{
  "webhook": {
    "id": "4ff7600b2cf0512fc7000002",
    "url": "https://example.com/webhook_reception",
    "event": "person_contact"
  }
}
```

Destroy Endpoint
----------------
Remove a webhook to have NationBuilder stop sending events to the endpoint

### Example

```
DELETE https://foobar.nationbuilder.com/api/v1/webhooks
```

Should remove the webhook and return an empty response with status code 204.

Custom Fields
-------------
If [custom fields](http://nationbuilder.com/custom_fields) are set for your nation they will be included in the POST request body along with the other person or donation fields.

### Example
If, for example, your nation happened to care about the height of a person and you registered a custom field 'height' then it would be visible in the POST request body which gets sent to the URI defined for your registered webhook:

```json
{
  "nation_slug": "foobar",
  "payload": {
    "signup": {
      "nationbuilder_id": 85462,
      "first_name": "John",
      "last_name": "Doe",
      "full_name": "John Doe",
      "email1": "johndoe@example.com",

      ...

      "height": 72
    }
  },
  "token": null
}
```
