# Solving the case

The OpenFOAM application for this tutorial is called `pimpleFoam`, a solver for transient, incompressible, laminar or turbulent flows. It can be started by entering the case directory and typing

```
pimpleFoam
```

Similar to the previous tutorial, the progress of the job is written to the terminal window. It tells the user the current time step, the equations beeing solved, initial and ﬁnal residuals for all ﬁelds and should look like follows:

```
Courant Number mean: 0.292858 max: 0.768129
Time = 0.0515s

smoothSolver:  Solving for Ux, Initial residual = 0.00257533, Final residual = 4.01745e-06, No Iterations 2
smoothSolver:  Solving for Uy, Initial residual = 0.00478933, Final residual = 5.98345e-07, No Iterations 3
GAMG:  Solving for p, Initial residual = 0.0111791, Final residual = 3.49808e-05, No Iterations 4
time step continuity errors : sum local = 8.8159e-09, global = 5.32582e-10, cumulative = 5.54026e-07
GAMG:  Solving for p, Initial residual = 0.00374643, Final residual = 5.55887e-08, No Iterations 10
time step continuity errors : sum local = 1.39218e-11, global = 4.01037e-13, cumulative = 5.54026e-07
ExecutionTime = 4.74 s  ClockTime = 4 s
```

It shows us the usual output, such as which equations to be solved, initial and final residuals, number of sub-iterations needed for solving the time step, the error of the conservation of mass (`continuity error`), and the time needed for execution. Apart from this, it also tells us the mean and maximum Courant number. This is important to judge whether the choosen time step is sufficiently small for a stable simulation. At this time step, the maximum Courant number is 0.768. Although larger than the initially estimated value of 0.5, it is smaller than 1.0 indicating a stable simulation.

Similar to the previous tutorial, function objects are added in the `controlDict` for post-processing and the acquired data is stored inside the `postProcessing` folder.

#### Residuals function object

The first function object is the `residuals` function object for being able to plot the initial residuals for pressure and velocity during runtime. The function object is once again configured as follows in the `controlDict`:

```
49      printResiduals
50      {
51          type        residuals;
52          libs        ("libutilityFunctionObjects.so");
53
54          fields      ( U p );
55      }
```

Using the `foamMonitor` utility, the residuals can be plotted as function of iterations as follows:

```
foamMonitor -l postProcessing/printResiduals/0/residuals.dat
```

#### SurfaceFieldValue function object

The second function object is of type `surfaceFieldValue` and used to monitor the area-weighted pressure at the inlet for each time step. This can be considered a second variable for juding the convergence of the simulation. Furthermore, since the static pressure at the outlet is set to 0, it acts as a measure for (kinematic) pressure loss between inlet and outlet. It is configured as follows:

```
58      averagePressure
59      {
60          type            surfaceFieldValue;
61          libs            ("libfieldFunctionObjects.so");
62  
63          regionType      patch;
64          name            inlet;
65  
66          operation       areaAverage;
67          writeFields     no;
68  
69          fields          ( p );
70      }
```

Here, we want to compute a certain value from the patch, hence `regionType` set to `patch` and `name` set to the name of the patch, here `inlet`. The `operation` is set to `areaAverage` and the fields to compute from is set to pressure `p`.

> **Note**
>
> The `surfaceFieldValue` is a powerful tool for computing a wide range of operations on patches and individual face zones, e.g. area average, area integral, sum, minimum or maximum values, or coefficient of variation among others.

#### Probes function object

The third function object is of type `probes` and designed to monitor field variables at certain probe locations throughout the computational domain. It is a third way to judge convergence and the transient behaviour of the flow. It is configured as follows:

```
72      probes
73      {
74          type            probes;
75          libs            ("libsampling.so");
76
77          fields          (U);
78  
79          probeLocations
80          (
81              ( 0.025 0 0 )
82          );
83      }
```

In this function object, the field variables of velocity `U` are monitored in the specified probe point `(0.025 0 0)`, so it is located slightly downstream the backward-facing step. Monitoring flow variables in certain locations does not only allow for judging convergence, it also enables us to compute characteristic frequencies of the flow by performing a Fast-Fourier Transform on the monitored data.