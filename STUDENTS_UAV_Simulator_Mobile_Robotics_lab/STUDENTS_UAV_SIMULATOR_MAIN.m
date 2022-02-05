%% ________________________  UAV X4 SIMULATOR  ____________________________
% ------------------ SUSBIELLE Pierre & BRINON ARRANZ Lara ----------------
% ------------------------------ GIPSA-Lab --------------------------------
% ------------------------- Mobile Robotics Lab ---------------------------

clear all
close all
clc

%% I. Drone model parameters and simulation parameters 

global Kv_motor Kv_motor_rad Mx J km R Jr cT cQ l lp m Ix Iy Iz U_sat g
global rho_ground rotor_radius hauteur_rotor
global with_flapping  

with_flapping = 0 ; % Do not change this value
 
% Approx Kopis, drone GIPSA-LAb, 5 pouces, 3S.

cT = 1.3529e-06 ;
cQ = 2.1113*1e-08 ;

% Arm length - Longueur du bras et longeure projetée (bras de levier)
l = 110*1e-3 ; 
lp = sqrt(2)/2*l ;

m = 0.536 ;
g = 9.81 ;

rho_ground = 1.4 ;
rotor_radius = 6.0*1e-2 ;
hauteur_rotor = 29.3*1e-3 ;

Ix = 0.029125 ;
Iy = 0.029125 ;
Iz = 0.055225 ;
J = diag([Ix Iy Iz]) ;

Kv_motor = 1750 ; %revolutions per minute - tour par minute
Kv_motor_rad = Kv_motor*2*pi/60 ;

% Motors parameters
km = 1/Kv_motor_rad ;

Jr = 1.2991*1e-05 ; % Motor inertia - Inertie du moteur 
R = 0.07 ; % Motor resistance - Résistance interne moteur % Doc t-motor F60 v IV 1750kv
U_sat = 12 ; % Motor voltage saturation

% Mix matrix - Matrice de mix :
Mx = [ cT        cT      cT         cT ; 
      -cT*lp   cT*lp    cT*lp   -cT*lp ;
      -cT*lp   -cT*lp    cT*lp   cT*lp ;
      cQ         -cQ      cQ     -cQ ] ; 

  
         
%% II. CONTROLLER - To be completed  

%%% II.1 Angular speeds Loop - [p q r]


%%% II.2 Attitude Loop - [phi theta psi] = Euler_123


%%% II.3 Speed & position Loop - [pos speed]


%% III. Simulation general parameters - initial conditions
initial_speed_conditions = [0 0 0] ;
initial_pos_conditions = [1 1 0] ;
initial_attitude_condition = [0 0 0 ] ;


%% HELIX TRAJECTORY
%%% Trajectory generator
tf = 60; %s
t1 = 0:0.01:tf ;
Radius = 10 ;
omega1 = 0.3 ;
x = -10 + Radius*cos(omega1*t1)  ;
y = Radius*sin(omega1*t1)  ;
z = 0.5*t1 ;
x_dot = zeros(size(t1)) ;
y_dot = zeros(size(t1)) ;
z_dot = zeros(size(t1))  ;
position_speed_ref = timeseries([ x; y ; z; x_dot ; y_dot ; z_dot], t1) ;
position_ref = timeseries([ x; y ; z], t1) ;
vector_psi_ref = timeseries(0.2*ones(size(x)), t1) ;
speed_ref = timeseries([ diff(x); diff(y) ; diff(z)], t1(1:end-1)) ;
figure() ;
plot3(x,y,z) ; grid on ; title("Reference trajectory") ;
xlabel("x (m)") ; ylabel("y (m)") ; zlabel("z (m)") ;


%%% Simulation -----------------------------------------------------------
sim("STUDENTS_UAV_SIMULATOR.slx", tf) ;


simout_x_ref = pos_speed_simout.Data(:,1) ;
simout_y_ref = pos_speed_simout.Data(:,2) ;
simout_z_ref = pos_speed_simout.Data(:,3) ;
simout_x = pos_speed_simout.Data(:,4) ;
simout_y = pos_speed_simout.Data(:,5) ;
simout_z = pos_speed_simout.Data(:,6) ;



figure() ;
sgtitle("Trajectory tracking, X4 nonlinear model") 
subplot 121 ;
plot3(simout_x_ref, simout_y_ref, simout_z_ref) ; grid on ; 
hold on ;
plot3(simout_x, simout_y, simout_z) ;
legend("Reference trajectory", "Simulated X4 trajectory") ;
subplot 222 ;
plot(simout_x_ref, simout_y_ref) ;title("Plan (x,y)") ; grid on ; 
hold on ;
plot(simout_x, simout_y) ;
legend("Reference trajectory", "Simulated X4 trajectory") ;
subplot 224 ;
plot(simout_x_ref, simout_z_ref) ; grid on ; title("Plan (x,z)") ;
hold on ;
plot(simout_x, simout_z) ;
legend("Reference trajectory", "Simulated X4 trajectory") ;