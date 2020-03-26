# SBtabVFGEN

This is a copy of the files in the source [Github
repository](https://github.com/a-kramer/SBtabVFGEN), commit
`4075f6465a1d7cc17fc15bf386a851da955f3442`.

The [R](https://www.r-project.org/) script `sbtab_to_vfgen` converts a
Model written in [SBtab](https://www.sbtab.net/), saved as a series of
`tsv` files (text file with tabs as field separators), or
alternatively an [Open Document
Spreadsheet](https://www.documentfoundation.org/) (ods) to a
[VFGEN](https://warrenweckesser.github.io/vfgen/) vector field file
(vf) and at the same time a `mod` file for use in
[NEURON](https://neuron.yale.edu/neuron/).

### NOTE
None of this will work well (or at all) on windows, unless you
are the kind of person who knows how to make it work regardless.

## R

Here is an example script that can run in a shell, it takes a list of
tsv files as command line arguments and makes a vfgen file and mod
file:

```R
#!/usr/bin/Rscript

tsv.files <- commandArgs(trailingOnly = TRUE);
message("parsing files: ")
message(sprintf("«%s» ",tsv.files))
source("~/Documents/SBtabVFGEN/sbtab_to_vfgen.R")
SBtabDoc <- sbtab_from_tsv(tsv.files)
message(sprintf("converting %i sheets to a VFGEN model.",length(SBtabDoc[["Table"]])))
Model <- sbtab_to_vfgen(SBtabDoc)
```

Alternatively, here is an interactive way to use it:
```R
source("~/Documents/SBtabVFGEN/sbtab_to_vfgen.R")
tsv.files=dir(pattern=".*.tsv")
SBtabDoc <- sbtab_from_tsv(tsv.files)
Model <- sbtab_to_vfgen(SBtabDoc,cla=FALSE)
```
where `cla=FALSE` deactivates conservation law analysis.

## Usage in NEURON

The user has to manually couple the `mod` file to a neuron simulation,
the systems biology model provided in this folder does not contain all
of the information about action potentials and ions.

## VFGEN

[VFGEN](https://github.com/WarrenWeckesser/vfgen) is a very useful
tool that can reformat an ordinary differential equation ODE (given in
a custom xml format) and convert it into various programming
languages, including right hand side functions for two `C` solvers of
ODEs. While doing so, it uses [GiNaC](https://ginac.de/) to calculate
the model's Jacobian. The R script `sbtab_to_vfgen.R` converts an
SBtab model to vfgen's `xml` format.

An example:
```bash
vfgen matlab:func=yes,demo=yes ${MODELNAME}.vf
```

## SBtab

[SBtab](https://www.sbtab.net/) is a tabular format for biochemical
models (as in Systems Biology). It is perhaps easier to understand
than sbml and can be parsed more easily via shell scripts due to its
tabular nature (e.g. tsv files). We use this format mostly because it
can be extended to contain additional information more easily (such as
experimental data, and conditions under which data was measured).

We have decided on a certain set of tables and columns that are needed
to parse the model sufficiently for our purposes. The set of tables is
not precisely defined by the SBtab documentation. This way of writing
the model is not universal among SBtab users, but it is a human
readable format and can be easily adapted to most purposes.

## Open Document Format

Even though `.tsv` files are perhaps most fundamental (have least
amount of prerequisites), ods files keep all the sheets in one file
and are slightly more convenient to edit. This script expects the file
to be read using the
[readODS](https://cran.r-project.org/web/packages/readODS/index.html)
package. Alternatively you can convert it using the two shell scripts
in this folder `ods_to_tsv.sh` and `tsv_to_ods.sh`, both are using
ssconvert that comes with [gnumeric](http://www.gnumeric.org/).
