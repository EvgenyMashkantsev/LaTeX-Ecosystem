RUSSIANDOCNAME=TemplateRussian
ENGLISHDOCNAME=TemplateEnglish

all: clean report

.PHONY: clean

report:
	bash prepare_to_compile.bash
	-pdflatex $(RUSSIANDOCNAME).tex
	-bibtex $(RUSSIANDOCNAME).aux
	-pdflatex $(RUSSIANDOCNAME).tex
	pdflatex $(RUSSIANDOCNAME).tex
	-pdflatex $(ENGLISHDOCNAME).tex
	-bibtex $(ENGLISHDOCNAME).aux
	-pdflatex $(ENGLISHDOCNAME).tex
	pdflatex $(ENGLISHDOCNAME).tex
	@echo Compiling to pdf finished!

clean:
	-rm *.blg *.bbl *.aux *.log *.toc *.dvi *.out *.bcf
