# the following for loop will split on new lines and tabs, so we'll run the for loop twice for each line
# the first time we'll get the image number, the second time we'll get the url
let i=0
IFS=$'\n\t'
for line in `cat metadata.tsv|grep creativecommons|cut -f 1-4,6,7`
do
  let i+=1
  case "$i" in
    1)
      file=images/attributions/$line.jpg.txt
      ;;
    2) 
      photo_url=$line
      ;;
    3)
      profile_url=$line
      ;;
    4) 
      title=$line
      ;;
    5)
      author=$line
      ;;
    6)
      license_url=$line
      license=$line
      if [[ $license =~ .*public.* ]]
      then
        license="public domain"
      else
        license=${license#*/licenses/}
        license=${license//\// }
        license="CC ${license% }"
        license=$(echo "$license" | tr '[:lower:]' '[:upper:]')
      fi
      echo -n '"'"<a href='$photo_url'>$title</a>"'"' >$file
      echo -n " by <a href='$profile_url'>$author</a>" >>$file
      echo    " is licenced under <a href='$license_url'>$license</a>." >>$file
      let i=0
      ;;
  esac
done

