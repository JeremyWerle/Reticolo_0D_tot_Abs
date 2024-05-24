%% Reticolo Slovenian

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

[N,Lam,My_Param.wave]=Wavelength();

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
%*************************************************************
%            Definition of the incoherent layers
%*************************************************************
my_plot=1;
thres=0.21;
thres2=1e4;
thres3=Lam;
[DH,WDH,INC,C,idx,Dp,Dp2,Dp3,Kp,Cpx_mod]=Whos_Incoherent4(My_Param,thres,my_plot,thres2, thres3);

%%
tic;
for j=1:N
%     j
    NN=rand(1,length(material_list));
    for k=1:length(material_list)
        a(k)=Cpx_mod(j,k);
    end
    % end
    % retabeles([n_SiO2,n_Si3N4,n_Si],@(ld) getrefractiveindex_mod_nv('SiO2_ref_index.txt',ld),@(ld) getrefractiveindex_mod_nv('Si3N4_ref_index.txt',ld),@(ld) getrefractiveindex_mod_nv('Si_ref_index.txt',ld));
%     retabeles(NN,a{:});

    % 1st simulation with d'
    [r_TE(j),t_TE(j)]=retabeles(0,[1 Cpx_mod(j,:) 1],Dp(j,:),0,2*pi./Lam(j));
    [r_TM(j),t_TM(j)]=retabeles(2,[1 Cpx_mod(j,:) 1],Dp(j,:),0,2*pi./Lam(j));

    % 2nd simulation with d"
    [r_TE2(j),t_TE2(j)]=retabeles(0,[1 Cpx_mod(j,:) 1],Dp2(j,:),0,2*pi./Lam(j));
    [r_TM2(j),t_TM2(j)]=retabeles(2,[1 Cpx_mod(j,:) 1],Dp2(j,:),0,2*pi./Lam(j));
    % [r_TE,t_TE]=retabeles(0,[1,n_SiO2,n_Si3N4,n_Si,1],[h.SiO2,h.Si3N4,h.Si],0,2*pi./Lam);
    % [r_TM,t_TM]=retabeles(2,[1,n_SiO2,n_Si3N4,n_Si,1],[h.SiO2,h.Si3N4,h.Si],0,2*pi./Lam);

    Rss1(j)=abs(r_TE(j)).^2;
    Rpp1(j)=abs(r_TM(j)).^2;
    Tss1(j)=abs(t_TE(j)).^2;
    Tpp1(j)=abs(t_TM(j)).^2;

    Rup1(j)=(Rss1(j)+Rpp1(j))/2;
    Tup1(j)=(Tss1(j)+Tpp1(j))/2;
    Abs1(j)=1-(Rup1(j)+Tup1(j));

    
    Rss2(j)=abs(r_TE2(j)).^2;
    Rpp2(j)=abs(r_TM2(j)).^2;
    Tss2(j)=abs(t_TE2(j)).^2;
    Tpp2(j)=abs(t_TM2(j)).^2;

    Rup2(j)=(Rss2(j)+Rpp2(j))/2;
    Tup2(j)=(Tss2(j)+Tpp2(j))/2;
    Abs2(j)=1-(Rup2(j)+Tup2(j));

    Rup(j)=(Rup1(j)+Rup2(j))/2;
    Tup(j)=(Tup1(j)+Tup2(j))/2;
    Abs(j)=(Abs1(j)+Abs2(j))/2;
    clear a NN
end

toc
%% Other code gives same results but take more time 
% pol=0;
% tic;
% for j=1:N
% % for pol=[0,2]%0 TE 2 TM
%     k0=2*pi./Lam(j);
% 
%     res0_0D(pol,k0,teta*pi/180,1);
% 
%     a_Air=res1_0D(1);
%    
%     for k=1:length(material_list)
%         a{k}=res1_0D(Cpx_mod(j,k));
%     end
%     
%     % For the simulation with d'
%     s{1}=res2_0D(a{1},Dp(j,1));
%     S=s{1};
%     % For simulation with d"
%     s2{1}=res2_0D(a{1},Dp2(j,1));
%     S2=s2{1};
%     
%     for k=2:length(material_list)
%         % For the simulation with d'
%         s{k}=res2_0D(a{k},Dp(j,k));
%         S=S*s{k};
%         % For simulation with d"
%         s2{k}=res2_0D(a{k},Dp2(j,k));%-abs(Lam(j)/(4*My_Param.material.Cpx.(material_list(k))(j))));
%         S2=S2*s2{k};
%     end
% 
%     result{j}=res2_0D(S, a_Air, a_Air);
%     R(j)=result{j}.inc_top_reflected.efficiency;
%     T(j)=result{j}.inc_top_transmitted.efficiency;
%     Pertes=1-R(j)-T(j);
% 
%     result2{j}=res2_0D(S2, a_Air, a_Air);
% 
%     R2(j)=result2{j}.inc_top_reflected.efficiency;
%     T2(j)=result2{j}.inc_top_transmitted.efficiency;
%     Pertes=1-R2(j)-T2(j);
% 
% end
% R_f=(R+R2)/2;
% T_f=(T+T2)/2;
% Abs3=1-(T_f+R_f);
% toc

%% Figure without averaging
figure;
hold on;
plot(Lam,Rup,'LineWidth',2);
plot(Lam,Tup,'LineWidth',2);
plot(Lam,Abs,'LineWidth',2);
legend('R','T','Abs')
title('Solar cell spectrum WITHOUT averaging')
xlabel('wavelength \mum')

%% saving
save('Reticolo_0D_Abs_tot_slovenian_new_solar_cell.mat')

