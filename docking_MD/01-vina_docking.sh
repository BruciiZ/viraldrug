#!/bin/bash

for file in ../pdbqtLigands/*.pdbqt

do 
  baseName=$(basename $file)
  if [ ! -f "${baseName%.pdbqt}.log" ]; then
    ./vina_1.2.5 --config config.txt --ligand $file --out output.pdbqt > ${baseName%.pdbqt}.log
  fi
done

mkdir bioactiveResults
mv EBC*.log bioactiveResults/

for file in ../controls/*.pdbqt

do 
  baseName=$(basename $file)
  if [ ! -f "${baseName%.pdbqt}.log" ]; then
    ./vina_1.2.5 --config config.txt --ligand $file --out output.pdbqt > ${baseName%.pdbqt}.log
  fi
done

./extract_energy.sh > ranked_energy.log
