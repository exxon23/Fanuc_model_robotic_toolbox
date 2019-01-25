clear all;close all;clc;
%% arms dimenions 
L1 = 34;  %[m]
L2 = 0;
L3 = 30;
L4= 107;
L5 = 100;
L6 = 20;
L7 = 15;
L8= 5;
% %% links definitions
deg = pi/180;
L(1) = Revolute('d', L1, 'a', 0, 'alpha', 0, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071], ...
    'qlim', [0 0]*deg );
L(2) = Revolute('d', 0, 'a', L2, 'alpha', pi/2, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071]);
L(3) = Revolute('d', 0, 'a', L3, 'alpha', 0, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071], ...
    'qlim', [20 20]*deg);
L(4) = Revolute('d', 0, 'a',L4, 'alpha', 0, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071], ...
    'qlim', [25 140]*deg );
L(5) = Revolute('d', 0, 'a', 0, 'alpha', -pi/2, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071], ...
    'qlim', [-245 30]*deg );
L(6) = Revolute('d', L5+L6, 'a', 0, 'alpha', pi/2, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071]);
L(7) = Revolute('d', 0, 'a', 0, 'alpha', -pi/2, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071], ...
    'qlim', [-90 90]*deg );
L(8) = Revolute('d', L7+L8, 'a', 0, 'alpha', 0, ...
    'I', [0.13, 0.524, 0.539, 0, 0, 0], ...
    'r', [-0.3638, 0.006, 0.2275], ...
    'm', 17.4, ...
    'Jm', 200e-6, ...
    'G', 107.815, ...
    'B', .817e-3, ...
    'Tc', [0.126 -0.071]);

%% default positions
%        q1  q2  q3  q4  q5  q6  q7  q8
home = [ 0   20  20  100 144 180 0  0];
start =[0   0  20   45  0   0   0  0];
startrad = deg2rad(home);
homerad = deg2rad(home);
%% trajectories
q = deg2rad([ start;
    0 0 20 130 0 0 0 0
    
    
]);
%% create robot rear
% from 25 to 140 (0.4363 to 0.6981) q4
% from -245 30 q5
step = 1;
trajectories = deg2rad([0 0 20 24 -245 0 0 0]);
for i = 1 : (140-25)*step
        q_main_start = deg2rad([0 0 20 24+i/step -245 0 0 0]);
        q_main_half = deg2rad([0 0 20 24+i/step 30 0 0 0]);
        q_main_end = deg2rad([0 0 20 24+i/step -245 0 0 0]);
        trajectories = [trajectories; jtraj(q_main_start,q_main_half, 15); jtraj(q_main_half,q_main_end, 15)];
end

%% create robot and plot
% trajektoria = jtraj(q(1,:), q(2,:), 50);
R = SerialLink(L, 'name', 'Fanuc 2000',  'plotopt', { 'tilesize', 50});
% T = R.fkine(homerad);
%% ikine
P1 = [1 0 0 196;
      0 1 0 0;
      0 0 1 148;
      0 0 0 1];
T0 = [1 0 0 137;
      0 1 0 0;
      0 0 1 174;
      0 0 0 1];
T1 = [1 0 0 277;
      0 1 0 0;
      0 0 1 34;
      0 0 0 1];
% R.teach(trajectories,'trail',{'r', 'LineWidth', 2} )
R.teach()