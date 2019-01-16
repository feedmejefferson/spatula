/meta name="title"/{
  s/^.*content="//
  s/".*$//
  p
}
/^.*meta property="og:image" content="/{
  s///
  s/\(_.\)\{0,1\}.jpg.*$/_c.jpg/
  p
}
/data-track="attributionNameClick">/{
  /owner-name-with-by/d
  s/^.*data-track="attributionNameClick">//
  s/<.*$//
  p
}
/^.*<a href="https:..creativecommons.org.licenses/{
  s~~https://creativecommons.org/licenses~
  s/".*$//
  /by-nc/d
  p
}
/^.*<a href="https:..creativecommons.org.publicdomain/{
  s~~https://creativecommons.org/publicdomain~
  s/".*$//
  p
}
# we want to push tags to the end because they may not exist
# but they show up earlier that other values in the html, so we'll
# save them in the hold space until the end of the file
/meta name="keywords"/{
  s/^.*content="//
  s/".*$//
  s/, /,/g
  h
}
# when we get to the last line, swap with the hold space and print
${
  x
  p
}
