function Euler_123_dot = Euler_123_dot_from_angular_speeds(input) 
    % input = [phi theta psi p q r] ;
    phi = input(1) ; 
    theta = input(2) ;
    psi = input(3) ;
    p = input(4) ;
    q = input(5) ;
    r = input(6) ;
    phi_dot = p + sin(phi)*tan(theta)*q + cos(phi)*tan(theta)*r ;
    theta_dot = cos(phi)*q - sin(phi)*r ;
    psi_dot =(sin(phi)/cos(theta))*q + (cos(phi)/cos(theta))*r ;
    
    Euler_123_dot = [phi_dot theta_dot psi_dot] ;
end