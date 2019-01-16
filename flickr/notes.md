# importing images 

Karen did some due dilligence and searched through various images on flickr that were CC2 licenced meaning that we can use them as long as we provide attribution with a link when we use them. 

Now I just need to put together a script to simplify (automate) the process of onboarding those images and all of their metadata. At this point we need to check and pull in a few things:

* verify that the image is indeed licenced for our reuse
* grab any tags associated with the image
* grab metadata for attribution
    * link to page
    * title of image
    * link to author page
    * name of author

## thoughts

The flickr url seems to point start with the authors page, followed by the photo id, and then optionally followed by some additional `in` information describing where the referring link to the photo came from (i.e. it was found in a specific search list)

This means we may be able to extract the author name, link to their profile page, and link to the photo source page all directly from the url without ever even parsing the page.

...and no. Some users have profile ids like `12345678@N01`. It looks like we can get the user name from the title of their profile page though. 

Similarly, the image title seems to be in the image page's title tag. Both profile and photo page titles start with what we want followed by a vertical bar and then more stuff that we don't want. 

ugh, tags are going to be a bit of an issue -- they don't show up in the raw html pages, but rather require some javascript magic call backs. I might actually know just enough javascript at this point to start using node to do more sophisticated scraping. Time to give it a try...

hmm, maybe that's not actually true about tags. It looks like there are some human created tags and then there are some machine AI style produced tags. The original set show up in the meta data under the keywords meta tag.

```
<meta name="title" content="At the pub"  data-dynamic="true">        
<meta name="keywords" content="london, another, tag"  data-dynamic="true">
...
<meta property="og:image" content="https://c1.staticflickr.com/9/8001/7102532555_9e869ca219_b.jpg"  data-dynamic="true">
...
   ... data-track="attributionNameClick">USER NAME</a>
                <a href="https://creativecommons.org/licenses/by/2.0/" class="photo-license-url" rel="license cc:license" target="_newtab">
``` 

alternatively, it looks like most of the information may be in a json map sitting in a line that starts with `modelExport:`

```
      modelExport: {legend ... "z":{"displayUrl":"\/\/farm9.staticflickr.com\/8001\/7102532555_9e869ca219_z.jpg", "width": ... "username":"h2theE","realname": ... "authorName":"h2theE" ...
```

on second thought, the json object could be a bit of a pain as all of the strings are url or escaped with backslashes.

And the license itself should show up in the creative commons url such as

    https://creativecommons.org/licenses/by/2.0/
    
If it was a share alike license it would have `by-sa` instead of just `by` in the path

And finally, it looks like the image that we care about is simply the version from the static image farm that ends in `_z` (640 x 480) or `_c` (800 x 600). The ones that we originally sourced from PEXELS all look like they were 350 height with widths that varied (so lower resolution for portraits). 