%Finland

% Construct file paths dynamically
% Construct file paths dynamically
priceFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Cor_Dirty_Prices/Germany_cor_dirtyprice.xlsx');
couponFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Cor_Coupon/Germany_cor_coupon.xlsx');
dtmFile = sprintf("C:/Users/defaultuser0/Desktop/Book2.xlsx");
cdsFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Cor_CDS_Normalised/Germany_cds_normalised.xlsx');
dateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Date_File.xlsx');
coupondateFile = sprintf('C:/Users/defaultuser0/Desktop/Sneha_thesis/excel_files/Cor_Coupon_Dates/Germany.xlsx');
cdspremiaFile = sprintf('C:/Users/defaultuser0/Desktop/cdspremia.xlsx');

% Read data for the current country
price = readmatrix(priceFile);
coupon_all = readmatrix(couponFile);
dtm = readmatrix(dtmFile);
cds = readmatrix(cdsFile);
date = readmatrix(dateFile);
coupon_dates = readmatrix(coupondateFile);
cdspremia = readmatrix(cdspremiaFile);

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

Ncorporate_fra=9;
numBonds_france = [33, 95,  67, 18, 8,  7, 59,  4, 72];
start= [1,34,129,196,214,222,229,288,292];
last=[33,128,195,213,221,228,287,291,363];

price=price;
price(price<75)=NaN;


cdspremia=cor_cds_premia(cds,T,N,Ncorporate_fra,start,last,dtm, day_data_all);

% Now compute the cds-premia, which you have to pay before coupon payment date
cds_initial=cor_cds_weight_initial(T,N,coupon_dates,cdspremia,date);



saveFile = 'C:/Users/defaultuser0/Desktop/Sneha_thesis/Combined_Datasets/Cor_CDS/data_Germany2_corporate_bonds_2020_CDS.mat';
    save(saveFile, 'price', 'coupon_all', 'dtm', "coupon_dates", 'cdspremia', 'cds_initial');

