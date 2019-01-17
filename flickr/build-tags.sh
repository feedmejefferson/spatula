# the following for loop will split on new lines and tabs, so we'll run the for loop twice for each line
# the first time we'll get the image number, the second time we'll get the url
IFS=$'\n'
for line in `cat metadata.tsv|grep creativecommons|cut -f 1,8`
do
  file=images/tags/${line%$'\t'*}.jpg.txt
  tags=${line#*$'\t'}

  echo $tags>$file
done

