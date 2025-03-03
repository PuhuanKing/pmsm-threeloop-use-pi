%% 初始化一些平台参数
clc;clear;
%% PMSM参数及模型
Rs = 0.958;% 这是书里面提到的模型
Ld = 0.00525;
Lq = 0.012;
np = 4;
B = 0.008;
J = 0.003;
Flux = 0.1827;
kpid = Ld*1100;%Ld*alpha_current
kiid = Rs*1100;%Rs*alpha_current
kpiq = Lq*1100;
kpid = Rs*1100;
kpv = 0.2;
kiv = 4;%0.14*50;
kpp = 125;
kip = 20;

% Rs=0.4;% 陈卫星文章参数
% Ld=0.006;% 单位：H
% Lq=0.006;
% np=4;
% J=0.02;
% B=0.08;
% Flux=;


% csdn 
% Rs=0.958;% 陈卫星文章参数
% Ld=0.00525;% 单位：H
% Lq=0.012;
% np=4;
% J=0.003;
% B=0.008;
% Flux=0.1827;
alpha_current = 1100;
Ts = 1e-05;
%Ld*alpha_current
%Rs*alpha_current
%100*J/(1.5*np*Flux)
%100*100*J/(1.5*np*Flux)
% pmsm.model             ='BR2804-1700';
% pmsm.sn                ='008';
% pmsm.p                 =7;
% pmsm.Rs                =0.5300;
% pmsm.Ld                =3.7e-05;
% pmsm.Lq                =3.7e-05;
% pmsm.J                 =1.95e-07;
% pmsm.B                 =2.53e-07;
% pmsm.N_max             =18000;
% pmsm.Ke                =0.600;
% pmsm.Kt                =4.96e-03;
% pmsm.FluxPM            =4.73e-04;
% pmsm.I_rated           =5.6;
% pmsm.N_base            =12540;
% pmsm.F_base            =pmsm.N_base*pmsm.p/60;
% pmsm.DC                =12;
% pmsm.T_rated           = (3/2)*pmsm.p*pmsm.FluxPM*pmsm.I_rated;
% 
% Vmin                   =1;
% 
% Rs = 0.53;% csdn xiaoshushu1995
% Ld = 3.7e-05;
% Lq = 3.7e-05;
% np = 7;
% B = 2.53e-07;
% J = 1.95e-07;
% Flux = 4.73e-04;
% 
% kpid = pmsm.Lq/(3*Ts);%Ld*alpha_current
% kiid = pmsm.Rs/(3*Ts);%Rs*alpha_current
% kpiq = pmsm.Lq/(3*Ts);
% kpid = pmsm.Rs/(3*Ts);
% kpv = 0.1433;
% kiv = 2.5;


%% 关节初始化
    %虎克铰
    hookup = 30;
    hookdown = -30;
    sphereup = 30;
    spheredown = -30;
    pingyilow = 0;
    pingyiup = 0.1;
    % 铰链相关
    trare = 0.01;
    sprsti = 0.1;
    damcoe = 0.1;
    spt = 0;%0.3943;
    % 上下重量
    downMass = 0.1;
    upMass = 0.1;
    %上下长度与半径
    l1 = 0.35;%缸筒与杆的长度
    l2 = 0.15;
    radiusdown = 0.03;
    radiusup = 0.015;
    contact = 0.05;
    %% 验证的平台基本参数,直接使用大族的参数
r_B = 0.3005;r_T = 0.19425;
B_beta = 23.04/2;
T_alpha = 35.98/2;

B_angle1 = 60 - B_beta;    
B_angle2 = 60 + B_beta;
B_angle3 = 180 - B_beta;
B_angle4 = 180 + B_beta;
B_angle5 = 300 - B_beta;
B_angle6 = 300 + B_beta;
B1 = [ r_B*cosd( B_angle1 ) ; r_B*sind( B_angle1 ); 0 ];%3x1
B2 = [ r_B*cosd( B_angle2 ) ; r_B*sind( B_angle2 ); 0 ];
B3 = [ r_B*cosd( B_angle3 ) ; r_B*sind( B_angle3 ); 0 ];
B4 = [ r_B*cosd( B_angle4 ) ; r_B*sind( B_angle4 ); 0 ];
B5 = [ r_B*cosd( B_angle5 ) ; r_B*sind( B_angle5 ); 0 ];
B6 = [ r_B*cosd( B_angle6 ) ; r_B*sind( B_angle6 ); 0 ];
T_angle1 = T_alpha; 
T_angle2 = 120 - T_alpha;
T_angle3 = 120 + T_alpha;
T_angle4 = 240 - T_alpha;
T_angle5 = 240 + T_alpha;
T_angle6 = 360 - T_alpha;
T1_Ti= [ r_T*cosd( T_angle1 ); r_T*sind( T_angle1 ); 0 ];
T2_Ti= [ r_T*cosd( T_angle2 ); r_T*sind( T_angle2 ); 0 ];
T3_Ti= [ r_T*cosd( T_angle3 ); r_T*sind( T_angle3 ); 0 ];
T4_Ti= [ r_T*cosd( T_angle4 ); r_T*sind( T_angle4 ); 0 ];
T5_Ti= [ r_T*cosd( T_angle5 ); r_T*sind( T_angle5 ); 0 ];
T6_Ti= [ r_T*cosd( T_angle6 ); r_T*sind( T_angle6 ); 0 ];
%% 暂时使用刘国军论文里的并联平台仿真

%% pid调节
Kp = 0;
Ki = 0;
Kd = 0;
