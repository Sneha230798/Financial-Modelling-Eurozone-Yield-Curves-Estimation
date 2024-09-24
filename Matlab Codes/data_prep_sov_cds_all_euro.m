cds_dtm=[0 1825 2555 3650 7300 10950];
% List of countries
%countries = {'Germany', 'Spain', 'Austria' , 'Belgium' , 'Finland' , 'Ireland' , 'Portugal', 'Slovakia' , 'Slovenia' , 'France'-}; 
%countries2 = {'Cyprus', 'Croatia', 'Netherlands', 'Italy'}
% Loop through each country
%for i = 1:length(countries)
%    country = countries{i};
    
    % Construct file paths dynamically
priceFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Sovereign/Dirty_Prices_CDS.xlsx');
couponFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Sovereign/Coupons_CDS.xlsx');
dtmFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Sovereign/DTM_CDS.xlsx');
cdsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Sovereign/CDS.xlsx');
dateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Date_File.xlsx');
coupondateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Sovereign/Coupon_Dates_CDS.xlsx');

% Read data for the current country
price = readmatrix(priceFile);
coupon_all = readmatrix(couponFile);
dtm = readmatrix(dtmFile);
cds = readmatrix(cdsFile);
date = readmatrix(dateFile);
coupon_dates = readmatrix(coupondateFile);

% Process the data
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

cdspremia = cds_premia(cds,T,N,dtm,cds_dtm)

cds_initial=cds_weight_all_euro(T,N,coupon_dates, cdspremia,date);


% Save processed data
saveFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/All_Euro/data_all_euro_sovereign_bonds_cds_2020.mat');
save(saveFile, 'price', 'coupon_all', 'dtm', 'cdspremia', "cds_initial", "coupon_dates");
%end

%for i = 1:length(countries2)
 %   country = countries2{i};
    
    % Construct file paths dynamically
  %  priceFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_Dirty_Prices/%s_sov_dirtyprice.xlsx', country);
   % couponFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_Coupons/%s_sov_coupon.xlsx', country);
    %dtmFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_DTM/%s_sov_dtm.xlsx', country);
    %cdsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_CDS/%s_sovereign_cds_final.xlsx', country);
    %dateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Date_File.xlsx');
    %coupondateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Sov_Coupon_Dates/%s.xlsx', country);
    
    % Read data for the current country
    %price = readmatrix(priceFile);
    %coupon_all = readmatrix(couponFile);
    %dtm = readmatrix(dtmFile);
    %cds = readmatrix(cdsFile);
    %date = readmatrix(dateFile);
    %coupon_dates = readmatrix(coupondateFile);

    % Process the data
    %ind_dtm = dtm < 10950;
    %dtm(ind_dtm == 0) = NaN;
    %T = size(price, 1);
    %price = price .* ind_dtm(1:T, :);
    %price(price == 0) = NaN;

    %dtm = dtm .* ind_dtm;

    %date_all = coupon_all(:, 1);
    %coupon_all = coupon_all(:, 2:size(coupon_all, 2));
    %coupon_all(isnan(coupon_all) == 1) = 0;
    
   % N = size(price, 2);

  %  cdspremia = cds_premia(cds,T,N,dtm,cds_dtm)

 %   function_name = ['cds_weight_sov_', countries2{i}];
%    cds_initial = feval(function_name, T, N, coupon_dates, cdspremia, date);
    

    % Save processed data
  %  saveFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/Sov_CDS/data_%s_sovereign_bonds_2020.mat', country);
 %   save(saveFile, 'price', 'coupon_all', 'dtm', 'cdspremia', "cds_initial", "coupon_dates");
%end