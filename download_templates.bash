#!/bin/bash
compat50 2> /dev/null
cd thirdparty/latextemplates.com || exit
curl https://www.latextemplates.com/ > latextemplates.html
grep http latextemplates.html | grep --fixed-string '/cat/' >categories-list.txt
cp ../../urllist.py urllist.py
cp ../../gettemplatesfromcategory.bash gettemplatesfromcategory.bash
python3 urllist.py 'categories-list.txt' > 'categories-url-list.txt'
while read line
do
    bash -x gettemplatesfromcategory.bash "${line}"
done < categories-url-list.txt
# rm -f categories-list.txt
# rm -f categories-url-list.txt
echo "Check templates download result in $(pwd)"
