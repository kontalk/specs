# File information in Out of Band Data ([XEP-0066](http://xmpp.org/extensions/xep-0066.html))

As a hint, we added three attributes to the url tag:

  * **type** - supposed MIME type of data
  * **length** - supposed length of data in bytes
  * **encrypted** - flag indicating that content is encrypted


**NOTE**: this is just a hint to avoid doing a request to the server.
