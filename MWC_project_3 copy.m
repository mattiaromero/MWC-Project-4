%% Chapter 4 Theoretical study
%Plot the evolution of the wave length L as a function depth h for the
%following three periods : T = 6 s, T = 9 s and T = 12 s.

T = [6, 9, 12];
h = linspace(0,140,281);
figure (1);
L = [];
k = [];
g = 9.81;
for j = 1:length(h)
    for i=1:3        
        k(i,j) = k_fun(T(i),h(j));
        L(i,j) = (2*pi)/k(i,j);
        c(i,j) = phase_fun(T(i),h(j));
        c_g(i,j) = group_fun(T(i),h(j));
    end
end
plot(h,L);
xlabel('Depth (m)');
ylabel('Wavelength (m)');
legend('T = 6s',' T = 9s',' T = 12s');

figure (2);
plot(h,h./L(1,:));
xlabel('Depth (m)');
ylabel('h/L');
hold on;
plot(h,h./L(2,:));
plot(h,h./L(3,:));
S = linspace(0.05,0.05,281);
D = linspace(0.5,0.5,281);
plot(h,S,'k','LineWidth',1);
plot(h,D,'k','LineWidth',1);
legend('T = 6s',' T = 9s',' T = 12s','Shallow Water Threshold','Deep Water Threshold');



%% Theoretical c values:
c_t = sqrt(g*h);

figure(3);

subplot(2,1,1);
plot(h,c);
hold on;
plot(h,c_t);
ylabel('celerity (m/s)');
legend('T = 6s',' T = 9s',' T = 12s','$\sqrt{gh}$','Interpreter','latex');

subplot(2,1,2);
plot(h,c_g);
hold on;
plot(h,c_t);
ylabel('celerity (m/s)');
xlabel('Depth (m)');
legend('T = 6s',' T = 9s',' T = 12s','$\sqrt{gh}$','Interpreter','latex');

%% Egmond dataset

data = load('MeanWaterDepth.txt');
Tt = [7.58, 6.69, 5.54];
hm = data;

for j = 1:3 %columns
    for i=1:5 %rows        
        km(i,j) = k_fun(Tt(j),hm(i,j));
        Lm(i,j) = (2*pi)/km(i,j);
    end
end
%% Blah
ratio = hm./Lm;
for j = 1:3 %columns
    for i=1:5 %rows
        if ratio(i,j) <=0.05
            disp('Shallow')
            display(hm(i,j));
                
        elseif (ratio(i,j) >0.05) || (ratio(i,j)<0.5) 
            disp('Intermediate')
            display(hm(i,j));
                
        else
            disp('Deep')
            display(hm(i,j));
        end   
    end
end

%display(ratio);







