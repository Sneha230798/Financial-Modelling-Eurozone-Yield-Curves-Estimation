function [df_interest_sovereign_all_sqrt] = df_sovereign_weighted_all(country, boot, num_boot)


% WLS
df_interest_sovereign_all_sqrt=[];

weightsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/wgts_normalized.xlsx');
% Load the .mat file
weights_sqrt = readmatrix(weightsFile);

for k=1
 % Construct the file path using the k-th element of the country array
data = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/All_Euro/data_%s_sovereign_bonds_cds_2020.mat', country{k});
% Load the .mat file
load(data);
K=size(coupon_all,1);
T=size(price,1);
disp(T);
disp(K);


% df_interest_sovereign_sqrt=estimation_mcculloch_weighted_woCDS(price, ...
% 												coupon_all, dtm, K, T, boot, num_boot, weights_sqrt);
                                            
df_interest_sovereign_sqrt=estimation_mcculloch_weighted_CDS(price, coupon_all, dtm, cdspremia,cds_initial, K, T, boot, num_boot, weights_sqrt);
                                            
%df_interest_sovereign_sqrt_woCDS=estimation_mcculloch_weighted_woCDS(price, ...
												%coupon_all, dtm, K, T, boot, num_boot, weights_sqrt);
                                            
    if boot==0
        df_interest_sovereign_all_sqrt=[df_interest_sovereign_all_sqrt; df_interest_sovereign_sqrt];
        %df_interest_sovereign_all_sqrt_woCDS=[df_interest_sovereign_all_sqrt_woCDS; df_interest_sovereign_sqrt_woCDS];
    elseif boot==1
        df_interest_sovereign_all_sqrt=[df_interest_sovereign_all_sqrt; df_interest_sovereign_sqrt];
    end


end
end
