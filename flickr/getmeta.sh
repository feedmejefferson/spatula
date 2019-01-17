#curl -L $2 |sed -n '/^<title>/{s/<[^>]*>//g;p;};/^<meta name="keywords"/{s/"[^"]*$//;s/^.*"//p;}'|tr "\n" "|" >meta/$1.jpg.txt
if [[ $# -eq 0 ]] ; then
    echo 'must provide location of file with urls as arg 1'
    exit 0
fi
let i=3120
for url in `cat $1`
do 
  let i+=1
  printf -v j '%07d' $i;
  photo_url=${url%/in/*}
  profile_url=${photo_url%/*}
  (
    echo $j
    echo $photo_url
    echo $profile_url
    curl $url|sed -nf flickr.sed
  )|tr "\n" "\t"
  printf '\n'
done
#|grep creativecommons
## not sure why grepping the whole thing removes all lines
