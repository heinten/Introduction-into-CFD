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

  1. Open a terminal in the `backward-step` directory and source OpenFOAM.
  2. Create the mesh using `blockMesh`, check its quality with `checkMesh` and scale the mesh correctly using the `transformPoints` utility, so its dimensions match the figure at the top.
  3. Double-check the correct boundary conditions for kinematic pressure `p` and velocity `U` in the `0` folder. A uniform velocity of $1\\,\text{m/s}$ at the inlet has to be defined combined with a uniform pressure of $0\\,\text{m}^2\text{/s}^2$ at the outlet. Walls are set to no-slip for velocity and zero-gradient for pressure.
  4. Correctly set the kinematic viscosity `nu` in the `physicalProperties` file to achieve a Reynolds-number of 250 with respect to the inlet.
  5. Estimate a time step size so that a maximum Courant number of $\text{Co} \approx 0.5$ is reached and set it for the keywordk `deltaT` in the `controlDict`.
  6. Run the simulation using `pimpleFoam` and plot the residuals for judging convergence.
  7. Analyse the flow by using the area-weighted inlet pressure and velocity components at the probe location with the help of the provided Gnuplot script `create_plots.gnu`.
  8. Create an animation showing the velocity magnitude with ParaView in order to visualize the transient flow field.


## Additional tasks

Once you have successfully finished the third tutoral, you can solve the following, additional tasks:
  * Adjust the kinematic viscosity to achieve a Reynolds-number of 2500. Run the simulation and compare the velocity components at the probe location with the numerical results at a Reynolds-number of 250.
  * Create a new animation with ParaView showcasing the velocity magnitude for both Renyolds-numbers side by side. How did the flow field in general and the maximum flow specifically change? Are any changes to the time step size required?
