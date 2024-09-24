clear 
clc
close all

% Bootstrap 
boot=1; % If bootstrap, boot=1;
num_boot=5000;

country = {'all_euro'};
%,'Italy' , 'Spain'};   
%country = {'Croatia'}; %, 'Austria' , 'Belgium'
%country = {'Cyprus'};  %, 'Finland' , 'Ireland'
%country = {'Netherlands', 'Portugal', 'Slovakia'};
%country = {'Slovenia' , 'France'};

% Unweighted least squares
[df_interest_sovereign_CDS_all_1] = df_sovereign_weighted_woCDS(country, boot, num_boot);

save('C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/All_Euro/df_interest_sovereign_wo_CDS_weighted_all_euro', 'df_interest_sovereign_CDS_all_1', '-v7.3');