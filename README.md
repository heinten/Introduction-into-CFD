# Introduction into Computational Fluid Dynamics


This repository complements the course **Introduction into Computational Fluid Dynamics** and provides currently two tutorials designed for familiarizing with the Linux command line, OpenFOAM, and post-processing tool ParaView:

 1. A introduction into the Linux command line ([Link](./1-command-line/README.md))
 2. Simulating of an incompressible flow through an elbow ([Link](./2-elbow/README.md))

More tutorials will be added throughout the semester.


## How to use this guide

This repository offeres a step-by-step introduction both into the Linux command line as well as OpenFOAM for simulation and ParaView for post-processing. If you are already familiar with the Linux command line, you can skip the first part and directly work on the second tutorial dealing with the simulation of an incompressible flow in an elbow.

You can navigate through the repository and display the indidual instructions using the web browser by clicking on the corresponding folder (recognizable by the folder symbol to the left of the name) or directly on the documentation (recognizable by the file ending `md`):

<img src="./figures/user-guide-navigation.png" width="90%">

The documentation is also part of the downloaded archive and can be visualized using a text editor. However, the correct formatting is only ensured when viewing the documentation through a web browser on the GitLab webpage. The idea of working through the user guide is as follows: Open the corresponding documentations and Readme files with a web browser and follow them closely. At the same time, open a terminal and go through the commands and instructions provided.

Throughout the user guide in this repository, commands for the command line are formatted as follows:
```
pwd
```
This example indicates that the command `pwd` should be typed into the terminal.

Content of files within the user guide are shown with line numbers as follows:

```
1   /*--------------------------------*- C++ -*----------------------------------*\
2     =========                 |
3     \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
4      \\    /   O peration     | Website:  https://openfoam.org
5       \\  /    A nd           | Version:  10
6        \\/     M anipulation  |
7   \*---------------------------------------------------------------------------*/
8   FoamFile
9   {
10      format      ascii;
11      class       dictionary;
12      object      blockMeshDict;
13  }
14  // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
15
```
