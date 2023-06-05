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

