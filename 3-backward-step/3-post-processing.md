# Post-processing

Once the simulation has finished and all the time directories are written out, the simulation results can be analysed. First, let us examine the data written by the function objects: the average inlet pressure and velocity components at the probe location. This data can typically be plotted in a diagram using Microsoft Excel, Python, Gnuplot or any other tool.

> **Note**
>
> In order to quickly evaluate the monitored results from the function objects, a script is added to the `backward-step` case directory called `create_plots.gnu`. Executing it will automatically create the diagramms for residuals, average inlet pressure and probe velocity components after the run. By typing the following command in the terminal, the diagrams are created using the opensouce command-line driven graphing utility **Gnuplot** and stored as separate **png** files:
> ```
> gnuplot create_plots.gnu
>```

## Average inlet pressure

Similar to the residuals data, the average inlet pressure is written to the `postProcessing` directory and will be plotted by the **Gnuplot** script:

<img src="./figures/backward-step-averageInletPressure.png" width="60%">

Just as the residuals have indicated, the simulation does not seem to have reached a fully steady-state case yet. The average static pressure at the inlet after $1\\,\text{s}$ simulation time is close to $175\\,\text{Pa}$. However, there is a clear bump in pressure just before $t = 0.6\\,\text{s}$, which needs further investigation.


## Probes velocity components

The velocity components for each time step monitored by the `probes` function object are also stored in the `postProcessing` directory. Once plotted, they reveal that the velocity components stay fairly constant after $0.6\\,\text{s}$:

<img src="./figures/backward-step-probes.png" width="60%">

This indicates a more or less steady-state solution after that time. However, only a closer look at the flow field using ParaView will reveal the actual flow structure.


## Velocity animation

A good way to visualize the transient flow behaviour is an animation created with ParaView. For this, display the velocity magnitude in a range from $(0 - 1.2)\\,\text{m/s}$. By clicking the **Play** button at the VCR-controls at the very top, it is possible to automatically go through every time step and get a quick glance of how the transient flow field looks like:

<img src="./figures/backward-step-animation.gif" width="80%">

Before creating an animation, it is recommended to add more information to the view. First of all, a title could be added by clicking on the top menu: **Sources** $\rightarrow$ **Annotations** $\rightarrow$ **Text**. You can type any text in the text field inside the **Properties** panel, adjust font size and location of the text field. Secondly, you could add the current time step to the view, again by using the top menu: **Sources** $\rightarrow$ **Annotations** $\rightarrow$ **Annotate Time**. Choose a suitable time **Format**, such as `Time: {time:1.2f} s` to display the time with two digits and the unit seconds. All in all, this could look like follows:

<img src="./figures/backward-step-velocity.png" width="80%">

At this point, the animation can easily be created by clicking the top menu: **File** $\rightarrow$ **Save Animation...**, and choosing a suitable file name and format (preferably **mp4**). At the following **Animation Menu**, you can specify video resolution, compression, and frame rate. It is recommended to change the frame rate to a higher value, such as $(10 - 15)\\,\text{fps}$. Clicking **Okay** will create the animation for you.

<img src="./figures/backward-step-animation-panel.png" width="60%">
