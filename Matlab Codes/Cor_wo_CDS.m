
clear 
clc
close all

% Bootstrap 
boot=0; % If bootstrap, boot=1;
num_boot=5000;

%country = {'Ireland'};
country = {'all_euro'}; 
          

% Unweighted least squares
[df_interest_datastream_foreign_all] = df_corporate_unweighted_woCDS(country, boot, num_boot);

save('C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot0/All_Euro/df_interest_corporate_wo_CDS_all_euro', 'df_interest_datastream_foreign_all', '-v7.3');