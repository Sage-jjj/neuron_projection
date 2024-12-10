cd F:\11\suhui
load Region_id_neurons.mat
neuron_ind(320) = []; % exclude the neuron (region id: 4)
reg = unique(neuron_ind);

%% neuron projection to 87 regions
load Neuron_to_region_projection_87.mat
neuron_projection = data;

reg_projection = zeros(87,174);
for ireg = 1:length(reg)
    neuron_ireg = find(neuron_ind == reg(ireg));
    
    for jreg = 1:size(neuron_projection,2)
        
        tmp = neuron_projection(neuron_ireg,jreg);
        
        if sum(tmp) == 0
            reg_projection(ireg,jreg) = 0;
        else
            reg_projection(ireg,jreg) = sum(tmp(:))/length(find(tmp));
        end
    end
end

reg_projection_ipsi = reg_projection(:,1:87);
reg_projection_cont = reg_projection(:,88:end);
reg_projection_both = (reg_projection_cont + reg_projection_ipsi)/2;
reg_projection_both = reg_projection_both + reg_projection_both'/2;

save Region_to_region_projection_87.mat reg_projection_both

%% neuron mc
load Neuron_to_neuron_mc_threshold.mat
Wdata(320,:) = [];
Wdata(:,320) = [];
reg_mc_threshold = zeros(length(reg));

for ireg = 1:length(reg)-1
    neuron_ireg = find(neuron_ind == reg(ireg));
    
    for jreg = ireg:length(reg)
        neuron_jreg = find(neuron_ind == reg(jreg));
        
        tmp_threshold = Wdata(neuron_ireg,neuron_jreg);
        if sum(tmp_threshold(:)) == 0
            reg_mc_threshold(ireg,jreg) = 0;
        else
            reg_mc_threshold(ireg,jreg) = sum(tmp_threshold(:))/length(find(tmp_threshold));
        end
    end
end

reg_mc_threshold = reg_mc_threshold + triu(reg_mc_threshold,1)';
save Region_to_region_mc_threshold_87.mat reg_mc_threshold

%% comparison of mc between connections with and without projection: ttest and chi-square test
cd F:\11\suhui
load Region_to_region_projection_87.mat
load Region_to_region_mc_threshold_87.mat

ind_pre = find(triu(reg_projection_both));
tmp = reg_projection_both;
tmp(tmp == 0) = nan;
ind_abs = find(isnan(triu(tmp)));
[e, f, g, h] = ttest2(reg_mc_threshold(ind_pre),reg_mc_threshold(ind_abs));

Data(1,1) = sum(logical(reg_mc_threshold(ind_pre)));
Data(2,1) = length(ind_pre) - Data(1,1);
Data(1,2) = sum(logical(reg_mc_threshold(ind_abs)));
Data(2,2) = length(ind_abs) - Data(1,2);
[Chi2, Pval] = gretna_chi2test(Data);

%% relationship in the similarity of connectivity profiles between mc and projection
cd F:\11\suhui
load Region_to_region_projection_87.mat
load Region_to_region_mc_threshold_87.mat

% cosine similarity
for i = 1:86
    for j = i+1:87
        cs1(i,j) = gretna_cosinesimilarity(reg_projection_both(i,:),reg_projection_both(j,:));
        cs2(i,j) = gretna_cosinesimilarity(reg_mc_threshold(i,:),reg_mc_threshold(j,:));
    end
end

[~,v1] = gretna_mat2vec(cs1,'upper');
[~,v2] = gretna_mat2vec(cs2,'upper');

ind = find(isnan(v1));
v1(ind) = [];
v2(ind) = [];
[r p] = corr(v1,v2);
plot(v1,v2,'o')