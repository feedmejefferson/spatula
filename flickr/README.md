# Flickr

This folder contains a set of scripts that scrape metadata for a set of images from flickr. 

The main script runs agains a batch of images specified in an input file as `url`s laid out one per line. First run the `getmeta.sh` script with the file containing the list of urls as it's only argument:

    ./getmeta.sh image-list.txt |tee -a metadata.tsv
    
That will produce a tab delimited output file with the following columns:

1. zero padded image index number (starting at 3001 to allow room for all PEXEL images)
2. source photo page url
3. author profile page url
4. image title
5. image url 
6. author name/handle
7. license (if it's one that we can use, otherwise this column is missing and column 8 shows up in column 7)
8. tags (separated by commas)

