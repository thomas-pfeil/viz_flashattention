# Variables
TEXFILE = main.tex
PDFOUT = main.pdf
SVGS = $(wildcard *.svg)
PDFS = $(SVGS:.svg=.pdf)

# Default target
all: $(PDFOUT)

# Convert SVG to PDF using Inkscape
%.pdf: %.svg
	inkscape --export-type=pdf $< -o $@

# Build LaTeX document with latexmk
$(PDFOUT): $(TEXFILE) $(PDFS)
	latexmk -pdf -interaction=nonstopmode $(TEXFILE)

# Clean auxiliary files
clean:
	latexmk -C
	rm -f $(PDFS)

# Force rebuild
.PHONY: all clean
