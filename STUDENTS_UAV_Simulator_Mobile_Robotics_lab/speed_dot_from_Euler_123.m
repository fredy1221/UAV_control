function speed_dot = speed_dot_from_Euler_123(input)

global J cT cR L m Ix Iy Iz U_sat g with_flapping Kv
global   motor_speeds

% input=[1 1 1 1 [1 1 1] [1 1 1]]   
phi = input(1) ;
theta = input(2) ;
psi  = input(3) ;
Thrust = input(4) ;
 

if with_flapping == 1 
    
    linear_velocity = input(5:7)  ;
    angular_velocity = input(8:10) ;
    
%     R = rot_m(phi, theta, psi) ;
    R = rotation_matrix_from_Euler_123([phi theta psi]) ;
    R_flapping = compute_flapping(linear_velocity, angular_velocity, R, psi) ;
    accelerations = -g*[0 0 1]' + R*[0 0 Thrust/m]' ;
    x_dot_dot = accelerations(1) ;
    y_dot_dot = accelerations(2) ;
    z_dot_dot = accelerations(3) ;
    
else
    
    x_dot_dot = (Thrust/m)*(cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi)) ;
    y_dot_dot = (Thrust/m)*(cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi)) ;
    z_dot_dot = -g + (Thrust/m)*cos(theta)*cos(phi) ;
    
end

speed_dot = [x_dot_dot  y_dot_dot  z_dot_dot ] ;
end
