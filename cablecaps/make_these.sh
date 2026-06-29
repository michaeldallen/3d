#!/bin/bash

for x in $@ ; do
    fgrep --silent --files-with-matches NOSTL $x || { echo make openscad.artifacts/$x | sed 's/[.]scad$/.stl/'  ; }
done

#EOF
