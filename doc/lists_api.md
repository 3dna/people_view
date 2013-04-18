Lists API
=========

Use the list API to manage lists and paginate through listed people.

Index Endpoint
--------------

The index endpoint shows a paginated list of custom lists
`GET /api/v1/lists`

### Parameters
* page - page number
* per_page - number of results to show in one page of results (default 10, max 100)

### Example

This request:
`GET https://foobar.nationbuilder.com/api/v1/lists`

Should get you a 200 response with results like this:

```json
{
  "page": 1,
  "total_pages": 1,
  "per_page": 10,
  "total": 3,
  "results": [
    {
      "id": 2,
      "name": "New Voters",
      "slug": "newvoters",
      "author_id": 1,
      "sort_order": "0"
    },
    {
      "id": 11,
      "name": "Famous Minnesotans",
      "slug": "minnesotans",
      "author_id": 15236,
      "sort_order": "3"
    },
    {
      "id": 9,
      "name": "Donors",
      "slug": "donors",
      "author_id": 15236,
      "sort_order": "0"
    }
  ]
}
```

People Endpoint
---------------

The people endpoint shows the people in a list
`GET /api/v1/lists/:id/people`

### Parameters
* page - page number
* per_page - number of results to show in one page of results (default 10, max 100)

### Example

This request:
`GET https://foobar.nationbuilder.com/api/v1/lists/11/people`

Should get you a 200 response and results like this:

```json
{
  "page": 1,
  "total_pages": 1,
  "per_page": 10,
  "total": 2,
  "results": [
    {
      "id": 9148,
      "first_name": "Jesse",
      "last_name": "Ventura",
      "email": "jv@mn.gov"
    },
    {
      "id": 15232,
      "first_name": "Garrison",
      "last_name": "Keillor",
      "email": "gk@mpr.org"
    }
  ]
}
```

Create Endpoint
---------------

Creates an empty list with the given attributes
`POST /api/v1/lists`

### Parameters

* list - the attributes of the list you want to create
    * name - name the list
    * slug - machine readable name of the list
    * slug - machine readable name of the list
    * author_id - The author of the list
    * sort_order - The order in which the list is sorted for retrieval
        Options: oldest_first, newest_first, priority_level, street_address, last_name

### Example

Issuing a request like this:

`POST https://foobar.nationbuilder.com/api/v1/lists`

With a post body like this:

```json
{
  "list": {
    "name": "My List",
    "slug": "mylist",
    "author_id": 17736,
    "sort_order": "oldest_first"
  }
}
```

Should make an empty list, return status code 200, and have a response body like this:

```json
{
  "list_resource": {
    "id": 12,
    "name": "My List",
    "slug": "mylist",
    "author_id": 17736,
    "sort_order": "oldest_first"
  }
}
```

Update Endpoint
---------------

Updates the list to have the given attributes
`PUT /api/v1/lists/:id`

Destroy Endpoint
----------------

Removes the indicated list from NationBuilder
`DELETE /api/v1/lists/:id`
