## Automatically Reproducible Paper Template

This repository is a [DataLad](ttp://handbook.datalad.org) dataset and a template
for creating an automatically reproducible paper using DataLad, Python, Makefiles, and LaTeX.

## Requirements

* DataLad
* Python modules (specified in [requirements.txt](./requirements.txt))
* [latexmk](https://mg.readthedocs.io/latexmk.html)

## How to use

* `datalad clone` the repository
* run `pip install -r requirements.txt` to install the relevant Python modules
* run `make` to run a Python script and generate a manuscript from the results
* adjust code and manuscript to your own research project, if this set up suits
  your workflows.