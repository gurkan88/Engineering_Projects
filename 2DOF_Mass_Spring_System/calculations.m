%%% 2 DOF Spring Mass System

global m1 m2 k1 k2 k3 w1 w2 r1 r2 x11 x21 x12 x22 t x1_loc x2_loc

% [m1, m2, k1, k2, k3] = deal(1, 2, 1.5, 2, 2.5) ;  % test

% random values for m mass, k spring constant
m1 = [1; 2; 1.5; 0.5; 0.8; 2; 1.4; 1.6; 1.8; 2.5] ;
m2 = [1; 1; 0.5; 1.5; 1; 2; 0.8; 2.5; 0.9; 2]     ;
k1 = [1; 1.2; 1.4; 1.6; 2; 2; 2.3; 2.1; 2; 1]     ;
k2 = [1; 1.2; 1.6; 2.5; 1.5; 1.4; 2.3; 2.5; 1.8; 1.5] ;
k3 = [1; 2; 1.6; 2.5; 1; 1.5; 2; 1.5; 2; 2]         ;

% natural frequency w1 and w2 for two modes
w1 =    (sqrt( k1./m1 + ...
        sqrt( (-m1.*k2-m1.*k2-m2.*k2-m2.*k1).^2 -4.*(k1.*k2 + k1.*k3 + k2.*k3))./(m1.*m2) ...
        + k2./m1 + k2./m2 + k3./m2 ) )/sqrt(2) ;


w2 =    -(sqrt( k1./m1 + ...
        sqrt( (-m1.*k2-m1.*k2-m2.*k2-m2.*k1).^2 -4.*(k1.*k2 + k1.*k3 + k2.*k3))./(m1.*m2) ...
        + k2./m1 + k2./m2 + k3./m2 ) )/sqrt(2) ;


% amplitude ratio r1 and r2 for two modes
r1 =    ( sqrt( (-m1.*k2-m1.*k2-m2.*k2-m2.*k1).^2 -4.*(k1.*k2 + k1.*k3 + k2.*k3))./(m1.*m2)...
        + m2.*k1 + m2.*k2 - m1.*k2 - m1.*k3)./(2.*m2.*k2) ;
    

r2 =    ( sqrt( (-m1.*k2-m1.*k2-m2.*k2-m2.*k1).^2 -4.*(k1.*k2 + k1.*k3 + k2.*k3))./(m1.*m2)...
        + 3.*m2.*k1 + 3.*m2.*k2 - m1.*k2 - m1.*k3)./(2.*m2.*k2) ;
    

t   =   (0:0.1:10) ;            % t is time in seconds
x1_loc = 0  ;                   % x1_loc is the location of x1
x2_loc = -2.5  ;                   % x2_loc is the location of x2

x11 = x1_loc + r1 .* sin(w1.*t)  ;      % x11 and x21 are displacement for Mode 1

x21 = x2_loc + 1 .* sin(w1.*t)   ;      % Amplitude 2 is taken as 1 
                                        % so Amplitude 1 equals the r1 amplitude ratio A1/A2

    
x12 = x1_loc + r2 .* sin(w2.*t)  ;      % x12 and x22 are displacement for Mode 2

x22 = x2_loc + 1 .* sin(w2.*t)   ;
   

%% GRAPH for 10 DIFFERENT VALUES
i = 1   ;
    
while i < 11
    
    x11 =   x1_loc + r1(i,1) * sin(w1(i,1).*t) ;
    x21 =   x2_loc + 1 * sin(w1(i,1).*t) ;
    
    x12 =   x1_loc + r2(i,1) * sin(w2(i,1).*t)  ;   
    x22 =   x2_loc + 1 .* sin(w2(i,1).*t)    ;

    figure
    graph = tiledlayout(2,1);
    
    nexttile
    
    plot(t, x11, 'r-') ;
    hold on 
    plot(t, x21, 'b-') ;

    hold off
    legend('Mass 1 (X1)','Mass 2 (X2)')
    
    title({sprintf('Measurement %i', i);'Mode 1'})
    xlabel('Time (sec)')
    ylabel('Displacement (m)')


    nexttile
    
    plot(t, x12, 'r-') ;
    hold on 
    plot(t, x22, 'b-') ;
    
    title('Mode 2')
    xlabel('Time (sec)')
    ylabel('Displacement (m)')
    
    hold off
    legend('Mass 1 (X1)','Mass 2 (X2)')
    
    i = i + 1 ;
end
