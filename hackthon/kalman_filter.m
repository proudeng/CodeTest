%本例子从百度文库中得到， 稍加注释
clear
data = load('delay_array.txt');
%z = data(1:200,1);
z = data(:,1);
z = z';
N = size(z,2);
%N=200;%取200个数

%% 生成噪声数据 计算噪声方差
w=randn(1,N); %产生一个1×N的行向量，第一个数为0，w为过程噪声（其和后边的v在卡尔曼理论里均为高斯白噪声）
w_avr = sum(w)/N;
w = (w - w_avr);
%w(1)=0;
Q=var(w); % R、Q分别为过程噪声和测量噪声的协方差(此方程的状态只有一维，方差与协方差相同) 

v=randn(1,N);%测量噪声
v_avr = sum(v)/N;
v = (v - v_avr);
R=var(v);

%% 计算真实状态
%x_true(1)=0;%状态x_true初始值
A=1;%a为状态转移阵，此程序简单起见取1
%for k=2:N
%    x_true(k)=A*x_true(k-1)+w(k-1);  %系统状态方程，k时刻的状态等于k-1时刻状态乘以状态转移阵加噪声（此处忽略了系统的控制量）
%end


%% 由真实状态得到测量数据， 测量数据才是能被用来计算的数据， 其他都是不可见的
%H=0.2;
H=1;
%z=H*x_true+v;%量测方差，c为量测矩阵，同a简化取为一个数
x_true = z - v;

%% 开始 预测-更新过程

% x_predict: 预测过程得到的x
% x_update:更新过程得到的x
% P_predict:预测过程得到的P
% P_update:更新过程得到的P

%初始化误差 和 初始位置
for t=1:5
x_update(t)=0;%s(1)表示为初始最优化估计
P_update(t)=1;%初始最优化估计协方差
end

for t=6:N
    %-----1. 预测-----
    %-----1.1 预测状态-----
    %x_predict(t) = A*x_update(t-10); %没有控制变量
    x_predict(t) = A*x_update(t-5); %没有控制变量
    %-----1.2 预测误差协方差-----
    %P_predict(t)=A*P_update(t-10)*A'+Q;%p1为一步估计的协方差，此式从t-1时刻最优化估计s的协方差得到t-1时刻到t时刻一步估计的协方差
    P_predict(t)=A*P_update(t-5)*A'+Q;%p1为一步估计的协方差，此式从t-1时刻最优化估计s的协方差得到t-1时刻到t时刻一步估计的协方差

    %-----2. 更新-----
    %-----2.1 计算卡尔曼增益-----
    K(t)=H*P_predict(t) / (H*P_predict(t)*H'+R);%b为卡尔曼增益，其意义表示为状态误差的协方差与量测误差的协方差之比(个人见解)
    %-----2.2 更新状态-----
    x_update(t)=x_predict(t)  +  K(t) * (z(t -5)-H*x_predict(t));%Y(t)-a*c*s(t-1)称之为新息，是观测值与一步估计得到的观测值之差，此式由上一时刻状态的最优化估计s(t-1)得到当前时刻的最优化估计s(t)
    %-----2.3 更新误差协方差-----
    P_update(t)=P_predict(t) - H*K(t)*P_predict(t);%此式由一步估计的协方差得到此时刻最优化估计的协方差
end

%% plot
%作图，红色为卡尔曼滤波，绿色为量测，蓝色为状态
%kalman滤波的作用就是 由绿色的波形得到红色的波形， 使之尽量接近蓝色的真实状态。
t=1:N;
%plot(t,x_update,'r',t,z,'g',t,x_true,'b');
%plot(t,x_update,'r',t,x_true,'b');

x_update = round(x_update);
x_true = round(x_true);
%plot(t,x_update,'r',t,z,'g',t,x_true,'b');
plot(t,x_update,'r',t,z,'g');

%comp = abs(x_update - z);
result = sum(abs(x_update - z) <=1);
fprintf('estimation accurate samples: %d \n', result);
fprintf('estimation accurate against measured value with kalman filter: %f \n', result/N);
%x_update_trans = x_update';
%save('-text','estimation_result.txt', 'x_update_trans');

%comp = abs(x_update - x_true); 
result = sum(abs(x_update - x_true) <=1);
fprintf('estimation accurate against true value with kalman filter: %f \n', result/N);


for t=6:N
    x_update(t) = z(t - 5);
end
%comp = x_update - z;
result = sum(abs(x_update - z) <= 1);
fprintf('estimation accurate samples with pure estimation of z = z[t - 5]: %d \n', result);
fprintf('estimation accurate against measured value with pure estimation of z = z[t -5]: %f \n', result/N);

