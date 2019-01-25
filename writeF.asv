clear all
close all
clc

R = createRobot();
home = deg2rad([0 -60 20 90 -140 0 -50 0]);
startPosition = R.fkine(home);

increases = createLettersPoints(30,10);

letterF(1,1)= startPosition;
numberOfSteps = 40;
for i = 2:length(increases)
    letterF(1,i)= letterF(1,i-1).t + increases(i,:)';
    tc = ctraj(letterF(1,i-1), letterF(1,i), numberOfSteps);
    if exist('trajectory')
        previousAngles = trajectory(numberOfSteps*(i-1)-numberOfSteps,:);
        trajectoryAdd = R.ikine(tc, previousAngles);
        trajectory = [trajectory; trajectoryAdd];
    else
        trajectory = R.ikine(tc, home);
    end
end
R.teach(trajectory,'nojoints', 'trail',{'r', 'LineWidth', 5});
% R.teach();

