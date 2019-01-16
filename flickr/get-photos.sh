# the following for loop will split on new lines and tabs, so we'll run the for loop twice for each line
# the first time we'll get the image number, the second time we'll get the url
for line in `cat metadata.tsv|grep creativecommons|cut -f 1,5`
do
  # this is an incredibly lazy way of checking if the input is one of our formatted index numbers 
  if [ ${#line} -eq 7 ]
  then 
    file=images/$line.jpg
  else curl $line >$file
  fi
done

