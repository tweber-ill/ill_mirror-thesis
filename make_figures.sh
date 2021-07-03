#!/bin/bash
#
# create figures
# @author Tobias Weber <tweber@ill.fr>
# @date jan-2021
# @license GPLv3 (see 'LICENSE' file)
#


CONVERTER=$(which inkscape)


if [ "$CONVERTER" = "" ]; then
	echo -e "\n\nError: Inkscape, which is used for conversion, was not found.\n\n"
	exit -1
fi


for fig_svg in figures_svg/*.svg; do
	# change ending
	fig_pdf_meta="${fig_svg%\.svg}.pdf"

	# remove meta directory
	fig_pdf_base=$(basename "${fig_pdf_meta}")

	# files that can be ignored
	if [ "${fig_pdf_base}" = "thales.pdf" ]; then
		continue;
	fi

	# add figures directory
	fig_pdf="figures/${fig_pdf_base}"

	echo -e "$fig_svg -> $fig_pdf"

	#convert -render $fig_svg $fig_pdf
	$CONVERTER --export-pdf-version=1.4 --export-pdf=$fig_pdf $fig_svg
done
