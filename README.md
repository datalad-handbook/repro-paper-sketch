[![made-with-datalad](https://www.datalad.org/badges/made_with.svg)](https://datalad.org)

# Automatically Reproducible Paper Template

This repository is a minimal template for creating an automatically reproducible paper using [DataLad](http://handbook.datalad.org/r.html?about), Python, Makefiles, and LaTeX.
It is a simplified example of an actually published, reproducible paper that can be found [in this repository](https://github.com/psychoinformatics-de/paper-remodnav/), and created for use in workshops or tutorials.

If you found this repository outside of a DataLad teaching event, do note that this repository is a DataLad dataset.
You can find out what DataLad datasets are in the short introduction [at the end of this README](#DataLad-datasets-and-how-to-use-them), and at [handbook.datalad.org](http://handbook.datalad.org)

## Requirements

To run and adjust this template to your own manuscript or research project, you will need to have the following software tools installed:

* A Python installation
* [latexmk](https://mg.readthedocs.io/latexmk.html) to render the PDF from ``main.tex``, and [make](https://www.gnu.org/software/make/) to run the Makefile
* (Optionally) Inkscape, to render figures that are in SVG format

## How to build the paper


- `git clone` the repository:

```sh
# don't copy leading $ - they only distinguish a command from a comment.
$ git clone https://github.com/datalad-handbook/repro-paper-sketch.git
```

- Create a [virtual environment](https://docs.python.org/3/tutorial/venv.html) and activate it:

```
# one way to create a virtual environment (called repro in this example):
virtualenv --python=python3 ~/env/repro
. ~/env/repro/bin/activate
```

- run ``make``


The resulting PDF will be called `main.pdf` and you will find it in the root of the dataset.
If things go wrong during ``make``, run ``make clean`` to clean up any left-behind clutter.

## How the setup works

This repository is a DataLad dataset, and links data to scripts that compute numerical results or figures from it.
The script saves figures and outputs numerical results.
Orchestration with a Makefile ensures that these results are collected and that a manuscript that embeds the created results and figures on the fly is generated.
If SVG figures exist in the `img/` directory, they will be rendered with inkscape to embed them, too.
Comments in the Makefile in the relevant sections shed light on what each line does.
While the simple Makefile included in this template should get you started, an introduction to Makefiles can also be found in [The Turing Way handbook for reproducible research](https://the-turing-way.netlify.app/reproducible-research/make.html)


### Quick start tutorial 
  
To give you a quick idea of how to use this template, ``make`` the manuscript, and then adjust the script in a way that would minimally affect the results.
Afterwards, run ``make`` again to see your changes embedded in the manuscript.

```sh
# We will assume you have the relevant software (Python, latexmk) set up
# create a fresh virtual env and activate it
$ virtualenv --python=python3 ~/env/repro
$ . ~/env/repro/bin/active
# generate the manuscript with unchanged code
$ make
# open the resulting PDF with a PDF viewer (for example evince)
$ evince main.pdf
# open code/mk_figuresnstats.py with an editor of your choice. Adjust the color palette
# in the function plot_relationships() from "muted" to "Blues". You can also do
# this from the terminal with this line of code:
$ sed -i 's/muted/Blues/g' code/mk_figuresnstats.py  
# run make again
$ make
# take another look at the PDF to see how the figure was dynamically updated
```  


## How to adjust the template

If this setup with LaTeX and Makefiles suits your workflow, adjust code, manuscript, and data to your own research project.

You can:
- Change the contents of [requirements.txt](./requirements.txt) to Python modules of your choice.
  They will be installed before executing the script.
- Change the code, or add new code.
  In the current template, the Python script ([code/mk_figuresnstats.py](code/mk_figuresnstats.py)) is executed.
- Change the data.
  In the current template, code operates on the linked ``input/`` DataLad dataset.
  You can link any dataset of your choice with DataLad ([installation instructions and further info](http://handbook.datalad.org/en/latest/intro/installation.html))
- Change the manuscript.
  Adjust [main.tex](./main.tex) to your text of choice, add new figures, tables, or contents.


* Install the data that you need as a subdataset called using

```sh
$ datalad clone -d . <url>
```  
  
* adjust the ``dl.get()`` call in the script to retrieve the data your analysis needs from it,
* write analysis code that saves its results in either LaTeX variables or files that can be imported into a ``.tex`` file, and
* write your manuscript, embedding all of your results as figures, tables, or variables.
 
**Done. :)**

*DISCLAIMER:* This is not the only way to generate a reproducible research object, and there are many tools out there that can achieve the same.
This template is just one demonstration of one way to write a reproducible manuscript. 

--------------------------------------------------------------------------------
 
### DataLad datasets and how to use them

This repository is a [DataLad](https://www.datalad.org/) dataset. It provides
fine-grained data access down to the level of individual files, and allows for
tracking future updates. In order to use this repository for data retrieval,
[DataLad](https://www.datalad.org/) is required. It is a free and
open source command line tool, available for all major operating
systems, and builds up on Git and [git-annex](https://git-annex.branchable.com/)
to allow sharing, synchronizing, and version controlling collections of
large files. You can find information on how to install DataLad at
[handbook.datalad.org/en/latest/intro/installation.html](http://handbook.datalad.org/en/latest/intro/installation.html).

#### Get the dataset

A DataLad dataset can be `cloned` by running

```
datalad clone <url>
```

Once a dataset is cloned, it is a light-weight directory on your local machine.
At this point, it contains only small metadata and information on the
identity of the files in the dataset, but not actual *content* of the
(sometimes large) data files.

#### Retrieve dataset content

After cloning a dataset, you can retrieve file contents by running

```
datalad get <path/to/directory/or/file>`
```

This command will trigger a download of the files, directories, or
subdatasets you have specified.

DataLad datasets can contain other datasets, so called *subdatasets*.
If you clone the top-level dataset, subdatasets do not yet contain
metadata and information on the identity of files, but appear to be
empty directories. In order to retrieve file availability metadata in
subdatasets, run

```
datalad get -n <path/to/subdataset>
```

Afterwards, you can browse the retrieved metadata to find out about
subdataset contents, and retrieve individual files with `datalad get`.
If you use `datalad get <path/to/subdataset>`, all contents of the
subdataset will be downloaded at once.

#### Stay up-to-date

DataLad datasets can be updated. The command `datalad update` will
*fetch* updates and store them on a different branch (by default
`remotes/origin/master`). Running

```
datalad update --merge
```

will *pull* available updates and integrate them in one go.

#### Find out what has been done

DataLad datasets contain their history in the ``git log``.
By running ``git log`` (or a tool that displays Git history) in the dataset or on
specific files, you can find out what has been done to the dataset or to individual files
by whom, and when.

#### More information

More information on DataLad and how to use it can be found in the DataLad Handbook at
[handbook.datalad.org](http://handbook.datalad.org/en/latest/index.html). The chapter
"DataLad datasets" can help you to familiarize yourself with the concept of a dataset.
