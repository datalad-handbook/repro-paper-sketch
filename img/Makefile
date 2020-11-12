all: pics

# This Makefile is useful when you want to save figures as SVG files (nicer for, e.g., version control).
# It will use inkscape to render them to PDF files before building the manuscript.
# In your .tex file, you can include your figures as .pdf even if your script saves
# them as SVG.

# Optionally some PICS could be ignored. By default XXX ones.
# PICS_IGNORE must contain a rule for grep
PICS_IGNORE ?= " "

# For every .svg we must have a pdf
PICS=$(shell find . -iname \*svg \
	| sed -e 's/svg/pdf/g' -e 's/\([^\]\)\([ \t:]\)/\1\\\\\2/g' \
	| grep -v -e $(PICS_IGNORE) )

pics: $(PICS)
	echo $(PICS)

clean:
	for p in *.svg; do rm -f $${p%*.svg}.eps $${p%*.svg}.pdf; done
	-rm -rf *_300dpi.png

# This places figures that are dynamically generated into a .gitignore file
.PHONY: ignore-%
ignore-%:
	@grep -q "^$*$$" .gitignore || { \
	  echo "$*" >> .gitignore; echo "Ignore $@"; }

#
# Inkscape rendered figures
#
%.pdf: %.svg ignore-%.pdf
	@echo "Rendering $@"
	@inkscape -z -f "$<" -A "$@"

%.eps: %.svg ignore-%.eps
	@echo "Rendering $@"
	@inkscape -z -f "$<" -E "$@"

%_300dpi.png: %.svg ignore-%_300dpi.png
	@echo "Rendering $@"
	@inkscape -z -f "$<" -e "$@" -d 300

.PHONY: all pics
