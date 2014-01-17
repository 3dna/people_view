Imports API
===========
Create and run imports into your nation with this API.

Create/Run Endpoint
---------------
Use this endpoint to import into your nation. This will
create and enqueue the import to run. Each import should be 50mb or less - please chunk large files and use multiple calls.

```
POST /api/v1/imports
```

### Parameters

* `type` - "[voter_file](https://github.com/3dna/people_view/blob/imports_documentation/doc/voter_file_import_fields.md)" or "[voting_history](https://github.com/3dna/people_view/blob/imports_documentation/doc/voting_history_import_fields.md)", depending on what fields you wish to import with the file
* `file` - a RFC 4648 base 64 encoded version of the contents of the file you wish to import, using the alphabet defined as "URL and Filename safe Base64 Alphabet" by the standard

Show Endpoint
-------------

Show the status of an import with this endpoint

{
  "import": {
    "id": 5,
    "type": "voter_file",
    "status": {
      "name": "queued"
    }
  }
}

Full Example
------------

In order to import the following file:

```
first_name,last_name
Byron,Anderson
```

Attributes available are for the person directly, relation fields such as those for addresses and voting histories need to be prefixed by their relations name, for example: `mailing_address.address1` and `voting_history.vh00p1`

You need to issue the following request:

```
POST https://foobar.nationbuilder.com/api/v1/imports
```

```json
{
  "import": {
    "type": "voter_file",
    "file": "Zmlyc3RfbmFtZSxsYXN0X25hbWUKQnlyb24sQW5kZXJzb24K"
  }
}
```

To get the value to put in the "file" field, you can use a library such as [this for Ruby](http://ruby-doc.org/stdlib-2.0/libdoc/base64/rdoc/Base64.html) or [this for Java](http://download.java.net/jdk8/docs/api/java/util/Base64.html) On a most Unix machines, you can use `base64 -i my_spreadsheet.csv` to base64 encode a CSV file.

Success on this endpoint will return a 200 response and a JSON response including a new "id" field and excluding the encoded file contents:

```json
{
  "import": {
    "id": 5,
    "type": "voter_file",
    "status": {
      "name": "queued"
    }
  }
}
```

This should also queue the import to run, and you can then check for updates on the status of the import with the show endpoint:

```
GET https://foobar.nationbuilder.com/api/v1/imports/5
```

```json
{
  "import": {
    "id": 5,
    "type": "voter_file",
    "status": {
      "name": "working",
      "processed": 100,
      "total": 198
    }
  }
}
```

Possible statuses you can receive are queued, working, and finished, and more information may be available for you to understand the status of your import.
