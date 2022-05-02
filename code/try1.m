%% 起始点位置
MyX = 0;                                    % 出发点位置
MyY = 0;
DesX = 100;                                 % 终点位置
DesY = 100;

% 自定义障碍物
a1 = [10,12];                               % 障碍物
a2 = [95,95];
a3 = [35,25];
a4 = [50,45];
a5 = [60,50];
a6 = [85,70];
a7 = [60,30];
a8 = [90,50];
a9 = [65,60];
a10 = [45,10];

Obs = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10];     % 障碍物坐标矩阵

%     Obs = randi([0,100],10,2);                    % 随机生成障碍物

flag = 1;                                   % 1为使用经典方法，0为使用改进方法


%% 超参数设置

% 经典方法下的超参数设置
if(flag == 1)    
    Kaat = 0.1;                     % 引力尺度因子
    Krep = 100;                   % 斥力尺度因子
    P0 = 25;                        % 斥力作用范围
    StepRate = 0.05;                % 步长
    Epoch = 2000;                   % 最大迭代次数
    de = 20;                        % 引力距离因子
end


% 改进方法下的超参数设置
if(flag == 0)
    Kaat = 0.5;                     % 引力尺度因子
    Krep = 0.5;                   % 斥力尺度因子
    P0 = 25;                        % 斥力作用范围
    StepRate = 0.05;                % 步长
    Epoch = 2000;                   % 最大迭代次数
    de = 20;                        % 引力距离因子
end


%% 画图
% subplot(3,3,t);
hold on

a = scatter(Obs(1:10,1)',Obs(1:10,2)','b','filled');
b = scatter(MyX,MyY,100,'g','filled');
c = scatter(DesX,DesY,100,'r','filled');
xlabel("X");
y = ylabel("Y");
set(y,'Rotation',0);
xlim([0,100]);
ylim([0,100]);
%     legend([a,b,c],{'障碍物','起点','终点'});


%% 计算
CountFlag = 0;
while(1)
    
   if(flag == 1)
       [Fattx,Fatty] = Attractive(MyX,DesX,MyY,DesY,Kaat);                                % 引力计算
   else
       [Fattx,Fatty] = AttractiveImprove(MyX,DesX,MyY,DesY,Kaat,de); 
   end
   Frepx = zeros(1,10);
   Frepy = zeros(1,10);
   for i = 1:10
       if(flag == 1)         
           [Frepx(1,i),Frepy(1,i)] = Repulsive(MyX,MyY,Obs(i,1),Obs(i,2),Krep,P0);        % 斥力计算
       else
           [Frepx(1,i),Frepy(1,i)] = RepulsiveImprove(MyX,MyY,Obs(i,1),Obs(i,2),DesX,DesY,Krep,P0);
       end
   end

   Fxsum = Fattx + sum(Frepx);
   Fysum = Fatty + sum(Frepy);

   PositionAngle = atan(Fysum/Fxsum);

   MyX = MyX + StepRate*Fxsum;
   MyY = MyY + StepRate*Fysum;

   d = scatter(MyX,MyY,5,'m','filled');

   if(abs(MyX-100) < 1 && abs(MyY-100)< 1 )
       fprintf("完成");
       break;
   end

   CountFlag = CountFlag + 1;
   if(CountFlag >= Epoch)
       fprintf("超时");
       break;
   end    
end

hold off
%     legend([a,b,c,d],{'障碍物','起点','终点','路径'});
display(CountFlag);

