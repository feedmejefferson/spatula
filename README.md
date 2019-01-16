# Spatula

A simple project for scraping public domain or creative common licensed food images and metadata from various websites.

## Usage

For now, each site will have it's own folder of scripts. Checkout the readme file in the site specific folder for details on how to run the scripts.

## Vision

Eventually this will probably turn into a light weight javascript library (likely written in typescript). 

So many sites have moved their logic from the server side (dynamically serving fully resolved html) to the client side (serving a bit of html with a lot of javascript callbacks that have to be executed before the page is fully resolved). This is making it continually harder to scrape meaningful information with a simple combination of `curl` and `sed`. 

For now I'm just going to stick with those simple command line bash scripts that are only guaranteed to work on my mac (because they still suffice), but longer term I think there will be quite a few benefits to a typescript/javascript library:

* reachability -- as mentioned, running a javascript engine will allow the tool to gather details that curl alone can't uncover
* managebility -- define a standard interface that's expected (what details do we need to scrape), then provide site specific implementations (where do we get those details on a site by site basis)
* plugability -- rather than me having to run the script on my mac for a list of urls, we'd be able to plug it in as an administrative page function on the site itself so that administrative users can run the logic themselves
* output -- right now I'm just saving the metadata into pipe/tab/comman separated files. Javascript will enable richer formatting (i.e. json) and alternative storage media (i.e. databases) that can integrate directly with the site/app without additional processing steps

