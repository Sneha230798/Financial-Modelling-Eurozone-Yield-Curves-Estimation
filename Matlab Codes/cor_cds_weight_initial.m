function [cdsweight] = cds_weight_france_datastream(T,N,coupon_dates, cdspremia,date)

%For yearly coupon payments
coupon_dates_yearly=coupon_dates;
cdspremia_yearly=cdspremia;
cdsweight1=zeros(T,N);

for i=1:T
    difference=coupon_dates_yearly-date(i);
    difference(difference<0|difference>365)=NaN;
    difference(difference==0)=1;
    difference(isnan(difference)==1)=0;
    sum_diff=sum(difference);
    first_weight=sum_diff/365;
    cdsweight1(i,:)=first_weight.*cdspremia_yearly(i,:);
end

cdsweight=cdsweight1;

end