close all;
clear all;
clc;
addpath(genpath('./'));


%% Plan path
disp('Planning ...');
map = load_map('maps/map3.txt', 0.1, 0.5, 0.25);
%Map 3
 start = {[11.6,2.8,5.8],[11.2,4.5,5]};
stop  = {[19.8,4.5,5.6],[1.8,4,4]};

dist  = [0 0  ;0 0  ];
for i= 1:length(start)
    for j= 1:length(start)
        p1=start{i};
        p2=stop{j};
        disp(p1);
        dist_x = (p1(1,1)- p2(1,1))*(p1(1,1) - p2(1,1));
        dist_y = (p1(1,2)- p2(1,2))*(p1(1,2) - p2(1,2));
        dist_z = (p1(1,3)- p2(1,3))*(p1(1,3) - p2(1,3));
        dist(i,j) = sqrt(dist_x + dist_y + dist_z);
    end
end
t1=cputime;
[ass,cost]=munkres(dist)


start_temp = {};
stop_temp = {};
for i = 1:length(start)
    for j=1:length(start)
        if ass(i,j)==1
            start_temp{end+1}= start{i};
            stop_temp{end+1}= stop{j};
        end
    end
end

start = start_temp;
stop= stop_temp;

fprintf('munkres time%d = \n ',cputime-t1);
       
 mt=cputime-t1;
 
 algo_exe_sum=0;    
        
        
 sumall = 0;
 maxall=-1;
 minall= 10000000000000;
 sumallarray= [];
 
    
nquad = length(start);

for qn = 1:nquad
    v = cputime;
    [path{qn},costValue] = bbo(map, start{qn}, stop{qn}, true);
    
    c = cputime - v;
    
    fprintf('Algo Execution time for quad %d = %d \n',qn,c);
    algo_exe_sum=algo_exe_sum+c; 
end

% if nquad == 4
%     plot_path(map, path{1});
%     plot_path(map, path{2});
%     plot_path(map, path{3});
%     plot_path(map, path{4});
%     
% else
%     % you could modify your plot_path to handle cell input for multiple robot
% end
 
fprintf("sum is %d and average is %d\n",sumall,sumall/10);
fprintf("min is %d and max is %d\n",minall,maxall);
fprintf("standard deviation is %d\n",std(sumallarray));

% %% Additional init script
init_script;
% 
% % Run trajectory
% v2=cputime;
% trajectory = test_trajectory(start, stop, map, path, true); % with visualization
% c2=cputime-v2;
% fprintf('simulation time = %d \n',c2);
% overall time
ot=0;
ot=ot+algo_exe_sum+mt;
fprintf('Overall time = %d \n',ot);
%% Run trajectory
