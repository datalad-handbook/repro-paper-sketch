# use `chronic` to make output look neater, if available
CHRONIC=$(shell which chronic || echo '' )
PYTHON=python

all: main.pdf

# This rule is executed last, and renders the full PDF from the manuscript with latexmk.
# The -g flag is used to *always* process the document, even if no changes have been made to it.

main.pdf: main.tex references.bib install results_def.tex
	@echo "# Building PDF..."
	@$(CHRONIC) latexmk -pdf -g $<


# Before executing the script, ensure that all dependencies are installed.
# We do not want to mess with peoples system-wide installations, hence we test
# that we are in a virtual environment

install: requirements.txt
	@test -z "$$VIRTUAL_ENV" && \
		echo "ERROR: must be executed in a virtual env (set VIRTUAL_ENV to fake one)" && \
		exit 1 || true
	@echo "# Ensure dependency installation"
	@python -m pip install -r requirements.txt


# Execute the code script, and collects all the latex variables that are printed out
# to the terminal in a file called "results_def.tex". The manuscript will use this file as input.
# The -c option takes the string in the command and hands it to bash.
# The string specifies "set -o pipefail" to check if the workflow executed successfully,
# then executes the script, and collects its stdout stream in results_def.tex using
# a Unix pipe and redirection with tee

results_def.tex: code/mk_figuresnstats.py
	@echo "# Compute results and figures"
	bash -c 'set -o pipefail; code/mk_figuresnstats.py | tee results_def.tex'
	@echo "# Rendering figures"
	$(MAKE) -C img

# Use the two rules below for inkscape based SVG-to-PDF rendering of figures
# figures: figures-stamp

#figures-stamp: code/mk_figuresnstats.py
#	code/mk_figuresnstats.py -f
#	$(MAKE) -C img
#	touch $@

# This rule cleans up temporary LaTeX files, and result and PDF files
clean:
	rm -f main.bbl main.aux main.blg main.log main.out main.pdf main.tdo \
	main.fls main.fdb_latexmk example.eps texput.log results_def.tex \
	figures-stamp
	$(MAKE) -C img clean

.PHONY: clean
.PHONY: install