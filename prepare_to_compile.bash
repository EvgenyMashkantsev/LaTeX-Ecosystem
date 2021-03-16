#!/bin/bash
compat50 2> /dev/null
beginfolder=$(pwd)
echo "begin folder is $beginfolder"
echo 'Making reserve copy of tex and pdf file...'
cp ExistentialRiskShieldsApproachEnglish.tex ExistentialRiskShieldsApproachEnglish.tex.old
cp ExistentialRiskShieldsApproachEnglish.pdf ExistentialRiskShieldsApproachEnglish.pdf.old
cp ExistentialRiskShieldsApproachRussian.tex ExistentialRiskShieldsApproachRussian.tex.old
cp ExistentialRiskShieldsApproachRussian.pdf ExistentialRiskShieldsApproachRussian.pdf.old
echo 'Finding and running programs...'
find . -iname "main.py" -execdir sh -c 'echo "Found python script. Executing...";python3 main.py | tee program.log' \;
find . -iname "main.c" -execdir sh -c 'echo "Found C program. Compiling and executing...";ccomp -Wall -Werror -Wfatal-errors -o main.ELF main.c;./main.ELF | tee program.log' \;
find . -iname '*.dot' -execdir sh -c 'echo "Found directed graph file. Preparing...";filename="{}";dot -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.gv' -execdir sh -c 'echo "Found directed graph file. Preparing...";filename="{}";dot -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.neato' -execdir sh -c 'echo "Found undirected graph file. Preparing...";filename="{}";neato -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.fdp' -execdir sh -c 'echo "Found undirected graph file. Preparing...";filename="{}";fdp -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.sfdp' -execdir sh -c 'echo "Found large undirected graph file. Preparing...";filename="{}";sfdp -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.twopi' -execdir sh -c 'echo "Found graph file. Preparing...";filename="{}";twopi -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.circo' -execdir sh -c 'echo "Found circular layout graph file. Preparing...";filename="{}";circo -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.osage' -execdir sh -c 'echo "Found cluster graph file. Preparing...";filename="{}";osage -Tpng "{}" -Gdpi=300 >"${filename%.*}.png"' \;
find . -iname '*.plantuml' -execdir sh -c 'echo "Found PlantUML description file. Preparing...";filename="{}";echo "filename is {}";java -Xmx1024m -Djava.awt.headless=true -DPLANTUML_LIMIT_SIZE=8192 -jar plantuml.jar -verbose {}' \;
find . -iname '*.puml' -execdir sh -c 'echo "Found PlantUML description file. Preparing...";filename="{}";echo "filename is {}";java -Xmx1024m -Djava.awt.headless=true -DPLANTUML_LIMIT_SIZE=8192 -jar plantuml.jar -verbose {}' \;
wait
cd $beginfolder
