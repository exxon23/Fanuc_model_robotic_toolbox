R = createRobot();

%% create robot rear
% from 25 to 140 (0.4363 to 0.6981) q5
% from -245 30 q6
step = 1;
trajectories = deg2rad([0 0 20 24 -245 0 0 0]);
for i = 1 : (140-25)*step
        q_main_start = deg2rad([0 0 20 24+i/step -245 0 0 0]);
        q_main_half = deg2rad([0 0 20 24+i/step 30 0 0 0]);
        q_main_end = deg2rad([0 0 20 24+i/step -245 0 0 0]);
        trajectories = [trajectories; jtraj(q_main_start,q_main_half, 15); jtraj(q_main_half,q_main_end, 15)];
end

R.teach(trajectories,'trail',{'r', 'LineWidth', 2} )

for
setFixedTransform
