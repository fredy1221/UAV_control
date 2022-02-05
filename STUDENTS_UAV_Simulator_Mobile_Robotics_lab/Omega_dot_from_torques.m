function Omega_dot = Omega_dot_from_torques(input) 
    % Input = [p q r Gamma_p Gamma_q Gamma_r] ;
    global J cT cR L m Ix Iy Iz 

    p = input(1) ;
    q = input(2) ;
    r = input(3) ;
    Gamma_p = input(4) ;
    Gamma_q = input(5) ;
    Gamma_r = input(6) ;

    p_dot = ((Iy-Iz)/Ix)*q*r + Gamma_p/Ix ;
    q_dot = ((Iz-Ix)/Iy)*p*r + Gamma_q/Iy ;
    r_dot = ((Ix-Iy)/Iz)*p*q + Gamma_r/Iz ;
    
    Omega_dot = [p_dot q_dot r_dot] ;
end
