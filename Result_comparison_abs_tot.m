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
Rel_diff_Abs=abs(b.Abs(1:idx)-a.Abs0((1:idx)))/a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(b.Rup((1:idx))-a.Rup0(1:idx))/a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)

%% Error with respect to the movmean simulation
[~,idx]=min(abs(a.Lam0-2.5))
Rel_diff_Abs=abs(b.Mov_Abs(1:idx)-a.Abs0((1:idx)))/a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(b.Mov_Rup((1:idx))-a.Rup0(1:idx))/a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')

std(Max_diff_Refl)

%% Error with respect to the slovenian simulation
% [~,idx]=min(abs(a.Lam0-2.5))
Rel_diff_Abs=abs(c.Abs(1:idx)-a.Abs0((1:idx)))./a.Abs0(1:idx)*100;
Rel_diff_Refl=abs(c.Rup((1:idx))-a.Rup0(1:idx))./a.Rup0(1:idx)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(1:idx),Max_diff_Refl)
plot(a.Lam0(1:idx),Rel_diff_Abs,'--')
plot(a.Lam0(1:idx),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)
%%
figure;
hold on;
plot(b.Lam,b.Abs)
plot(b.Lam,b.Mov_Abs)
plot(c.Lam,c.Abs)
plot(a.Lam0,a.Abs0)
legend('Coherent','Move mean','Slovenian','Reference')
%% Error in the IR from 4 untill Lam(end)

% Error with respect to the coherent simulation
[~,idx2]=min(abs(a.Lam0-4))

Rel_diff_Abs=abs(b.Abs(idx2:end)-a.Abs0((idx2:end)))/a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(b.Rup((idx2:end))-a.Rup0(idx2:end))/a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)

%% Error with respect to the movmean simulation
[~,idx2]=min(abs(a.Lam0-4));
Rel_diff_Abs=abs(b.Mov_Abs(idx2:end)-a.Abs0((idx2:end)))/a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(b.Mov_Rup((idx2:end))-a.Rup0(idx2:end))/a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')

std(Max_diff_Refl)

%% Error with respect to the slovenian simulation
[~,idx2]=min(abs(a.Lam0-4));
Rel_diff_Abs=abs(c.Abs(idx2:end)-a.Abs0((idx2:end)))./a.Abs0(idx2:end)*100;
Rel_diff_Refl=abs(c.Rup((idx2:end))-a.Rup0(idx2:end))./a.Rup0(idx2:end)*100;
Max_diff_Refl=max(Rel_diff_Refl,Rel_diff_Abs);
figure;
hold on
plot(a.Lam0(idx2:end),Max_diff_Refl)
plot(a.Lam0(idx2:end),Rel_diff_Abs,'--')
plot(a.Lam0(idx2:end),Rel_diff_Refl,'--')
yline(mean(Max_diff_Refl),'--k',LineWidth=2)
legend('Max relative error','Relative Error Abs','Relative Error Rup','average')
std(Max_diff_Refl)