#!/bin/bash
## get stuff from an old class
SRCDIR=~/classes/stat790
for i in index.rmd sched.csv R_style.rmd honesty.md Makefile; do
    cp ${SRCDIR}/$i .
done    
