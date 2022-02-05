function W1_dot = motor1_speed_dot(input)

global cQ Jr km R Kv_motor Kv_motor_rad 

    W1 = input(1) ;
    U1 = input(2) ;

    
    W1_dot = -(km^2/(Jr*R))*W1 - (cQ/Jr)*abs(W1)*W1 + (km)/(Jr*R)*U1 ;
    
end

