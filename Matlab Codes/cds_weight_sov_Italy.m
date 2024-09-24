function [cdsweight] = cds_weight_italy_sov(T,N,coupon_dates, cdspremia,date)

% Only semi-annual coupon payments 

% For semi-annual coupon payments
coupon_dates_semi=coupon_dates;
cdspremia_semi=cdspremia;
cdsweight2=zeros(T,N);

for i=1:T
    difference=coupon_dates_semi-date(i);
    difference(difference<0|difference>183)=NaN;
    difference(difference==0)=1;
    difference(isnan(difference)==1)=0;
    sum_diff=sum(difference);
    first_weight=sum_diff/183;
    cdsweight2(i,:)=first_weight.*cdspremia_semi(i,:);
end

cdsweight=cdsweight2;

end