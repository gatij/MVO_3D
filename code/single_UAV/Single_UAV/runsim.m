close all;
clear all;
clc;
addpath(genpath('./'));

%% Plan path
disp('Planning ...');
map = load_map('maps/map1.txt', 0.1, 0.5, 0.25);
start = {[5 -4 3]};
stop  = {[5 19 2]};
nquad = length(start);
sumofcost =0;
for i = 1:20
    
for qn = 1:nquad
    v = cputime;
    [path{qn},cost] = gso(map, start{qn}, stop{qn}, true);
    c = cputime - v;
    fprintf('Algo Execution time = %d \n',c);
    fprintf('Cost value = %d \n',cost);
    sumofcost = sumofcost+cost;
end
if nquad == 1
    plot_path(map, path{1});
else
    % you could modify your plot_path to handle cell input for multiple robots
end
end
fprintf('Average cost = %d \n',sumofcost/20);
%% Additional init script
init_script;

%% Run trajectory
trajectory = test_trajectory(start, stop, map, path, true); % with visualization
