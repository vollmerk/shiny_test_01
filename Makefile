all: README.pdf README.md README.html chuuk.out
README.pdf: README.Rmd
	R --no-save -e 'library(rmarkdown); render("$<", "pdf_document")'
README.md: README.Rmd
	R --no-save -e 'library(rmarkdown); render("$<", "md_document")'
README.html: README.Rmd
	R --no-save -e 'library(rmarkdown); render("$<", "html_document")'
tides: force
	Rscript -e "shiny::runApp('app.R', port=4321)"
%.out: %.R
	Rscript $< >& $@
force:


