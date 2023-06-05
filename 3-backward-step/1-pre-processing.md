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

Compared to the elbow case, only one additional file is present called `blockMeshDict` in the `system` folder.


## Mesh generation

The backward-step domain consists of three connected blocks representing a two-dimensional channel with a backward-facing step.

!!!FIGURE NEEDED!!!

The mesh for this case will be created using the OpenFOAM utility `blockMesh`, which creates hiqh-quality block-structured meshes. The utility has no graphical user interface and is fully configured via the `blockMeshDict` file inside the `system` directory. This file looks as follows for this case:

```
16  convertToMeters 1;
17
18  vertices
19  (
20      (-50 0   -0.5)      // vertex 0
21      (-50 25  -0.5)      // vertex 1
22      (0   -25 -0.5)      // vertex 2
23      (0   0   -0.5)      // vertex 3
24      (0   25  -0.5)      // vertex 4
25      (250 -25 -0.5)      // vertex 5
26      (250 0   -0.5)      // vertex 6
27      (250 25  -0.5)      // vertex 7
28
29      (-50 0   0.5)       // vertex 8
30      (-50 25  0.5)       // vertex 9
31      (0   -25 0.5)       // vertex 10
32      (0   0   0.5)       // vertex 11
33      (0   25  0.5)       // vertex 12
34      (250 -25 0.5)       // vertex 13
35      (250 0   0.5)       // vertex 14
36      (250 25  0.5)       // vertex 15
37  );
38
39  blocks
40  (
41      hex (0 3 4 1 8 11 12 9)
42      (50 25 1)
43      simpleGrading (1 1 1)
44
45      hex (2 5 6 3 10 13 14 11)
46      (250 25 1)
47      simpleGrading (1 1 1)
48
49      hex (3 6 7 4 11 14 15 12)
50      (250 25 1)
51      simpleGrading (1 1 1)
52  );
53
54
55  boundary
56  (
57      inlet
58      {
59          type patch;
60          faces
61          (
62              (0 1 8 9)
63          );
64      }
65      outlet
66      {
67          type patch;
68          faces
69          (
70              (5 6 14 13)
71              (6 7 15 14)
72          );
73      }
74      walls
75      {
76          type wall;
77          faces
78          (
79              (1 4 12 9)
80              (4 7 15 12)
81              (0 3 11 8)
82              (2 3 11 10)
83              (2 5 13 10)
84          );
85      }
86      frontAndBack
87      {
88          type empty;
89          faces
90          (
91              (0 3 4 1)
92              (2 5 6 3)
93              (3 6 7 4)
94              (8 11 12 9)
95              (10 13 14 11)
96              (11 14 15 12)
97          );
98      }
99  );
100 
101 // ************************************************************************* //
```

The ﬁle ﬁrst speciﬁes coordinates of the 16 block vertices, where the numbering starts at 0. Then, three blocks are defined based on the vertex labels. For example, the first block reads:

```
41      hex (0 3 4 1 8 11 12 9)
42      (50 25 1)
43      simpleGrading (1 1 1)
```

This means that the first block contains of vertices with the label 0, 3, 4, 1, 8, 11 12, and 9. The ordering of the vertices is extemely important defines the orientation of the block. Next, the number of cells in a block is defined. In this example, the first block contains 50 cells in *x*-direction, 25 cells in *y*-direction and *1* cell in z-direction. Finally, the block has a completely homogeneous mesh with no mesh grading. Therefore, the `simpleGrading` coefficients are simply set to 1.

Once the blocks are defined, the boundary patches are specified once again based on the vortex labels (here four patches are defined: `inlet`, `outlet`, `walls`, and `frontAndBack`). For example, the inlet patch is defined as follows:

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

which simply means that the patch `inlet` is of type `patch` and consists of a single face of the block with the vertex labels 0, 1, 8, and 9. 

The detailed description of all entries in the `blockMeshDict` are omitted here and. You can consult the official user manual [section 5.3](https://doc.cfd.direct/openfoam/user-guide-v10/blockmesh#x26-1850005.3) for a throrough explanation.

The two-dimensional mesh for this case can be finally be created and stored into the `constant/polyMesh` directory by typing the following command into the terminal:

```
blockMesh
```



## Mesh manipulation

CheckMesh reveals...

```
transformPoints "scale=(0.001 0.001 0.001)"
```


## Material properties

Reynolds-number of 1000 is required


## Time step size

Calculate time-step size based on Courant-number


## 