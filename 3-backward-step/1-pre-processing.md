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

The two-dimensional mesh for this case can be finally be created and stored into the `constant/polyMesh` directory by typing the following command into the terminal:

```
blockMesh
```

> **Task**
>
> Used the `blockMesh` utlility to create the mesh for this tutorial.


## Mesh manipulation

Once the mesh has been created with `blockMesh`, it is essential to check the mesh quality using `checkMesh`. The output reveals a perfect mesh quality. However, the mesh is incorrectly scaled as indicated by the bounding box. It shows a overall domain size of $300\\,\text{m}$ in $x$-direction, $50\\,\text{m}$ in $y$-direction, and $1\\,\text{m}$ in $z$-direction:

```
Checking geometry...
    Overall domain bounding box (-50 -25 -0.5) (250 25 0.5)
    Mesh has 2 geometric (non-empty/wedge) directions (1 1 0)
```

In order to maniupulate the mesh, e.g. scale, translate or rotate, the OpenFOAM utility `transformPoints` can be used. For scaling by a factor of 0.1, e.g. reducing the mesh size to 1/10th, the command looks as follows:

```
transformPoints "scale=(0.1 0.1 0.1)"
```

> **Task**
>
> Perform a `checkMesh`, determine the required scaling factors, and scale the mesh according to the correct dimensions using `transformPoints`.


## Material properties

Reynolds-number of 1000 is required


## Time step size

Calculate time-step size based on Courant-number


## 