#!/bin/bash

INPUT_DIR=~/TFM/data/Contigs_Final
OUTPUT_DIR=~/TFM/data/ResFinder_Results
DB_DIR=~/TFM/data/resfinder/resfinder/db_resfinder

mkdir -p $OUTPUT_DIR

for sample in $INPUT_DIR/*_contigs.fasta
do
    base=$(basename $sample _contigs.fasta)

    echo "Running ResFinder for $base"

    python -m resfinder \
        -ifa $sample \
        -o $OUTPUT_DIR/$base \
        -db_res $DB_DIR \
        -acq \
        -l 0.8 \
        -t 0.9
done
