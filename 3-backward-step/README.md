# Backward-facing Step

## Objectives

The objectives for this tutorial are as follows:
  * Create a block-structured mesh using the tool `blockMesh` and scale it with `transformPoints`,
  * Estimate the correct time step size based on Courant number,
  * Perform a transient, incompressible simulation with `pimpleFoam`,
  * Analyse the flow field using runtime postprocessing and ParaView.


## Overview

This tutorial will describe how to pre-process, run and post-process a case involving a transient, isothermal, incompressible ﬂow over a two-dimensional backward-facing step. The geometry is shown in the following figure with an inlet on the left, stationary walls on the top and bottom, and an outlet at the right. The ﬂow will be solved using the transient solver `pimpleFoam` suitable for laminar and turbulent, isothermal, incompressible ﬂows.

<img src="./figures/backward-step-geometry.png" width="90%">


## Preparation

In order to work through the OpenFOAM tutorial, make sure to download the latest version of the seminar repository and extract it inside your `Downloads` folder. Next, you must change the working directory of the terminal to the `backward-step` folder inside the downloaded repository directory. If the archive of this repository has been downloaded and extracted in the `Downloads` folder of your home, this can be achieved by typing:

```
cd ~/Downloads/Introduction-into-CFD-main/3-backward-step/backward-step
```

Then, you have to source OpenFOAM by either typing

```
source /app2/OpenFOAM/OpenFOAM-10/etc/bashrc
```

*or* if you set up the alias in the previous tutorial

```
of10
```

into the terminal.

Once ready, you can scroll to the top of the page and click on the documentation for the first part called [*1-pre-processing.md*](./1-pre-processing.md).

## Tasks for this tutorial

 - [ ] Create the mesh using `blockMesh`
 - [ ] Check the mesh quality using `checkMesh` and scale the mesh correctly using `transformPoints` 
 - [ ] Specify the boundary conditions types and values for velocity and kinematic pressure
 - [ ] Correctly set the kinematic viscosity `nu` to achieve a Reynolds-number of 250 at the inlet
 - [ ] Set the time step size `deltaT` to keep a maximum Courant number of $\text{Co} \approx 0.5$
 - [ ] Run the simulation using `pimpleFoam` and judge convergence using the average pressure at the inlet
 - [ ] Visualize the transient velocity field using ParaView and save an animation.


## Additional tasks

Once you have successfully finished the third tutoral, you can solve the following, additional tasks: