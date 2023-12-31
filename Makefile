COURSE=stats720

all: docs/assignments/README.html docs/index.html docs/${COURSE}_bib.html docs/software/README.html docs/honesty.html docs/R_style.html docs/books.html docs/assignments/data.html
## allnotes docs/assignments/midterm-topics.html

## see also: mk_all
## distinguish from directories (case-sensitive)
Notes:
	./mkallnotes

Assignments:
	./mkallassignments

## these must come FIRST so we don't trash .md files by moving
## them to docs!
## FIXME: rebuilds html files in docs unnecessarily
docs/%: %
	mkdir -p docs
	mv $< docs

docs/notes/%: notes/%
	mkdir -p docs/notes
	cp $< docs/$<

docs/assignments/%: assignments/%
	mkdir -p docs/assignments
	mv $< docs/$<

docs/software/%: software/%
	mkdir -p docs/software
	mv $< docs/$<

%.html: %.rmd
	Rscript  -e "rmarkdown::render('$<')"

%.slides.html: %.qmd
## @F = file: https://stackoverflow.com/questions/59446839/get-filename-from-in-makefile
	cd $(<D); quarto render $(<F) --to revealjs -M embed-resources:true -o $(@F)
## mv $(@F) docs/notes


%.html: %.qmd
## @F = file: https://stackoverflow.com/questions/59446839/get-filename-from-in-makefile
	cd $(<D); quarto render $(<F) --to html -M embed-resources:true

## %.html: %.qmd
## 	quarto render $< --to revealjs

## https://stackoverflow.com/questions/5178828/how-to-replace-all-lines-between-two-points-and-subtitute-it-with-some-text-in-s
## FIXME, sed -r doesn't work on MacOS
## https://stackoverflow.com/questions/42646316/what-does-d-mean-in-shell-script
## @D = directory of traget
%.docx: %.qmd
##	sed -r '/::::: \{#special .spoiler/,/:::::/c\**SPOILER**\n' < $< > $(@D)/tmp.rmd
	cp $< $(@D)/tmp.qmd
	quarto render $(@D)/tmp.qmd --to docx --toc   
	mv $(@D)/tmp.docx $*.docx

%.html: %.md
	Rscript  -e "rmarkdown::render('$<')"

%.pdf: %.rmd
	Rscript -e "rmarkdown::render('$<', output_format = tufte::tufte_handout())" ## , params = list('latex-engine'='xelatex'))"



%.pdf: %.qmd
	quarto render $< --to pdf
## margin-citations hack: assumes we will only be doing this for notes/ docs
##	quarto render $< --to latex --toc
##	@echo $(patsubst %.qmd,%.tex,$<)
## Rscript marginhack.R $(patsubst %.qmd,%.tex,$<)
##	texi2dvi -p $(patsubst %.qmd,%.tex,$<)
##	mv $(patsubst notes/%.qmd,%.pdf,$<) docs/notes

%.pdf: %.tex
	pdflatex $<

%.pdf: %.md
	Rscript -e "rmarkdown::render('$<', output_format = tufte::tufte_handout())"

index.html: index.rmd sched.csv
	Rscript  -e "rmarkdown::render('$<')"

${COURSE}_bib.html: ${COURSE}_bib.md ${COURSE}.bib
	Rscript  -e "rmarkdown::render('$<')"

docs/books.html: books.qmd ${COURSE}.bib
	quarto render $(<F) -M embed-resources:true
	mv books.html docs/

PANDOC=pandoc-3.1.7-1-amd64.deb
new-pandoc:
	wget https://github.com/jgm/pandoc/releases/download/3.1.7/${PANDOC}
	sudo dpkg -i ${PANDOC}
