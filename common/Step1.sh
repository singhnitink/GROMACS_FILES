#!/bin/bash
##Select the ff when prompted and hit Enter
## Select SOL when prompted to enter ions
module load gromacs2020-cpu
read -p "Enter the name of pdb file without extension: " file
gmx_mpi pdb2gmx -f ${file}.pdb -o file_processed.gro -water tip3p
gmx_mpi editconf -f file_processed.gro -o file_newbox.gro -center 4 4 4 -box 8 8 8
gmx_mpi solvate -cp file_newbox.gro -cs spc216.gro -o file_solv.gro -p topol.top -box 8 8 8
gmx_mpi grompp -f ions.mdp -c file_solv.gro -p topol.top -o file_ions.tpr -maxwarn 1
gmx_mpi genion -s file_ions.tpr -o file_solv_ions.gro -p topol.top -pname NA -nname CL -neutral
