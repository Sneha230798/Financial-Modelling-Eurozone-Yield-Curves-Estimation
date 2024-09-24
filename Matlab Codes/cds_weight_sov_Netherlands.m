function [cdsweight] = cds_weight_netherlands(T,N,coupon_dates, cdspremia,date)

%For yearly coupon payments
coupon_dates_yearly=coupon_dates(:,1:46);
cdspremia_yearly=cdspremia(:,1:46);
cdsweight1=zeros(T,46);

for i=1:T
    difference=coupon_dates_yearly-date(i);
    difference(difference<0|difference>365)=NaN;
    difference(difference==0)=1;
    difference(isnan(difference)==1)=0;
    sum_diff=sum(difference);
    first_weight=sum_diff/365;
    cdsweight1(i,:)=first_weight.*cdspremia_yearly(i,:);
end

% For semi-annual coupon payments
coupon_dates_semi=coupon_dates(:,47:N);
cdspremia_semi=cdspremia(:,47:N);
cdsweight2=zeros(T,N-47+1);

for i=1:T
    difference=coupon_dates_semi-date(i);
    difference(difference<0|difference>183)=NaN;
    difference(difference==0)=1;
    difference(isnan(difference)==1)=0;
    sum_diff=sum(difference);
    first_weight=sum_diff/183;
    cdsweight2(i,:)=first_weight.*cdspremia_semi(i,:);
end

cdsweight=[cdsweight1 cdsweight2];

end