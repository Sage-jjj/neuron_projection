clear
clc

Datapath1 = 'E:\Desk_old\BlueBrian\data\Weight_Network\Processing';
cd(Datapath1)
Data = xlsread('Data_L1-6.xlsx',3);
rat_measure = Data(:,5:46);
[rat_mr,rat_mp] = corrcoef(rat_measure);
 matrixplot1(rat_mr,'Mymap',CCmap,'DisplayOpt','off', 'Grid','on')

zrat_measure = zscore(rat_measure,0,1);

[coeff,score,latent,tsquared,explained,mu] = pca(zrat_measure);
[rat_rpca,rat_ppca] = corr(score(:,1:20)');

[rat_r,rat_p] = corrcoef(zrat_measure');
[rat_rr, rat_pp]= corrcoef(triu(rat_r,1),triu(rat_rpca,1));
       
% mouse 1741 neurons
Datapath2 ='E:\Desk_old\Mouse';
cd(Datapath2)
load raw_data.mat
mouse_measure1 = N_data';
[mouse_mr1,mouse_mp1] = corrcoef(mouse_measure1);
 matrixplot1(mouse_mr1,'Mymap',CCmap,'DisplayOpt','off', 'Grid','on')
 
zmouse_measure1 = zscore(mouse_measure1,0,1);

[coeff,score,latent,tsquared,explained,mu] = pca(zmouse_measure1);
[mouse_rpca,mouse_ppca] = corr(score(:,1:20)');

[mouse_r,mouse_p] = corrcoef(zmouse_measure1');
[mouse_rr, mouse_pp]= corrcoef(triu(mouse_r,1),triu(mouse_rpca,1));

% human 101 neurons
Datapath3 = 'E:\Desk_old\NewArtical';
cd(Datapath3)
load raw_data_human.mat
human_measure = data';
[human_mr,human_mp] = corrcoef(human_measure);

matrixplot1(human_mr,'Mymap',CCmap,'DisplayOpt','off', 'Grid','on')

zhuman_measure = zscore(human_measure,0,1);
[coeff,score,latent,tsquared,explained,mu] = pca(zhuman_measure);
[human_rpca,human_ppca] = corr(score(:,1:20)');

[human_r,human_p] = corrcoef(zhuman_measure');
[human_rr, human_pp]= corrcoef(triu(human_r,1),triu(human_rpca,1));

% mouse 572 neurons
Datapath4 = 'E:\Desk_old\Human_Mouse\mouse';
cd(Datapath4)
load raw_data.mat
mouse_measure2 = m_data';
[mouse_mr2,mouse_mp2] = corrcoef(mouse_measure2);

matrixplot1(mouse_mr2,'Mymap',CCmap,'DisplayOpt','off', 'Grid','on')

zmouse_measure2 = zscore(mouse_measure2,0,1);
[coeff,score,latent,tsquared,explained,mu] = pca(zmouse_measure2);
[mouse2_rpca,mouse2_ppca] = corr(score(:,1:20)');

[mouse2_r,mouse2_p] = corrcoef(zmouse_measure2');
[mouse2_rr, mouse2_pp]= corrcoef(triu(mouse2_r,1),triu(mouse2_rpca,1));
