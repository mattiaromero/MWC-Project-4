%% Chapter 5 


% Main script for the computation of the cross-shore wave evolution 
% for a simplified bar-trough case based on the Battjes and Janssen (1978)
% model. Computation of wave characteristics for the Egomnd data.

%------------------------------------
%           Initialisation
%------------------------------------

clear all;
close all;

prof=load('prof1018.txt');
MeanWaterDepth=load('MeanWaterDepth.txt');

% Definition of cross-shore coordinates (m)
x = prof(:,1);  

% Definition of zb, bed elevation relative to mean water level (m)
zb = prof(:,2);   

% Definition of the array profile, input argument for BJmodel
profile = [x zb];

% Offshore wave conditions
H13 = [1.70 2.25 1.69]; % Significant wave height (m), needed to calculate Hrms0
Hrms0=sqrt(H13); % Root mean square wave height (m)
theta0 = [-36 39 36];     % Angle of incidence (degrees)
T0 = [7.58 6.69 5.54];        % Characteristic period (s)
Zeta = [-0.45 0.09 0.91];       % Mean water level (m)

% Model parameter 
hmin = 0.2;     % Minimal water depth for computation
                % (we stop the computation when h<hmin)

%------------------------------------------------
%       Computation of wave characteristics
%------------------------------------------------

for i=1:3
    waves(i) = BJmodel(Hrms0(i),T0(i),Zeta(i),theta0(i),profile,hmin);
end


%loading statistics from chapter 2
data=load('StatisticsEgmond.mat','Hm_tot','Hrms_tot','H13_tot');
position=[4478 4765 4790 4814 4835];

%------------------------------------
%           Visualisation 
%------------------------------------

figure;
% Low tide
subplot(4,1,1); 
plot(waves(1).x,waves(1).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,1),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]); 

% Mid tide
subplot(4,1,2); 
plot(waves(2).x,waves(2).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,2),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]); 

% High tide
subplot(4,1,3); 
plot(waves(3).x,waves(3).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,3),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]);  

% Bed profile and mean water depth for each sensor at each tide
subplot(4,1,4); 
plot(profile(:,1),profile(:,2));
hold on; 
scatter(position,MeanWaterDepth(:,1),'o');
scatter(position,MeanWaterDepth(:,2),'o');
scatter(position,MeanWaterDepth(:,3),'o');
legend('Bedform','Low tide','Mid tide','High tide');
hold on; 
ylabel('Bedform (m)');
xlabel('x (m)');
xlim([4400 5000]); 


%% Interpolation
% Estimation of the modelled wave heights at the exact location of the sensors for each tide using the interpolation function

for i=1:3
    interpolation(:,i)=interp1(profile(:,1),waves(i).Hrms, position);
end

% difference between modelled and observed (not specifically asked in the
% exercise, but I added it here)
difference= interpolation-data.Hrms_tot;

%% Root mean square error
% Computation of the root mean square error between observed and modelled
% wave heights (Hrms) at each tide.

erms=zeros(1,3);
for i=1:3
    erms(i)=root_mean_square_error(interpolation(:,i),data.Hrms_tot(:,i));
end 

