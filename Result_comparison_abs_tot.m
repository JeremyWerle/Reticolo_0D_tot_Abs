%% Result comparison between Abs_tot

clear all
close all
set(0, 'DefaultLineLineWidth', 2);

clc
name='perso';

path_simu='H:\2_Scolarite\4_These\4_Simulations\RCWA\Reticolo\V9\simulations';
path_save='H:\2_Scolarite\4_These\4_Simulations\RCWA\Reticolo\V9\simulations\New solar cell reference\New_solar_cell_Wihtout_patern_Cr_layer_theta_0';
addpath(genpath(path_simu));
Initialisation(name, path_simu)

%*************************************************************
%                 Load Previous results
%*************************************************************

a=load("Reticolo_0D_Abs_tot_incoherent_new_solar_cell");
b=load("Reticolo_0D_Abs_tot_coherent_new_solar_cell.mat");
c=load("Reticolo_0D_Abs_tot_slovenian_new_solar_cell.mat");

%% Error in the Solar from lam(1) untill Lam=2.5 µm
% Error with respect to the coherent simulation
[~,idx]=min(abs(a.Lam0-2.5))
Rel_diff_Abs=abs(b.Abs(1:idx)-a.Abs0(1:idx))/a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(b.Rup((1:idx))-a.Rup0(1:idx))/a.Rup0(1:idx)*100;
Abs_diff_Abs=abs(b.Abs(1:idx)-a.Abs0(1:idx)')*100;%/a.Abs0(1:idx)*100;
Abs_diff_Refl=abs(b.Rup((1:idx))-a.Rup0(1:idx)')*100;%/a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and coherent')
std(Max_diff_Refl)

figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Abs)
plot(a.Lam0(1:idx),Abs_diff_Abs,'--')
plot(a.Lam0(1:idx),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and coherent')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(b.Lam(1:idx),b.Abs(1:idx))
plot(a.Lam0(1:idx),a.Abs0(1:idx))
legend("Coherent","Incoherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(b.Lam(1:idx),b.Rup(1:idx))
plot(a.Lam0(1:idx),a.Rup0(1:idx))
legend("Coherent","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs coherent')
%% Error with respect to the movmean simulation
[~,idx]=min(abs(a.Lam0-2.5))
Rel_diff_Abs=abs(b.Mov_Abs(1:idx)-a.Abs0((1:idx)))/a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(b.Mov_Rup((1:idx))-a.Rup0(1:idx))/a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);

Abs_diff_Abs=abs(b.Mov_Abs(1:idx)-a.Abs0(1:idx)')*100;%/a.Abs0(1:idx)*100;
Abs_diff_Refl=abs(b.Mov_Rup((1:idx))-a.Rup0(1:idx)')*100;%/a.Rup0(1:idx)*100;
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and coherent averaging')

std(Max_diff_Refl)
figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Abs)
plot(a.Lam0(1:idx),Abs_diff_Abs,'--')
plot(a.Lam0(1:idx),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and coherent averaging')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(b.Lam(1:idx),b.Mov_Abs(1:idx))
plot(a.Lam0(1:idx),a.Abs0(1:idx))
legend("Coherent averaging","Incoherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(b.Lam(1:idx),b.Mov_Rup(1:idx))
plot(a.Lam0(1:idx),a.Rup0(1:idx))
legend("Coherent averaging","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs coherent averaging')
%% Error with respect to the slovenian simulation
% [~,idx]=min(abs(a.Lam0-2.5))
close all
Rel_diff_Abs=abs(c.Abs(1:idx)-a.Abs0((1:idx)))./a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(c.Rup((1:idx))-a.Rup0(1:idx))./a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);

Abs_diff_Abs=abs(c.Abs(1:idx)-a.Abs0(1:idx))*100;%/a.Abs0(1:idx)*100;
Abs_diff_Refl=abs(c.Rup((1:idx))-a.Rup0(1:idx))*100;%/a.Rup0(1:idx)*100;
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and slovenian')

figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Abs)
plot(a.Lam0(1:idx),Abs_diff_Abs,'--')
plot(a.Lam0(1:idx),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and slovenian')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(c.Lam(1:idx),c.Abs(1:idx))
plot(a.Lam0(1:idx),a.Abs0(1:idx))
legend("Slovenian","Incoherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(c.Lam(1:idx),c.Rup(1:idx))
plot(a.Lam0(1:idx),a.Rup0(1:idx))
legend("Slovenian","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs Slovenian')
%%
figure;
hold on;
plot(b.Lam,b.Abs)
plot(b.Lam,b.Mov_Abs)
plot(c.Lam,c.Abs)
plot(a.Lam0,a.Abs0)
legend('Coherent','Move mean','Slovenian','Reference')
% xlim([a.Lam0(1) a.Lam0(idx)])
xlabel('Wavelength µm')
ylabel('Absorbance')

%% Error in the IR from 4 untill Lam(end)

% Error with respect to the coherent simulation
[~,idx2]=min(abs(a.Lam0-4))

Rel_diff_Abs=abs(b.Abs(idx2:end)-a.Abs0((idx2:end)))/a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(b.Rup((idx2:end))-a.Rup0(idx2:end))/a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);

Abs_diff_Abs=abs(b.Abs((idx2:end))-a.Abs0(idx2:end)')*100;%/a.Abs0((idx2:end))*100;
Abs_diff_Refl=abs(b.Rup(((idx2:end)))-a.Rup0(idx2:end)')*100;%/a.Rup0((idx2:end))*100;
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and coherent')

figure;
hold on
plot(a.Lam0((idx2:end)),Max_diff_Abs)
plot(a.Lam0((idx2:end)),Abs_diff_Abs,'--')
plot(a.Lam0((idx2:end)),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and coherent')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(b.Lam((idx2:end)),b.Abs((idx2:end)))
plot(a.Lam0((idx2:end)),a.Abs0((idx2:end)))
legend("Slovenian","coherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(b.Lam((idx2:end)),b.Rup((idx2:end)))
plot(a.Lam0((idx2:end)),a.Rup0((idx2:end)))
legend("Slovenian","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs Coherent')

%% Error with respect to the movmean simulation
[~,idx2]=min(abs(a.Lam0-4));
Rel_diff_Abs=abs(b.Mov_Abs(idx2:end)-a.Abs0((idx2:end)))/a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(b.Mov_Rup((idx2:end))-a.Rup0(idx2:end))/a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);

Abs_diff_Abs=abs(b.Mov_Abs((idx2:end))-a.Abs0((idx2:end))')*100;%/a.Abs0((idx2:end))*100;
Abs_diff_Refl=abs(b.Mov_Rup(((idx2:end)))-a.Rup0((idx2:end))')*100;%/a.Rup0((idx2:end))*100;
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and coherent averaging')

std(Max_diff_Refl)
figure;
hold on
plot(a.Lam0((idx2:end)),Max_diff_Abs)
plot(a.Lam0((idx2:end)),Abs_diff_Abs,'--')
plot(a.Lam0((idx2:end)),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and coherent averaging')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(b.Lam((idx2:end)),b.Mov_Abs((idx2:end)))
plot(a.Lam0((idx2:end)),a.Abs0((idx2:end)))
legend("Coherent averaging","Incoherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(b.Lam((idx2:end)),b.Mov_Rup((idx2:end)))
plot(a.Lam0((idx2:end)),a.Rup0((idx2:end)))
legend("Coherent averaging","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs Coherent averaging')
%% Error with respect to the slovenian simulation
[~,idx2]=min(abs(a.Lam0-4));
Rel_diff_Abs=abs(c.Abs(idx2:end)-a.Abs0((idx2:end)))./a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(c.Rup((idx2:end))-a.Rup0(idx2:end))./a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);

Abs_diff_Abs=abs(c.Abs((idx2:end))-a.Abs0((idx2:end)))*100;%/a.Abs0((idx2:end))*100;
Abs_diff_Refl=abs(c.Rup(((idx2:end)))-a.Rup0((idx2:end)))*100;%/a.Rup0((idx2:end))*100;
Max_diff_Abs=max(Abs_diff_Refl,Abs_diff_Abs);

figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
xlabel('Wavelength µm')
ylabel('Relative Error %')
title('Relative error in the Solar between incoherent and slovenian')
std(Max_diff_Refl)

figure;
hold on
plot(a.Lam0((idx2:end)),Max_diff_Abs)
plot(a.Lam0((idx2:end)),Abs_diff_Abs,'*')
plot(a.Lam0((idx2:end)),Abs_diff_Refl,'--')
yline(mean(Max_diff_Abs),'--k',LineWidth=2)
legend('Max absolute error','Absolute Error Abs','Absolute Error Rup','average')
xlabel('Wavelength µm')
ylabel('Absolute Error %')
title('Absolute error in the Solar between incoherent and slovenian')
std(Max_diff_Refl)

figure;
subplot(2,1,1)
hold on;
plot(c.Lam((idx2:end)),c.Abs((idx2:end)))
plot(a.Lam0((idx2:end)),a.Abs0((idx2:end)))
legend("Slovenian","Incoherent")
xlabel('Wavelength µm')
ylabel('Absorbance')
subplot(2,1,2)
hold on;
plot(c.Lam((idx2:end)),c.Rup((idx2:end)))
plot(a.Lam0((idx2:end)),a.Rup0((idx2:end)))
legend("Slovenian","Incoherent")
xlabel('Wavelength µm')
ylabel('Reflectance')
sgtitle('Incoherent Vs Slovenian')


%% Plot in the IR
figure;
hold on;
plot(b.Lam,b.Abs)
plot(b.Lam,b.Mov_Abs)
plot(c.Lam,c.Abs)
plot(a.Lam0,a.Abs0)
legend('Coherent','Move mean','Slovenian','Reference')
xlim([a.Lam0(idx2) a.Lam0(end)])
xlabel('Wavelength µm')
ylabel('Absorbance')