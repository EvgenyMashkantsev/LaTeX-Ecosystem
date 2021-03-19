#!/bin/bash
category=$1
category="${category##*cat/}"
mkdir "$category"
cd "$category" || exit
curl "https://www.latextemplates.com/${category}" > "${category}.html"
grep http "${category}.html" | grep --fixed-string '/template/' >templates-list.txt
python3 urllist.py templates-list.txt > thirdparty/latextemplates/templates-url-list.txt
while IFS=, read -r templateurl
do
    template="${templateurl##*cat/}"
    mkdir "$template"
    cd "$template" || exit
    curl $ > template_description.html
    grep http latextemplates.html | grep --fixed-string '/zip/' | grep -v -i overleaf > zip_url.txt
    wget -i zip_url.txt
    find . -name "*.zip" | unzip
    rm -f -- *.zip
    rm -f zip_url.txt
    cd ..
done < templates-url-list.txt