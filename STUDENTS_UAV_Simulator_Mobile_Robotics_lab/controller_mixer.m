function PWMi = controller_mixer(input)
    global Mx Kv_motor Kv_motor_rad U_sat Mx_controller_mixer
        
    Mx_inv = inv(Mx) ;
    Gamma_c = input(1:3) ;
    Thrust = input(4) ;
    Command = [Thrust; Gamma_c] ;
    Wi_des = sqrt(abs((Mx_inv*Command))) ;
    
    Wi_max = U_sat*Kv_motor_rad ;
    PWM1 = floor(PWM_data_map(0, Wi_max, 1000, 2000, Wi_des(1))) ;
    PWM2 = floor(PWM_data_map(0, Wi_max, 1000, 2000, Wi_des(2))) ;
    PWM3 = floor(PWM_data_map(0, Wi_max, 1000, 2000, Wi_des(3))) ;
    PWM4 = floor(PWM_data_map(0, Wi_max, 1000, 2000, Wi_des(4))) ;

    PWMi = [PWM1 PWM2 PWM3 PWM4] ;
end

