function [df_interest_sovereign_all] = df_sovereign_unweighted_all(country, boot, num_boot)

% Merge redenom data files together 
df_interest_sovereign_all=[];

% Estimation, loop over countries
% Output is df_interest_sovereign_all

for k=1
 % Construct the file path using the k-th element of the country array
data = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/Sov_CDS/data_%s_sovereign_bonds_2020.mat', country{k});
% Load the .mat file
load(data);
K=size(coupon_all,1);
T=size(price,1);
disp(T);
disp(K);
%df_interest_sovereign=estimation_mcculloch_unweighted_woCDS(price, coupon_all, dtm, K, T, boot, num_boot);
                                            
df_interest_sovereign=estimation_mcculloch_unweighted_CDS(price, coupon_all, dtm, cdspremia, cds_initial, K, T, boot, num_boot);
                                            

if boot==0
    df_interest_sovereign_all=[df_interest_sovereign_all; df_interest_sovereign];
elseif boot==1
    df_interest_sovereign_all=[df_interest_sovereign_all; df_interest_sovereign];
end

end 
end