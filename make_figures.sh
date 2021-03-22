#!/bin/bash
#
# create figures
# @author Tobias Weber <tweber@ill.fr>
# @date jan-2021
# @license GPLv3 (see 'LICENSE' file)
#

for fig_svg in meta/*.svg; do
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

	convert $fig_svg $fig_pdf
done
