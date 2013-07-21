% loop_shaping.m
% NOT USED

%% draw circle Mt
circ_x= Mt_hf^2/(1-Mt_hf^2);
circ_y=0;
circ_rad=Mt_hf/(1-Mt_hf^2);
pdecirc(circ_x,circ_y,circ_rad)

hold on % ?????????????

%% draw circle Ms
circ_x= -1;
circ_y= 0 ;
circ_rad=1/Ms_lf;
pdecirc(circ_x,circ_y,circ_rad)
