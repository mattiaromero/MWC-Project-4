%% Chapter 5 


% Main script for the computation of the cross-shore wave evolution 
% for a simplified bar-trough case based on the Battjes and Janssen (1978) model 

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
% zb = zb + (x<=260).*(x-160)/20  + ((x<=300)&(x>260)).*(-1/40*(x-260) + 5) + (x>300).*(1/20*(x-300) + 4); 

% Definition of the array profile, input argument for BJmodel
profile = [x zb];

% Offshore wave conditions
H13 = [1.70 2.25 1.69]; 
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
%save('StatisticsEgmond_3','position','Hm_tot','Hrms_tot','H13_tot');

%------------------------------------
%           Visualisation 
%------------------------------------

figure;
subplot(4,1,1); %Low
plot(waves(1).x,waves(1).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,1),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]); 

subplot(4,1,2); 
plot(waves(2).x,waves(2).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,2),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]); 

subplot(4,1,3); 
plot(waves(3).x,waves(3).Hrms);
hold on;
scatter(position,data.Hrms_tot(:,3),'o');
legend('Model','Observations');
ylabel('Hrms (m)');
xlim([4400 5000]);  

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


%% interpolation

for i=1:3
    interpolation(:,i)=interp1(profile(:,1),waves(i).Hrms, position)
end



