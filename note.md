# Design Note

## `bk:get_page_index`

#### Possible values of `system-property('xsl:vendor')`

* `"Transformiix"` ... Firefox
* `"libxslt"` ... Chrome, Vivaldi, Safari
* `"Microsoft"` ... Edge, IE

#### The way to get page index

* Except on Firefox, `bk:_get_page_index_by_gid` does not return correct value because `generate-id(/)` is not equal to `generate-id(document($filepath,/))`.
* On all browsers, `bk:_get_page_index_by_gid` does not return correct value because `generateid` function returns different value by an url with anchor from by same url without anchor.

So `bk:get_page_index` try to identify a page by a concatinated string of all titles in a page with `bk:_get_page_index_by_titles`.

