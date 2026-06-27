#!/bin/bash

mkdir -p ../Assemblies
mkdir -p ../Contigs_Final

for r1 in *_1_paired.fastq*
do
    r2="${r1/_1_paired.fastq/_2_paired.fastq}"
    r2="${r2/_1_paired.fastq.gz/_2_paired.fastq.gz}"
    base="${r1%%_1_paired.fastq*}"

    echo "Starting assembly for $base"

    spades.py -1 "$r1" -2 "$r2" -o "../Assemblies/$base" --careful

    if [ -f "../Assemblies/$base/contigs.fasta" ]; then
        cp "../Assemblies/$base/contigs.fasta" "../Contigs_Final/${base}_contigs.fasta"
        cp "../Assemblies/$base/spades.log" "../Contigs_Final/${base}_spades.log"
        rm -rf "../Assemblies/$base"
        echo "Finished and cleaned $base"
    else
        echo "ERROR: contigs.fasta not found for $base"
    fi

done

echo "All assemblies finished"
