clear
clc

cd E:\Desk_old\Human_Mouse\permutation
load  h_data.mat
load  m_data.mat

sparsityh = 0.0927;
sparsitym = 0.0065;
Data1 = h_data;
Data2 = m_data;
Group_data = [Data1,Data2];

M = 10000;

for i_perm = 1:M
    Randnum = randperm(length(Group_data)); 
    
    Rand_index1 = Randnum(1:size(Data1,2));
    Rand_index2 = Randnum(size(Data1,2)+1:end);
    
    Rand_data1 = Group_data(:,Rand_index1);
    Rand_data2 = Group_data(:,Rand_index2);
    
    zRand_data1 = zscore(Rand_data1,0,2);
    [rand_r1,prand_p1] = corrcoef(zRand_data1);
    rand_r1 = gretna_R2b(rand_r1,'pos','s',sparsityh);
    
    [~, ~, sw_h] = gretna_sw_harmonic(rand_r1,100,1);
    [avergE_h, ~] = gretna_node_global_efficiency(rand_r1);
  
    Rand_Cp(i_perm,1) = sw_h.Cp;
    Rand_Rh.Lp(i_perm,1) = sw_h.Lp;
    Rand_Rh.Gamma(i_perm,1) = sw_h.Gamma;
    Rand_Rh.Lambda(i_perm,1) = sw_h.Lambda;
    Rand_Rh.Sigma(i_perm,1) = sw_h.Sigma;
    Rand_Rh.gE(i_perm,1) = avergE_h;
    Rand_Rh.cost_efficiency(i_perm,1) = avergE_h - sparsityh;

    zRand_data2 = zscore(Rand_data2,0,2);
    [rand_r2,prand_p2] = corrcoef(zRand_data2);
    rand_r2 = gretna_R2b(rand_r2,'pos','s',sparsitym);
    
    [~, ~, sw_m] = gretna_sw_harmonic(rand_r2,100,1);
    [avergE_m, ~] = gretna_node_global_efficiency(rand_r2);
  
    Rand_Rm.Cp(i_perm,1) = sw_m.Cp;
    Rand_Rm.Lp(i_perm,1) = sw_m.Lp;
    Rand_Rm.Gamma(i_perm,1) = sw_m.Gamma;
    Rand_Rm.Lambda(i_perm,1) = sw_m.Lambda;
    Rand_Rm.Sigma(i_perm,1) = sw_m.Sigma;
    Rand_Rm.gE(i_perm,1) = avergE_m;
    Rand_Rm.cost_efficiency(i_perm,1) = avergE_m - sparsitym;

end

save Rand1000.mat Rand_Rm Rand_Rh

