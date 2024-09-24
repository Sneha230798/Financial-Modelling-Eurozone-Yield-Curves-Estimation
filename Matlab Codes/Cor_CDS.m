clear 
clc
close all

% Bootstrap 
boot=1; % If bootstrap, boot=1;
num_boot=5000;

%country = {'Ireland'};
country = {'Germany2'}; 
          

% Unweighted least squares
[df_interest_datastream_foreign_all] = df_corporate_unweighted_CDS(country, boot, num_boot);

save('C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/All_Euro/df_interest_corporate_CDS_Germany2_cds', 'df_interest_datastream_foreign_all', '-v7.3');