%Finland

% Construct file paths dynamically
priceFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Dirty_Prices_CDS.xlsx');
couponFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Coupon_CDS.xlsx');
dtmFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/DTM_CDS.xlsx');
cdsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/CDS_CDS.xlsx');
dateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Date_File.xlsx');
coupondateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/All Euro/Corporate/Coupon_Dates_CDS.xlsx');


% Read data for the current country
price = readmatrix(priceFile);
coupon_all = readmatrix(couponFile);
dtm = readmatrix(dtmFile);
cds = readmatrix(cdsFile);
date = readmatrix(dateFile);
coupon_dates = readmatrix(coupondateFile);

cds=cds(:,2:size(cds,2));
    cds=[zeros(size(cds,1),1) cds];

% Size of data set

T       = size(price,1);     % Length of the Sample
N       = size(price,2);      % Number of bonds

% Construct day_to_maturity vector of CDS contracts
%day_data_all=[0 730 1825 2555 3650 7300 10950];
day_data_all=[0 183 365 730 1095 1460 1825 2555 3650 7300 10950];

% We need the coupon payment dates 
date_all=coupon_all(:,1);   % date from 14.12.2007 to the latest coupon payment date of the German bonds.
coupon_all=coupon_all(:,2:size(coupon_all,2));
coupon_all(isnan(coupon_all)==1)=0;

Ncorporate_fra=46;
numBonds_france = [1, 1, 19, 28, 5, 5, 7, 2, 6, 2, 6, 3, 7, 16, 28, 13, 9, 5, 23, 15, 1, 31, 60, 52, 16, 8, 7, 36, 3, 61, 2, 3, 8, 8, 24, 10, 7, 3, 46, 28, 15, 1, 7, 4, 1, 30];
start= [1,2,3,22,50,55,60,67,69,75,77,83,86,93,109,137,150,159,164,187,202,203,234,294,346,362,370,377,413,416,477,479,482,490,498,522,532,539,542,588,616,631,632,639,643,644];
last=[1,2,21,49,54,59,66,68,74,76,82,85,92,108,136,149,158,163,186,201,202,233,293,345,361,369,376,412,415,476,478,481,489,497,521,531,538,541,587,615,630,631,638,642,643,673];

price=price;
price(price<75)=NaN;


cdspremia=cor_cds_premia(cds,T,N,Ncorporate_fra,start,last,dtm, day_data_all);

% Now compute the cds-premia, which you have to pay before coupon payment date
cds_initial=cor_cds_weight_initial(T,N,coupon_dates,cdspremia,date);

p = price + cds_initial;

saveFile = 'C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/All_Euro/data_all_euro_corporate_bonds_2020_CDS.mat';
    save(saveFile, 'price', 'coupon_all', 'dtm', "coupon_dates", 'cdspremia', 'cds_initial', 'p');

