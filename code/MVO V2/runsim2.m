close all;
clear all;
clc;
addpath(genpath('./'));


%% Plan path
disp('Planning ...');
map = load_map('maps/map4.txt', 0.1, 0.5, 0.25);
%Map 3
% start = {[14.1 ,2.8, 5.8],[11.6 ,2, 5],[8.1,3,5],[14,4,5],[11.2,4.5,5]};
% stop  = {[19.8 ,2, 5],[19.8, 4.5 ,5.6],[1.8,4,5.6],[2,3,5.9],[5,4,5.2]};

%Map 1
start = {[5,-4,3],[6,-4,3],[5,2.5,3],[5,3,3],[5,-4,5.5]};
stop  = {[5,19,2],[6,19.5,3],[6,18,3.2],[5,15,5.5],[5,14,5.2]};
%Map4
% start={[5,-4.9,3],[6,-4,4],[5,0,1],[5,0,5.8],[5.1,-4,4]};
% stop={[5,19,3],[2,19.5,3.2],[5,14,3],[5,14,4],[5,15,5]};
% dist  = [0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0 ];
% for i= 1:length(start)
%     for j= 1:length(start)
%         p1=start{i};
%         p2=stop{j};
%         disp(p1);
%         dist_x = (p1(1,1)- p2(1,1))*(p1(1,1) - p2(1,1));
%         dist_y = (p1(1,2)- p2(1,2))*(p1(1,2) - p2(1,2));
%         dist_z = (p1(1,3)- p2(1,3))*(p1(1,3) - p2(1,3));
%         dist(i,j) = sqrt(dist_x + dist_y + dist_z);
%     end
% end
% 
% [ass,cost]=munkres(dist)
% 
% 
% start_temp = {};
% stop_temp = {};
% for i = 1:length(start)
%     for j=1:length(start)
%         if ass(i,j)==1
%             start_temp{end+1}= start{i};
%             stop_temp{end+1}= stop{j};
%         end
%     end
% end
% 
% start = start_temp;
% stop= stop_temp;
% disp(start);
% disp(stop);

        
      
        
        
        
 sumall = 0;
 maxall=-1;
 minall= 10000000000000;
 sumallarray= [];
for sim = 1:10
     fprintf('Simulation no. %d = \n',sim);
nquad = length(start);
costValue=0;
sumValue =0;
for qn = 1:nquad
    v = cputime;
    [path{qn},costValue] = MVONEW(map, start{qn}, stop{qn});
    
    c = cputime - v;
    
    sumValue = sumValue + costValue;
    
    fprintf('Algo Execution time for quad %d = %d \n',qn,c);
end
sumall = sumall + sumValue;
sumallarray(end+1) = sumValue;
if(sumValue>maxall)
    maxall = sumValue;
end
if(sumValue<minall)
    minall = sumValue;
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
 end
fprintf("sum is %d and average is %d\n",sumall,sumall/10);
fprintf("min is %d and max is %d\n",minall,maxall);
fprintf("standard deviation is %d\n",std(sumallarray));

% %% Additional init script
% init_script;
% 
% % Run trajectory
% v2=cputime;
% trajectory = test_trajectory(start, stop, map, path, true); % with visualization
% c2=cputime-v2;
% fprintf('simulation time = %d \n',c);