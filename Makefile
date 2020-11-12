all: main.pdf

# This rule is executed last, and renders the full PDF from the manuscript with latexmk.
# The -g flag is used to *always* process the document, even if no changes have been made to it.

main.pdf: main.tex references.bib results_def.tex
	latexmk -pdf -g $<

# This rule executes the code script, and collects all the latex variables that are printed out
# to the terminal in a file called "results_def.tex". The manuscript will use this file as input.
# The -c option takes the string in the command and hands it to bash.
# The string specifies "set -o pipefail" to check if the workflow executed successfully,
# then executes the script, and collects its stdout stream in results_def.tex using
# a Unix pipe and redirection with tee

results_def.tex: code/mk_figuresnstats.py
	bash -c 'set -o pipefail; code/mk_figuresnstats.py | tee results_def.tex'

# Use the two rules below for inkscape based SVG-to-PDF rendering of figures
# figures: figures-stamp

# figures-stamp: code/mk_figuresnstats.py
#	code/mk_figuresnstats.py -f -r -m
#	$(MAKE) -C img
#	touch $@

# This rule cleans up temporary LaTeX files, and result and PDF files
clean:
	rm -f main.bbl main.aux main.blg main.log main.out main.pdf main.tdo main.fls main.fdb_latexmk example.eps img/*eps-converted-to.pdf texput.log results_def.tex figures-stamp
	$(MAKE) -C img clean
