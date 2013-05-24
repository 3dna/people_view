Events API
==========

Index Endpoint
--------------
Use this endpoint to list the events stored in the nation

GET /api/v1/sites/:site_slug/pages/events

### Attributes
    * page - page number
    * per_page - number of results to show per page
    * tags - tags present on events returned
    * starting - earliest start time for events returned (inclusive)
    * until - latest end time for events returned (exclusive)

### Example

```
GET https://foobar.nationbuilder.com/api/v1/sites/foobar/pages/events?starting=2013-03-01
```

```json
{
  "page": 1,
  "total_pages": 1,
  "per_page": 10,
  "total": 2,
  "results": [
    {
      "id": 5,
      "slug": "the_event_of_the_year",
      "status": "expired",
      "site_slug": "foobar",
      "name": "The event of the year!",
      "headline": "The event of the year!",
      "title": "The event of the year!",
      "excerpt": null,
      "author_id": 65,
      "published_at": "2013-05-07T14:14:07-07:00",
      "external_id": null,
      "intro": "",
      "calendar_id": 1,
      "contact": {
        "name": "Event Creator",
        "phone": null,
        "show_phone": true,
        "email": "foobarevents@mailinator.com",
        "show_email": true
      },
      "start_time": "2013-05-08T18:00:00-07:00",
      "end_time": "2013-05-08T21:00:00-07:00",
      "rsvp_form": {
        "phone": "hidden",
        "address": "hidden",
        "allow_guests": true,
        "gather_volunteers": false
      },
      "capacity": 15,
      "show_guests": true,
      "venue": {
        "name": "",
        "address": {
          "address1": "",
          "address2": "",
          "city": "Pasadena",
          "state": "CA",
          "country_code": "US",
          "zip": "91101",
          "lat": "34.1427587",
          "lng": "-118.1386005"
        }
      },
      "autoresponse": {
        "broadcaster_id": null,
        "subject": null,
        "body": null
      }
    },
    {
      "id": 3,
      "slug": "event",
      "status": "expired",
      "site_slug": "foobar",
      "name": "event",
      "headline": "event",
      "title": "event - Foobar Softwares",
      "excerpt": null,
      "author_id": 9,
      "published_at": "2013-02-28T20:43:36-08:00",
      "external_id": null,
      "intro": null,
      "calendar_id": null,
      "contact": {
        "name": null,
        "phone": null,
        "show_phone": true,
        "email": null,
        "show_email": true
      },
      "start_time": "2013-03-01T18:00:00-08:00",
      "end_time": "2013-03-01T21:00:00-08:00",
      "rsvp_form": {
        "phone": "hidden",
        "address": "hidden",
        "allow_guests": true,
        "gather_volunteers": false
      },
      "capacity": 0,
      "show_guests": true,
      "venue": {
        "name": null,
        "address": null
      },
      "autoresponse": {
        "broadcaster_id": 2,
        "subject": "RSVP confirmation for event",
        "body": null
      }
    }
  ]
}
```


Create Endpoint
---------------
Use this endpoint to create an event

POST /api/v1/sites/:site_slug/pages/events

### Parameters

* page parameters
* calendar_id - id of the calendar on which this event should appear
* intro - introductory information about the event
* start_at - starting time of the event
* end_at - ending time of the event
* contact - details about the point of contact for the event
    * person_id - id of the contact
    * contact_phone - the contact's phone number for the purposes of the event
    * show_phone - whether to publically show that phone number
    * contact_email - the contact's email address for the purposes of the event
    * show_email - whether to publically show that email address
* rsvp_form - details about the form users will fill out to (optional, leave out and the event will not accept RSVPs)
    * phone - whether to show the phone input field on the RSVP form.  Possible values are "optional", "required", "hidden"
    * address - whether to show the address input field on the RSVP form.  Possible values are "optional", "required", "hidden"
    * allow_guests - whether to allow the RSVPing person to bring more guests.  Provide true or false.
    * gather_volunteers - whether to ask people if they wish to volunteer on the RSVP form. Provide true or false. Not available for Enterprise and Small Business editions.
* show_guests - whether to show the guest list publically
* capacity - maximum event attendees
* venue - details about the location of the event
    * name - name of the venue (Staples Center, for example)
    * address - address information
* autoresponse - the details of the email to send to a person after they RSVP (optional, leave off to not send RSVP confirmation email)
    * broadcaster_id - id of the broadcaster on whose behalf the response will be sent
    * subject - subject line of autoresponse email
    * body - body of the autoresponse email
* tickets - simple ticket price information - Using NationBuilder as your payment processor for events created through the API is not yet supported.
    * price - price of the tickets without currency marking
    * currency - currency the price will display in ex. "USD"
    * url - url to link to for purchasing tickets

### Example

```
POST https://foobar.nationbuilder.com/api/v1/sites/foobar/pages/events
```

```json
{
  "event": {
    "name": "Fasting Day",
    "intro": "Take the 24hr nofoodchallenge!!!",
    "time_zone": "-07:00",
    "start_at": "2013-05-08T17:00:00-07:00",
    "end_at": "2013-05-08T19:00:00-07:00",
    "contact": {
      "name": "Byron Anderson",
      "contact_phone": "1234567890",
      "show_phone": true,
      "contact_email": "contact@venue.com",
      "show_email": true
    },
    "calendar_id": 3,
    "rsvp_form": {
      "phone": "optional",
      "address": "required",
      "allow_guests": true,
      "gather_volunteers": true
    },
    "show_guests": true,
    "capacity": 80,
    "venue": {
      "name": "Ralphs Parking Lot",
      "address": {
        "address1": "123 Foo St",
        "city": "Pasadena",
        "state": "CA"
      }
    }
  }
}
```

Update Endpoint
---------------
Use the update endpoint to change the details of a pre-existing event page

Show Endpoint
-------------

Get the details of a specific event.

Delete Endpoint
---------------

host list/add/remove
GET /api/v1/sites/foobar/pages/events/1/hosts
POST /api/v1/sites/foobar/pages/events/1/hosts
DELETE /api/v1/sites/foobar/pages/events/1/hosts

PIECES:

event creation, updating

RSVP Creation Endpoint
----------------------
Use this endpoint to create an RSVP for an event

POST /api/v1/sites/foobar/pages/events/1/rsvps

```json
{
  "rsvp": {
    "person_id": 123,
    "guests_count": 2,
    "volunteer": true,
    "private": true,
    "tickets_count": 0,
    "canceled": false,
    "attended": true
  }
}
```

RSVP Update Endpoint
--------------------

RSVP Index Endpoint
-------------------
Use this endpoint to list the RSVPs for an event

GET /api/v1/sites/foobar/pages/events/1/rsvps
