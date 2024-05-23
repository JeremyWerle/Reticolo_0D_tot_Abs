%% Reticolo Incoherent OD

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

delta_lam=0.1;
[dlam,wdlam]=retgauss(-delta_lam,delta_lam,10,100);
wdlam=wdlam.*exp(-(2*dlam/delta_lam).^2);
wdlam=wdlam/sum(wdlam);
[ddlam,LLam0]=ndgrid(dlam,Lam0);
Lam=LLam0+ddlam;
Lam=Lam(:);

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

%%
% %*************************************************************
% %            Definition of the incoherent layers
% %*************************************************************

tic;
NN=rand(1,length(material_list));
for k=1:length(material_list)
    a{k}=@(ld) Import_Material(material_list(k),ld, 0,0);
end
% end
% retabeles([n_SiO2,n_Si3N4,n_Si],@(ld) getrefractiveindex_mod_nv('SiO2_ref_index.txt',ld),@(ld) getrefractiveindex_mod_nv('Si3N4_ref_index.txt',ld),@(ld) getrefractiveindex_mod_nv('Si_ref_index.txt',ld));
retabeles(NN,a{:});

[r_TE,t_TE]=retabeles(0,[1,NN,1],My_Param.material.thickness,0,2*pi./Lam);
[r_TM,t_TM]=retabeles(2,[1,NN,1],My_Param.material.thickness,0,2*pi./Lam);
% [r_TE,t_TE]=retabeles(0,[1,n_SiO2,n_Si3N4,n_Si,1],[h.SiO2,h.Si3N4,h.Si],0,2*pi./Lam);
% [r_TM,t_TM]=retabeles(2,[1,n_SiO2,n_Si3N4,n_Si,1],[h.SiO2,h.Si3N4,h.Si],0,2*pi./Lam);

Rss=abs(r_TE).^2;
Rpp=abs(r_TM).^2;
Tss=abs(t_TE).^2;
Tpp=abs(t_TM).^2;

Rup=(Rss+Rpp)/2;
Tup=(Tss+Tpp)/2;
Abs=1-(Rup+Tup);

Rup=reshape(Rup,size(LLam0));
Rup0=(wdlam*Rup)/sum(wdlam);
Tup=reshape(Tup,size(LLam0));
Tup0=(wdlam*Tup)/sum(wdlam);
Abs=reshape(Abs,size(LLam0));
Abs0=(wdlam*Abs)/sum(wdlam);
toc
%% Figure with averaging
figure;
hold on;
plot(Lam0,Rup0,'LineWidth',2);
plot(Lam0,Tup0,'LineWidth',2);
plot(Lam0,Abs0,'LineWidth',2);
legend('R','T','Abs')
title('Solar cell spectrum with averaging')
xlabel('wavelength \mum')
%% Figure without averaging
figure;
hold on;
plot(Lam,Rup(:),'LineWidth',2);
plot(Lam,Tup(:),'LineWidth',2);
plot(Lam,Abs(:),'LineWidth',2);
legend('R','T','Abs')
title('Solar cell spectrum WITHOUT averaging')
xlabel('wavelength \mum')

%% saving
save('Reticolo_0D_Abs_tot_incoherent_new_solar_cell.mat')

