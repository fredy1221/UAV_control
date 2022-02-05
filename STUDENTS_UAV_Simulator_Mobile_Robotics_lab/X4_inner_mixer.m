function output = X4_inner_mixer(input)
    global Mx  
    
    W1 = input(1) ;
    W2 = input(2) ;
    W3 = input(3) ;
    W4 = input(4) ;
    
    Wi = [W1 W2 W3 W4]' ; 
    Command = Mx*Wi.^2 ;
    Thrust = Command(1) ;
    Gamma_c = Command(2:4) ;
    
    output = [Gamma_c' Thrust] ; 
end

