% This file produces estimates of redenomination risk measures and 
% their bootstrapped measures:
% boot=0 gives redenomination risk measures
% boot=1 gives bootstrapped redenomination risk measures
% All MAT files are saved in folder main_results. 

clear 
clc
close all

% Bootstrap 
boot=0; % If bootstrap, boot=1;
num_boot=5000;

% Country index
country={'france','germany','italy'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All data start from 01.01.2010 to 10.05.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Estimation of Yield Curves

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the safe international corportate euro bond yields

% Estimate yields with WLS
%load('../all_foreign/weights_cor_2020')
%weights_sqrt=weights(2,:);


%% Estimate yields with OLS, country specific

% Merge all data files together 

[df_interest_datastream_foreign_all_sqrt, price_all, dtm_all, coupon_all_all, cdspremia_all, cds_initial_all, weights_all] = df_corporate_all_separate_all(country, boot, num_boot);

%% Estimate yields with WLS, include all countries 
weights_sqrt = weights_all(2,:);

K=size(coupon_all_all,1);
T = size(price_all,1);     % Length of the Sample


[df_interest_all_datastream_foreign_sqrt]=estimation_mcculloch_weighted_all(price_all, ...
    coupon_all_all, dtm_all, cdspremia_all, cds_initial_all, K, T, boot, num_boot, weights_sqrt);

% Estimate yields with OLS
[df_interest_all_datastream_foreign]=estimation_mcculloch_unweighted_all(price_all, ...
    coupon_all_all, dtm_all, cdspremia_all, cds_initial_all, K, T, boot, num_boot);


%% Estimate yields with WLS, include only France and Italy
[df_interest_all_datastream_foreign_wo_germany_sqrt] = df_corporate_wo_deu_all(price_all, coupon_all_all, dtm_all, cdspremia_all, cds_initial_all, T, boot, num_boot, weights_sqrt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estimate the sovereign bond yields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unweighted least squares
[df_interest_sovereign_all] = df_sovereign_unweighted_all(country, boot, num_boot);

% Weighted least squares
[df_interest_sovereign_all_sqrt df_interest_sovereign_all_sqrt_woCDS] = df_sovereign_weighted_all(country, boot, num_boot);

%% Save results
 if boot==0
    save('../main_results/discount_rates/df_interest_sovereign_all_2020', 'df_interest_sovereign_all');
    save('../main_results/discount_rates/df_interest_sovereign_all_sqrt_2020', 'df_interest_sovereign_all_sqrt');
    save('../main_results/discount_rates/df_interest_sovereign_all_sqrt_woCDS_2020', 'df_interest_sovereign_all_sqrt_woCDS');
    
    save('../main_results/discount_rates/df_interest_all_datastream_foreign_2020', 'df_interest_all_datastream_foreign')
    save('../main_results/discount_rates/df_interest_all_datastream_foreign_sqrt_2020', 'df_interest_all_datastream_foreign_sqrt')
    save('../main_results/discount_rates/df_interest_all_datastream_foreign_wo_germany_sqrt_2020', 'df_interest_all_datastream_foreign_wo_germany_sqrt')
    save('../main_results/discount_rates/df_interest_datastream_foreign_all_sqrt_2020', 'df_interest_datastream_foreign_all_sqrt')
    
    elseif boot==1
    
    df_interest_sovereign_all_boot=df_interest_sovereign_all;
    df_interest_sovereign_all_sqrt_boot=df_interest_sovereign_all_sqrt;
    
    df_interest_all_datastream_foreign_boot = df_interest_all_datastream_foreign;
    df_interest_datastream_foreign_all_sqrt_boot = df_interest_datastream_foreign_all_sqrt;
    df_interest_all_datastream_foreign_sqrt_boot = df_interest_all_datastream_foreign_sqrt;
    df_interest_all_datastream_foreign_wo_germany_sqrt_boot = df_interest_all_datastream_foreign_wo_germany_sqrt;
    
    save('../main_results/discount_rates/df_interest_sovereign_all_boot_2020', 'df_interest_sovereign_all_boot', '-v7.3');
    save('../main_results/discount_rates/df_interest_sovereign_all_sqrt_boot_2020', 'df_interest_sovereign_all_sqrt_boot', '-v7.3');
    
    save('../main_results/discount_rates/df_interest_datastream_foreign_all_sqrt_boot_2020', 'df_interest_datastream_foreign_all_sqrt_boot', '-v7.3');
    save('../main_results/discount_rates/df_interest_datastream_foreign_wo_germany_sqrt_boot_2020', 'df_interest_all_datastream_foreign_wo_germany_sqrt_boot', '-v7.3');
    save('../main_results/discount_rates/df_interest_all_datastream_foreign_sqrt_boot_2020', 'df_interest_all_datastream_foreign_sqrt', '-v7.3');
    save('../main_results/discount_rates/df_interest_all_datastream_foreign_boot_2020', 'df_interest_all_datastream_foreign_boot', '-v7.3');
    
    clear df_interest_sovereign_all df_interest_sovereign_all_sqrt
    clear df_interest_datastream_foreign_all_sqrt df_interest_datastream_foreign_wo_germany_sqrt df_interest_datastream_foreign_sqrt df_interest_datastream_foreign

end

   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Calculate Redenomination Risk
%   
%   df_interest_datastream_foreign_all:             (21 x T),   country
%   df_interest_all_datastream_foreign:             (7  x T),   all  
%   df_interest_all_datastream_foreign_sqrt         (7  x T),   all WLS
%   df_interest_all_dataststream_foreign_wo_germany (7  x T),   FRA & ITA
%
%   df_interest_sovereign_all                       (21 x T),   country
%   df_interest_sovereign_all_sqrt                  (21 x T),   country WLS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Redenomination risk measures

load('../main_results/trading_days_2020')
start_redenom=1; 

if boot==0
    redenom_mainfile_new
    redenom_td_new
elseif boot==1
    redenom_mainfile_boot_new
    redenom_td_new
end
   

%% Smoothed series, (1)redenomination risk and (2)discount rates 
% Create a one-sided moving average filter that goes back 13 days 
a=1;
b=[1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13 1/13];
b_20=[1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20 1/20];

redenom_all_old_smooth=filter(b,a,redenom_all_old_ols);
redenom_all_old_smooth_sqrt =filter(b,a,redenom_all_old);

save('../main_results/redenom_all_old_smooth_2020', 'redenom_all_old_smooth');
save('../main_results/redenom_all_old_smooth_2020_sqrt', 'redenom_all_old_smooth_sqrt');



% elseif boot==1
%     
% % Transpose discount rates to smooth 
% df_interest_datastream_foreign_all_boot_low=df_interest_datastream_foreign_all_quantile_boot(:,:,3)';
% df_interest_datastream_foreign_all_boot_up=df_interest_datastream_foreign_all_quantile_boot(:,:,4)';
% 
% df_interest_datastream_foreign_all_boot_low_s = filter(b,a, df_interest_datastream_foreign_all_boot_low);
% df_interest_datastream_foreign_all_boot_up_s = filter(b,a, df_interest_datastream_foreign_all_boot_up);
% 
% save('../main_results/discount_rates/df_interest_datastream_foreign_all_boot_low_s', 'df_interest_datastream_foreign_all_boot_low_s');
% save('../main_results/discount_rates/df_interest_datastream_foreign_all_boot_up_s', 'df_interest_datastream_foreign_all_boot_up_s');


% end

