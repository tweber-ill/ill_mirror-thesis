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
		-o -name "*.toc" -o -name "*.log" \
		-o -name "*.lof" -o -name "*.lol" -o -name "*.lot" \) \
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
thesis.pdf: tex/thesis.tex tex/thesis.bib \
	tex/abstract.tex tex/acknowledgements.tex tex/intro.tex tex/errata.tex \
	tex/notation.tex tex/publications.tex tex/tests.tex tex/outlook.tex \
	tex/gl.tex tex/xtal.tex tex/paths.tex tex/implementation.tex \
	tex/interfaces.tex tex/algos.tex
	@echo "[special] Building $< -> $@..."
	$(PDFLATEX) tex/thesis.tex
	$(BIBTEX) thesis
	$(PDFLATEX) tex/thesis.tex
	$(PDFLATEX) tex/thesis.tex
# -----------------------------------------------------------------------------

