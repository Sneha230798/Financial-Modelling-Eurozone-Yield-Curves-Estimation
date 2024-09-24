clear 
clc
close all

% Bootstrap 
boot = 0; % If bootstrap, boot = 1;
num_boot = 5000;

% List of countries
%countries = {'Austria', 'Belgium', 'Croatia', 'Cyprus', 'Finland', 'France', 'Germany', 'Ireland', 'Italy', 'Netherlands', 'Portugal', 'Slovakia', 'Spain'};

% Loop over each country
%for i = 1:length(countries)
    
country = {'Slovenia'} ; %string(countries{i});  % Convert to string/character array

% Unweighted least squares function call
df_interest_sovereign_CDS_all_1 = df_sovereign_unweighted_CDS(country, boot, num_boot);

% Save the results for the current country
%save(char("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot0/Sov_CDS_3/df_interest_sovereign_CDS_" + country), 'df_interest_sovereign_CDS_all_1', '-v7.3');
save("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot0/Sov_CDS_2/df_interest_sovereign_CDS_Slovenia" , 'df_interest_sovereign_CDS_all_1', '-v7.3');
%end