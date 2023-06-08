# Post-processing

Once the simulation has finished and all the time directories are written out, the simulation results can be analysed. First, let us examine the data written by the function objects: the average inlet pressure and velocity components at the probe location.

## Average inlet pressure

Similar to the residuals data, the average inlet pressure is written to the file `postProcessing/averageInletPressure/0/surfaceFieldValue.dat` and can be plotted with any tool available, such as Microsoft Excel, gnuplot or python. The resulting diagram will look like follows:

<img src="./figures/backward-step-averageInletPressure.png" width="60%">

Just as the residuals have indicated, the simulation does not seem to have reached a fully steady-state case yet. The average static pressure at the inlet after $1\\,\text{s}$ simulation time is close to $175\\,\text{Pa}$.


## Probes velocity components

The velocity components for each time step monitored by the `probes` function object are stored in the file `postProcessing/probes/0/U`. Once plotted, they reveal that the velocity components stay fairly constant after $0.6\\,\text{s}$:

<img src="./figures/backward-step-probes.png" width="60%">


## Velocity animation