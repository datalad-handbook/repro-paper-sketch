all: main.pdf

main.pdf: main.tex references.bib results_def.tex
	latexmk -pdf -g $<

results_def.tex: code/mk_figuresnstats.py
	bash -c 'set -o pipefail; code/mk_figuresnstats.py | tee results_def.tex'

clean:
	rm -f main.bbl main.aux main.blg main.log main.out main.pdf main.tdo main.fls main.fdb_latexmk example.eps img/*eps-converted-to.pdf texput.log results_def.tex figures-stamp
	$(MAKE) -C img clean
