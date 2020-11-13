[![made-with-datalad](https://www.datalad.org/badges/made_with.svg)](https://datalad.org)

# Automatically Reproducible Paper Template

This repository is a minimal template for creating a dynamically generated, automatically reproducible paper using [DataLad](http://handbook.datalad.org/r.html?about), Python, Makefiles, and LaTeX.

In this example, DataLad is used to link the manuscript to code and data. Within a Python script that computes results and figures, DataLad's Python API is used to retrieve data automatically. The LaTeX manuscript does not hard-code results or tables, but embeds external files or variables with results. The Python script saves its results and figures into the dataset, but also outputs results in form that they can be embedded into the manuscript as variables. To orchestrate code execution and LaTeX manuscript compiling, a Makefile is used. With this setup, generating a manuscript with freshly computed results is a matter of running a `make` command in a cloned repository.

The template is meant to be used in workshops or tutorials and is therefore a simplified example. However, it is based on an actually published, reproducible paper that can be found [in this repository](https://github.com/psychoinformatics-de/paper-remodnav/).

If you found this repository outside of a DataLad teaching event, do note that this repository is a DataLad dataset.
You can find out what DataLad datasets are in the short introduction [at the end of this README](#DataLad-datasets-and-how-to-use-them), and at [handbook.datalad.org](http://handbook.datalad.org)

## Requirements

To run and adjust this template to your own manuscript or research project, you will need to have the following software tools installed:

* DataLad ([installation instructions](http://handbook.datalad.org/en/latest/intro/installation.html))
* [latexmk](https://mg.readthedocs.io/latexmk.html) to render the PDF from ``main.tex``, and [make](https://www.gnu.org/software/make/) to run the Makefile
* Python, together with `virtualenv` Python module (if you don't want to use a virtual Python environment, please follow the instructions below to find out what other Python modules you need)

## How to use this template

First, get an idea of what it does.
For this, you should

* `datalad clone` the repository:

```sh
# don't copy leading $ - they only distinguish a command from a comment.
$ datalad clone https://github.com/datalad-handbook/repro-paper-sketch.git
```

* This template uses a Python script on a linked input dataset (`input/`) as an example analysis. 
  You can adjust it to whichever programming or scripting language you prefer, and to whichever data you like.
  If you want to run the template locally to get a hang on how it works, it is recommended (but optional) to create a [virtual Python environment](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/) first:

```sh
    # create and enter a new virtual environment (optional)
    $ virtualenv --python=python3 ~/env/repro
    $ . ~/env/repro/bin/activate
```
    
* Afterwards, within the repository, install the relevant Python packages used in the template's example (specified in [requirements.txt](./requirements.txt)):

```
$ cd repro-paper-sketch
$ pip install -r requirements.txt
```

* Finally, run `make` to see how the template executes a Python script ([code/mk_figuresnstats.py](code/mk_figuresnstats.py)) on the linked ``input/`` dataset, collects & saves its results dynamically in result files & figures, and generates a manuscript that embeds the created results and figures on the fly.
  The orchestration of this workflow takes place in the [Makefile](./Makefile), and comments in the relevant sections shed light on what each line does.
  While the simple Makefile included in this template should get you started, an introduction to Makefiles can also be found in [The Turing Way handbook for reproducible research](https://the-turing-way.netlify.app/reproducible-research/make.html).
* The resulting PDF will be called `main.pdf` and you will find it in the root of the dataset.  
* If things go wrong during ``make``, run ``make clean`` to clean up any left-behind clutter.

### Quick start tutorial 
  
To give you a quick idea of how to use this template, ``make`` the manuscript, and then adjust the script in a way that would minimally affect the results.
Afterwards, run ``make`` again to see your changes embedded in the manuscript.

```sh
# We will assume you have the relevant software (Python, latexmk) set up
# generate the manuscript with unchanged code
$ make
# open the resulting PDF with a PDF viewer (for example evince)
$ evince main.pdf
# open code/mk_figuresnstats.py with an editor of your choice. Adjust the color palette
# in the function plot_relationships() from "muted" to "Blues". You can also do
# this from the terminal with this line of code:
# macOS
$ sed -i' ' 's/muted/Blues/g' code/mk_figuresnstats.py  
# linux
$ sed -i 's/muted/Blues/g' code/mk_figuresnstats.py  
# run make again
$ make
# take another look at the PDF to see how the figure was dynamically updated
```  
  
If this setup with LaTeX and Makefiles suits your workflow, adjust code, manuscript, and data to your own research project.

* Install the data that you need as a subdataset using:

```sh
$ datalad clone -d . <url>
```  
  
* adjust the ``dl.get()`` call in the script to retrieve the data your analysis needs from it,
* write analysis code that saves its results in either LaTeX variables or files that can be imported into a ``.tex`` file, and
* write your manuscript, embedding all of your results as figures, tables, or variables.
 
**Done. :)**

If you are curious about how the manuscript PDF is actually built, make sure you read its content once you have successfully created it!

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
subdatasets, use `-n` flag like so:

```
datalad get -n <path/to/subdataset>
```

Afterwards, you can browse the retrieved metadata to find out about
subdataset contents, and use `datalad get` once again (no flag this time) to retrieve individual files.
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
