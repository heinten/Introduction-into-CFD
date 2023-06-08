#
# Create the residuals plot
#

reset

set term pngcairo size 800,600 font "Arial,16"
set output "plot_residuals.png"

set log y
set format y "10^{%T}"
#set format y "%1.0e"

set title 'Residual Plot'
set xlabel 'Time [s]'
set ylabel 'Residuals [-]'

set grid

plot \
  'postProcessing/printResiduals/0/residuals.dat' u 1:2 w l lw 2 t 'p', \
  'postProcessing/printResiduals/0/residuals.dat' u 1:3 w l lw 2 t 'U_x', \
  'postProcessing/printResiduals/0/residuals.dat' u 1:4 w l lw 2 t 'U_y'


#
# Create the inlet pressure plot
#

reset

set term pngcairo size 800,600 font "Arial,16"
set output "plot_avgInletPressure.png"

set title 'Average Inlet Pressure'
set xlabel 'Time [s]'
set ylabel 'Static Pressure [Pa]'

set yrange[-500:500]

set grid

plot \
  'postProcessing/averageInletPressure/0/surfaceFieldValue.dat' u ($1):(1000*$2) w l lw 2 t ''


#
# Create the probe velocity components plot
#

reset

set term pngcairo size 800,600 font "Arial,16"
set output "plot_probes.png"

set title 'Probe Velocity Components'
set xlabel 'Time [s]'
set ylabel 'Velocity [m/s]'

set grid

plot \
  '<sed -e "s/[(,)]//g" postProcessing/probes/0/U' using 1:2 w l lw 2 t 'U_x', \
  '<sed -e "s/[(,)]//g" postProcessing/probes/0/U' using 1:3 w l lw 2 t 'U_y'

