#!/bin/bash
compat50 2> /dev/null
cd thirdparty/latextemplates.com || exit
curl https://www.latextemplates.com/ > latextemplates.html
grep http latextemplates.html | grep --fixed-string '/cat/' >categories-list.txt
python3 urllist.py categories-list.txt > categories-url-list.txt
while IFS=, read -r line
do
    bash gettemplatesfromcategory.bash "${line}" &
    rm -f templates-list.txt
    rm -f templates-url-list.txt
    cd ..
done < categories-url-list.txt
rm -f categories-list.txt
rm -f categories-url-list.txt
