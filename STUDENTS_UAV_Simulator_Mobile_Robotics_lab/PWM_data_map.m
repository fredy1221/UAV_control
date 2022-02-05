function output = PWM_data_map(low1, high1, low2, high2, single_data)

    pente = (high2 - low2)/(high1 - low1) ;
%     offset = low2 - pente*low1 ;
    
%     offset = (1 /(1 + low1/high1))*(low2 - low1*high2/high1) ;
    offset = (1/2)*(low2 + high2 - pente*(low1 + high1)) ;
    output_interm = pente*single_data + offset ;
    output = pente*single_data + offset ;
    if output_interm >= high2 
        output = high2 ;
    end
    if output_interm <= low2
        output = low2 ;
    end
       

end

