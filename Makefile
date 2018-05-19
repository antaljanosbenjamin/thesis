PAPER=thesis
COMPILER=./texfot.pl pdflatex -interaction=nonstopmode

all: clean paper
	echo

paper:
	$(COMPILER) $(PAPER)
	bibtex $(PAPER)
	$(COMPILER) $(PAPER)
	$(COMPILER) $(PAPER)

clean:
	echo Cleaning temporary files and PDF...
	rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.pdf
