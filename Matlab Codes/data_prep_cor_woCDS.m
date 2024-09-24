cds_dtm=[0 1825 2555 3650 7300 10950];
% List of countries
%countries = {'Finland'}
%countries = {'Germany', 'Spain', 'Austria' , 'Belgium' , 'Finland' , 'Ireland' , 'Portugal', 'Italy', 'France', 'Greece', 'Latvia', 'Netherlands'}; 
% Loop through each country
%for i = 1:length(countries)
 %   country = countries{i};
    
% Construct file paths dynamically
priceFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Dirty_Prices.xlsx');
couponFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Coupon.xlsx');
dtmFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/DTM.xlsx');
%cdsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_CDS/%s_sovereign_cds_final.xlsx', country);
dateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Date_File.xlsx');
coupondateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Coupon_Dates.xlsx');

% Read data for the current country
price = readmatrix(priceFile);
coupon_all = readmatrix(couponFile);
dtm = readmatrix(dtmFile);
%cds = readmatrix(cdsFile);
date = readmatrix(dateFile);
coupon_dates = readmatrix(coupondateFile);

ind_dtm = dtm < 10950;
dtm(ind_dtm == 0) = NaN;
T = size(price, 1);
price = price .* ind_dtm(1:T, :);
price(price == 0) = NaN;

dtm = dtm .* ind_dtm;

date_all = coupon_all(:, 1);
coupon_all = coupon_all(:, 2:size(coupon_all, 2));
coupon_all(isnan(coupon_all) == 1) = 0;
N = size(price, 2);


% Save processed data
saveFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/All_Euro/data_all_euro_corporate_bonds_woCDS_2020.mat');
save(saveFile, 'price', 'coupon_all', 'dtm', "coupon_dates");
%end