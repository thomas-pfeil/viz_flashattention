# Variables
TEXFILE = main.tex
PDFOUT = main.pdf
IMGSOUT = flashattention
SVGS = $(wildcard *.svg)
PDFS = $(SVGS:.svg=.pdf)

# Default target
all: $(PDFOUT)

# Create images for medium.com
medium: $(PDFOUT)
	# Crop PDF and convert to Images
	pdfcrop --margins '3 3 3 3' $(PDFOUT) /dev/stdout | pdftoppm -png -r 900 - $(IMGSOUT)

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
	rm -f $(IMGSOUT)*.png

# Force rebuild
.PHONY: all clean
