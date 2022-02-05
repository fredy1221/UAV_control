function Ui = X4_input_mixer(input)
    global Mx Kv_motor Kv_motor_rad U_sat 
    
    U1 = PWM_data_map(1000, 2000, 0, U_sat, input(1)) ;
    U2 = PWM_data_map(1000, 2000, 0, U_sat, input(2)) ;
    U3 = PWM_data_map(1000, 2000, 0, U_sat, input(3)) ;
    U4 = PWM_data_map(1000, 2000, 0, U_sat, input(4)) ;

    Ui = [U1 U2 U3 U4] ;
end

