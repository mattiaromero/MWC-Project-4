% Main script for the computation of the cross-shore wave evolution 
% for a simplified bar-trough case based on the Battjes and Janssen (1978) model 

%------------------------------------
%           Initialisation
%------------------------------------

clear all;
close all;

% Definition of cross-shore coordinates (m)
x = (1:1:500)';  

% Definition of zb, bed elevation relative to mean water level (m)
zb = -9 * ones(size(x));   
zb = zb + (x<=260).*(x-160)/20  + ((x<=300)&(x>260)).*(-1/40*(x-260) + 5) + (x>300).*(1/20*(x-300) + 4); 

% Definition of the array profile, input argument for BJmodel
profile = [x zb];

% Offshore wave conditions
Hrms0 = 1;      % Root mean square wave height (m)
theta0 = 0;     % Angle of incidence (degrees)
T0 = 10;        % Characteristic period (s)
Zeta = 0;       % Mean water level (m)

% Model parameter 
hmin = 0.2;     % Minimal water depth for computation
                % (we stop the computation when h<hmin)

%------------------------------------------------
%       Computation of wave characteristics
%------------------------------------------------


waves = BJmodel(Hrms0,T0,Zeta,theta0,profile,hmin);


%------------------------------------
%           Visualisation 
%------------------------------------

figure;
subplot(4,1,1); plot(waves.x,waves.Hrms)
title('Zeta =',num2str(Zeta(1)))

ylabel('Hrms (m)')
subplot(4,1,2); plot(waves.x,waves.z,'k')
hold on; plot(waves.x,Zeta*ones(size(x)),'-.')
ylim([0.5 1.5])
xlabel('x (m)')
ylabel('zb (m)')

%Adding the Dbr and Dissipation of the roller plots
subplot(4,1,3)
plot(waves.x,waves.Dbr)
xlabel('x (m)')
ylabel('Dbr (W/m^2)') 
ylim([0 250])
xlim([0 420])
%AND ADJUST Y AXIS!!!!

subplot(4,1,4)

plot(waves.x,waves.Dr)
xlabel('x (m)')
ylabel('Dr ((W/m^2))') 
ylim([0 300])
xlim([0 420])
%AND ADJUST Y AXIS!!!!

Zeta2 = [-1, 1]

for i=1:2
    %------------------------------------------------
    %       Computation of wave characteristics
    waves = BJmodel(Hrms0,T0,Zeta2(i),theta0,profile,hmin);
    %------------------------------------
    %           Visualisation 
    figure;
    subplot(4,1,1); plot(waves.x,waves.Hrms)
    title('Zeta =',num2str(Zeta2(i)))
    ylabel('Hrms (m)')
    ylim([0.5 1.5])
    subplot(4,1,2); plot(waves.x,waves.z,'k')
    hold on; plot(waves.x,Zeta*ones(size(x)),'-.')
    xlabel('x (m)')
    ylabel('zb (m)')
    
    %Adding the Dbr and Dissipation of the roller plots
    subplot(4,1,3)
    plot(waves.x,waves.Dbr)
    xlabel('x (m)')
    ylabel('Dbr ((W/m^2))') 
    xlim([0 420])
    ylim([0 250])
    %AND ADJUST Y AXIS!!!!
    
    subplot(4,1,4)
    
    plot(waves.x,waves.Dr)
    xlabel('x (m)')
    ylabel('Dr ((W/m^2))') 
    ylim([0 300])
    xlim([0 420])
    %AND ADJUST Y AXIS!!!!


end






