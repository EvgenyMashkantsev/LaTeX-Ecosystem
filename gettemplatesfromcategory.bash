#!/bin/bash
compat50 2> /dev/null
category=$1
category="${category##*cat/}"
mkdir "$category"
cd "$category" || exit
curl "https://www.latextemplates.com/${category}" > "${category}.html"
grep http "${category}.html" | grep --fixed-string '/template/' > 'templates-list.txt'
cp ../urllist.py urllist.py
python3 urllist.py 'templates-list.txt' > 'templates-url-list.txt'
echo "Downloading templates from category: ${category}..."
while IFS=, read -r templateurl
do
    template="${templateurl##*template/}"
    echo "Downloading template: ${template}..."
    mkdir "$template"
    cd "$template" || exit
    curl "https://www.latextemplates.com/template/${template}" > template_description.html
    grep 'href' 'template_description.html' | grep --fixed-string 'zip' | grep -i -v 'overleaf' > 'zip_href.txt'
    template2="${template%%href=\"*}"
    template3="${template2##*\"}"
    echo "${template3}" > 'zip_url_fragment.txt'
    echo "www.latextemplates.com/$(cat zip_url_fragment.txt)" > zip_url.txt
    wget -i zip_url.txt
    find . -name "*.zip" | unzip
    # rm -f -- *.zip
    # rm -f zip_url.txt
    # rm -f zip_href.txt
    # rm -f zip_url_fragment.txt
    cd ..
    echo "Downloading template ${template} finished"
done < templates-url-list.txt
# rm -f templates-list.txt
# rm -f templates-url-list.txt
echo "Downloading templates from category ${category} finished"
