
%% declarations
cT = 1.3529e-06 ;
cQ = 2.1113*1e-08 ;
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
Kv_motor = 1750 ;
Kv_motor_rad = Kv_motor*2*pi/60 ;
km = 1/Kv_motor_rad ;
Jr = 1.2991*1e-05 ;
R = 0.07 ;
U_sat = 12 ;
Mx = [  cT cT cT cT ;
        -cT*lp cT*lp cT*lp -cT*lp ;
        -cT*lp -cT*lp cT*lp cT*lp ;
        cQ -cQ cQ -cQ ] ;

%% Dynamic system
A = [0 0 0 1 0 0 0 0 0 0 0 0; %1
     0 0 0 0 1 0 0 0 0 0 0 0; %2
     0 0 0 0 0 1 0 0 0 0 0 0; %3
     0 0 0 0 0 0 0 g 0 0 0 0; %4
     0 0 0 0 0 0 -g 0 0 0 0 0; %5
     0 0 0 0 0 0 0 0 0 0 0 0; %6
     0 0 0 0 0 0 0 0 0 1 0 1; %7
     0 0 0 0 0 0 0 0 0 0 1 0; %8
     0 0 0 0 0 0 0 0 0 0 1 1; %9
     0 0 0 0 0 0 0 0 0 0 (Iz-Iy)/Ix (Iz-Iy)/Ix; %10
     0 0 0 0 0 0 0 0 0 (Ix-Iz)/Iy 0 (Ix-Iz)/Iy; %11
     0 0 0 0 0 0 0 0 0 (Iy-Ix)/Iz (Iy-Ix)/Iz 0; %12   
    ];

B = [ 0 0 0 0;
    0 0 0 0;
    0 0 0 0;
    0 0 0 0;
    0 0 0 0;
    0 0 0 1/m;
    0 0 0 0;
    0 0 0 0;
    0 0 0 0;
    1/Ix 0 0 0;
    0 1/Iy 0 0;
    0 0 1/Iz 0;
    ];
helix = [];
Xeq =  [100 100 100 0 0 0 0 0 0 0 0 0];
Xref = [100 100 100 0 0 0 ];

%% Position velocity
Apv = [ 0 0 0 1 0 0;
        0 0 0 0 1 0;
        0 0 0 0 0 1;
        0 0 0 0 0 0;
        0 0 0 0 0 0;
        0 0 0 0 0 0;
    ];
Bpv = [ 0 0 0 0;
        0 0 0 0;
        0 0 0 0;
        0 g 0 0;
        -g 0 0 0;
        0 0 0 1/m;
    ];
Qpv = [1 0 0 0 0 0;
       0 1 0 0 0 0;
       0 0 1 0 0 0;
       0 0 0 50 0 0;
       0 0 0 0 50 0;
       0 0 0 0 0 50];
Rpv = [20 0 0 0;
       0 20 0 0;
       0 0 1 0;
       0 0 0 1];
   
[Kpv,S,E] = lqr(Apv,Bpv,Qpv,Rpv);

%% Angle velocity
Aang = zeros(3,3);
Bang = [1/Ix 0 0;
        0 1/Iy 0;
        0 0 1/Iz;
        ];
Qang = [1 0 0;
       0 1 0;
       0 0 1];
Rang = [0.05 0 0;
       0 0.05 0;
       0 0 0.05];
[Kang,S,E] = lqr(Aang,Bang,Qang,Rang);
    
%% Euler angles
Aeu = zeros(3,3);
Beu = eye(3);
Qeu = [1 0 0;
       0 1 0;
       0 0 1];
Reu = [1 0 0;
       0 1 0;
       0 0 1];
[Keu,S,E] = lqr(Aeu,Beu,Qeu,Reu);

