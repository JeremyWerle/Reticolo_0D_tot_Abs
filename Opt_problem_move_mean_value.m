%% Definition of the opt problem
%*************************************************************
%                       Initialsation
%*************************************************************
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
%                 Defintion of the wavelength
%*************************************************************

%input My_Param should contains:
% My_Param.wave.L_min.vis=0.31;%(by default): minium wavelength in the vis
% My_Param.wave.D_L.vis=0.01;%(by default): step between each wavelength in
% the vis
% My_Param.wave.L_min.IR=2.5;     %[um]
% My_Param.wave.L_max.IR=19;%(by default);      %[um]
% My_Param.wave.D_L.IR=0.1;%(by default);       %[um]

[N,Lam0,My_Param.wave]=Wavelength();

Lam=Lam0;

%%
%*************************************************************
%            Definition of the material structure
%*************************************************************
my_plot=1;
my_save=0;
% all_material_list=["Ag","Al","Al2O3","Cr","NIL","PMMA","PDMS","Si","Si3N4","SiO2","Soda_lime","TiO2","ZnO"];

% /!\ Materials should be in the good order /!\
material_list=["NIL","Si3N4","Si","Cr","Al"];
My_Param.material=Import_Structure_material(material_list,Lam,my_plot,my_save);
My_Param.material.thickness=[25 75*1e-3 500 3*1e-3 100*1e-3];

REF=load("Reticolo_0D_Abs_tot_incoherent_new_solar_cell.mat");
value=5;
Comp=Movmean_Reticolo_coherent(My_Param,value,REF)
%%
prob=optimproblem('Description','MoveMean'); % Problem name
value=optimvar('value','LowerBound',1,'UpperBound',100,'Type','integer');
x0.value=20;
% Movmean_Reticolo_coherent(My_Param,value,ref)
expr = fcn2optimexpr(@Movmean_Reticolo_coherent,My_Param,value,ref);
prob.Objective=expr;
    % comp=Spectrum_OD(My_Param,j,thres2,thres3,ref)
[sol,fval,exitflag,output,lambda] = solve(prob,x0)%,"Solver","surrogateopt");

%% 
save('Movemean_opt_results.mat')