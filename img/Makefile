# This Makefile is useful when you want to save figures as SVG files (nicer for, e.g., version control).
# It will use inkscape to render them to PDF files before building the manuscript.
# In your .tex file, you can include your figures as .pdf even if your script saves
# them as SVG.

all: pics

# use `chronic` to make output look neater, if available
CHRONIC=$(shell which chronic || echo '' )

# For every .svg we must have a pdf
pics: $(shell find . -iname \*.svg | sed -e 's/svg/pdf/g' )


clean:
	for p in *.svg; do rm -f $${p%*.svg}.eps $${p%*.svg}.pdf; done
	-rm -rf *_300dpi.png

# git-ignore each auto-rendered figure
.PHONY: ignore-%
ignore-%:
	@grep -q "^$*$$" .gitignore || { \
	  echo "$*" >> .gitignore; echo "Ignore $@"; }

#
# Inkscape rendered figures
#
# try modern-age API first, fall-back on old one, if needed
%.pdf: %.svg ignore-%.pdf
	@echo "Rendering $@"
	@$(CHRONIC) inkscape --export-filename="$@" "$<" || $(CHRONIC) inkscape -z -f "$<" -A "$@"

.PHONY: all pics