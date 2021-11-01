#!/bin/bash
##Energy minimization to production mdrun
##change the number of steps in the files
module purge
module load gromacs2020-gpu
gmx_mpi grompp -f minim.mdp -c file_solv_ions.gro -p topol.top -o em.tpr -maxwarn 2
gmx_mpi mdrun -v -deffnm em
gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn 2
gmx_mpi mdrun -v -deffnm nvt -ntomp 5 -nb gpu
gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr -maxwarn 2
gmx_mpi mdrun -v -deffnm npt -ntomp 5 -nb gpu
gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_1.tpr -maxwarn 2
gmx_mpi mdrun -v -deffnm md_1 -ntomp 5 -nb gpu
