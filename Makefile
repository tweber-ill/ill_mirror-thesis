#
# thesis makefile
# @author Tobias Weber <tweber@ill.fr>
# @date jan-2021
# @license GPLv3 (see 'LICENSE' file)
#


# -----------------------------------------------------------------------------
# tools
# -----------------------------------------------------------------------------
PDFLATEX = pdflatex
BIBTEX = bibtex
CONVERT = convert
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# meta rules
# -----------------------------------------------------------------------------
.PHONY: all clean figures_svg2pdf

all: thesis.pdf

clean:
	find . \( -name "*.aux" -o -name "*.out" \
		-o -name "*.bbl" -o -name "*.blg" \
		-o -name "*.toc" -o -name "*.log" \) \
			-exec rm -fv {} \;
	rm -fv thesis.pdf

figures_svg2pdf: $(patsubst %.svg, %.pdf, $(wildcard figures/*.svg))
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# general rules
# -----------------------------------------------------------------------------
%.pdf: %.tex
	@echo "[general] Building $< -> $@..."
	$(PDFLATEX) $<
	$(BIBTEX) $(patsubst %.tex, %, $<)
	$(PDFLATEX) $<
	$(PDFLATEX) $<

%.pdf: %.svg
	@echo "[general] Converting $< -> $@..."
	$(CONVERT) $< $@
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# special rules
# -----------------------------------------------------------------------------
thesis.pdf: thesis.tex thesis.bib \
	abstract.tex acknowledgements.tex intro.tex errata.tex \
	notation.tex publications.tex \
	xtal.tex paths.tex
	@echo "[special] Building $< -> $@..."
	$(PDFLATEX) thesis.tex
	$(BIBTEX) thesis
	$(PDFLATEX) thesis.tex
	$(PDFLATEX) thesis.tex
# -----------------------------------------------------------------------------
