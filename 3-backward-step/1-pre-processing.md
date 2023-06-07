# Pre-processing

Before the simulation can be run, you have to create the mesh and configure the case. The following section explains the additional steps required for the backward-faceing step case based on the elbow case.

## OpenFOAM case structure

The folder structure for the backward-faceing step case looks similar to the elbow case. In this tutorial case, the `backward-step` folder contains the following subfolders and files:

```
backward-step
├── 0
│   ├── p
│   └── U
├── constant
│   └── momentumProperties
│   └── physicalProperties
└── system
    ├── blockMeshDict
    ├── controlDict
    ├── fvSchemes
    └── fvSolution

3 directories, 8 files
```

Compared to the elbow case, there is only one additional file called `blockMeshDict` in the `system` folder.


## Mesh generation

The backward-step domain consists of three connected blocks representing a two-dimensional channel with a backward-facing step.

The mesh for this case will be created using the OpenFOAM utility `blockMesh`, which creates hiqh-quality block-structured meshes. The utility has no graphical user interface and is fully configured via the `blockMeshDict` file inside the `system` directory. The file can basically be broken down into three parts: (1) Definition of the vortices, (2) defininition of the blocks, and (3) definition of the boundaries.

### Definition of the vertices

At first, the coordinates of the 16 vertices are specified, where the vertices are numbered internally starting from zero:

```
18  vertices
19  (
20      (-50 0   -0.5)      // vertex 0
21      (-50 25  -0.5)      // vertex 1
22      (0   -25 -0.5)      // vertex 2
23      (0   0   -0.5)      // vertex 3

...

37  );
```

### Definition of the blocks

These vertices are used to define the three blocks of the block-structured mesh. Each block consisting of hexahedral cells only consists of exactly 8 vertices, which are defined based on their number. For example, the first block reads:
```
39  blocks
40  (
41      hex (0 3 4 1 8 11 12 9)
42      (50 25 1)
43      simpleGrading (1 1 1)

...

52  );
```

This means that this block contains of vertices with the label 0, 3, 4, 1, 8, 11, 12, and 9. The next line dictates that first block contains 50 cells in *x*-direction, 25 cells in *y*-direction and *1* cell in z-direction. Finally, the block has a completely equidistant mesh with equal cell size. Therefore, the `simpleGrading` coefficients are simply set to 1.

### Definition of the boundaries

Once the blocks are defined, the boundary patches are specified based on the vortex labels (here four patches are defined: `inlet`, `outlet`, `walls`, and `frontAndBack`). For example, the inlet patch is defined as follows:

```
57      inlet
58      {
59          type patch;
60          faces
61          (
62              (0 1 8 9)
63          );
64      }
```

which simply means that the patch called `inlet` is of type `patch` and consists of a single block face defined by the vertex labels 0, 1, 8, and 9.

> **Note**
>
> The detailed description of all entries in the `blockMeshDict` is omitted here due to its complexity. You can consult the official user manual [section 5.3](https://doc.cfd.direct/openfoam/user-guide-v10/blockmesh#x26-1850005.3) for a thorough introduction into `blockMesh`.

The two-dimensional mesh for this case can finally be created and stored into the `constant/polyMesh`. For this, execute the `blockMesh` command in the terminal with the current working directory being the backward-step folder:

```
blockMesh
```



## Mesh manipulation

Once the mesh has been created with `blockMesh`, it is essential to check the mesh quality using `checkMesh`. The output reveals a perfect mesh quality. However, the mesh is incorrectly scaled as indicated by the bounding box. It shows a overall domain size of $300\\,\text{m}$ in $x$-direction, $50\\,\text{m}$ in $y$-direction, and $1\\,\text{m}$ in $z$-direction:

```
Checking geometry...
    Overall domain bounding box (-50 -25 -0.5) (250 25 0.5)
    Mesh has 2 geometric (non-empty/wedge) directions (1 1 0)
```

In order to maniupulate the mesh, e.g. scale, translate or rotate, the OpenFOAM utility `transformPoints` can be used. For example, reducing the mesh size to 1/10th and thus applying a scaling factor of 0.1 in all three dimensions, the command would look as follows:

```
transformPoints "scale=(0.1 0.1 0.1)"
```

## Boundary conditions

The boundary conditions for thir tutorial case are best configured in pressure-velocity configuration, as we want to specify an exact inlet velocity and thus Reynolds-number. As a result, velocity is defined at the inlet while static pressure is defined at the outlet.

For the velocity we set a fixed value at the inlet using the `fixedValue` type boundary condition with an uniform inlet velocity of $1\\,\text{m/s}$ in $x$-direction while the outlet is simply specified as type `zeroGradient`. Assuming a velocity of zero at the walls, a `noSlip` type boundary condition is used there.

In contrast, the inlet boundary for pressure is specified as type `zeroGradient` while the outlet boundary is set to type `fixedValue` with a uniform value of $0\\,\text{m}^2\text{/s}^2$. Pressure at solid boundaries are as always of type `zeroGradient`.



## Physical properties

The physical properties for the fluid, such as kinematic viscosity, are stored in the `physicalProperties` file in the `constant` directory. In this tutorial, the Reynolds-number at the inlet should be 250. Based on the inlet velocity $U_\text{in}$ and the channel height at the inlet $H$, the kinematic viscosity can be computed based on the equation for the Reynolds-number:

$$
\text{Re} = \frac{U_\text{in} H}{\nu}
$$


## Simulation control

Settings related to the control of time and reading and writing of the solution data are read in from the `controlDict` file in the `system` folder.

The time step size for this tutorial is defined via the keyword `deltaT`. To achieve temporal accuracy and numerical stability when running `pimpleFoam`, a Courant number of $\text{Co} \approx 0.5$ is recommended. Based on the cell size $\Delta x$, local flow velocity $U$, and time step size $\Delta t$, the Courant number is deﬁned for one cell as:

$$
\text{Co} = \frac{U \Delta t}{\Delta x}
$$

The ﬂow velocity naturally varies across the domain and the Courant-number limitation must be kept in every cell. Therefore, we have to estimate the time step size based on known values. The cell size of this equidistant mesh is constant everywhere and can be estimated based on the channel height at the inlet $H$ and the corresponding cell count $n$:

$$
\Delta x = \frac{H}{n}
$$

The characteristic velocity in the flow domain $U$ can be approximated to be equal to the inlet velocity $U_\text{in}$. Although the actual flow velocity will probably be higher further downstream the inlet, this give a sufficiently good estimate for computing the time step size $\Delta t$.