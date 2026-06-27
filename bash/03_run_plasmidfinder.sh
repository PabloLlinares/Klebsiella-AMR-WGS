#!/bin/bash

INPUT_DIR=~/TFM/data/Contigs_Final
OUTPUT_DIR=~/TFM/data/PlasmidFinder_Results
DB_DIR=~/TFM/data/tools/plasmidfinder/plasmidfinder_db

mkdir -p $OUTPUT_DIR

for sample in $INPUT_DIR/*_contigs.fasta
do
    base=$(basename $sample _contigs.fasta)

    echo "Running PlasmidFinder for $base"

    mkdir -p $OUTPUT_DIR/$base

    python -m plasmidfinder \
        -i $sample \
        -o $OUTPUT_DIR/$base \
        -p $DB_DIR \
        -l 0.8 \
        -t 0.9 \
        -j $OUTPUT_DIR/$base/results.json \
        -q
done
