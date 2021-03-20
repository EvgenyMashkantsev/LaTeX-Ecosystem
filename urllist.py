import sys
urllist = ''
with open(sys.argv[1], 'rt') as file:
    urllist += file.read()
urllist = urllist.splitlines()
for i in range(len(urllist)):
    urllist[i] = urllist[i].split('https://',1)[1].split('"',1)[0]
    print(urllist[i])
