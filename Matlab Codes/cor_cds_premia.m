function [cdspremia] = cds_premia_france_dinfdatastream(cds,T,N,Ncorporate_fra,start,last,dtm, day_data_all)
% First we compute the (interpolated) cds premia of all bonds at every observation period
cdspremia=NaN(T,N); %CDS premia(Date, Bond)

for p=1:Ncorporate_fra

n = last(p)-start(p)+1; % number of bonds for firm p
disp(start(p));
disp(last(p));
disp(n);
dtm_interest = dtm(1:T,start(p):last(p)); % Days-to-maturity for various bonds

[~,ind] = histc(dtm_interest,day_data_all); % Find next smallest DTM on CDS DTM grid

ind = max(ind,1); % replace ind by 1 for DTM smaller than smallest grid

if size(ind,2)>1
    dist = dtm_interest - day_data_all(ind); % Calculate difference in DTM to next smallest DTM on grid
    weight = dist./(day_data_all(ind+1)-day_data_all(ind)); % calculate the weight on next larger on grid point CDS 
elseif size(ind,2)==1    
    dist=dtm_interest-day_data_all(ind)';
    weight = dist./(day_data_all(ind+1)'-day_data_all(ind)'); % calculate the weight on next larger on grid point CDS 
end


linear_index1 = sub2ind([T,12],repmat((1:T)',[1,n]),ind); % calculate linear indeces
linear_index2 = sub2ind([T,12],repmat((1:T)',[1,n]),ind+1);
weight = max(weight,0);  %do not extrapolate


cdspremia_aux = cds(linear_index1)+ weight.*(cds(linear_index2)-cds(linear_index1));
cdspremia(:,start(p):last(p)) = cdspremia_aux;
disp(cdspremia_aux);

end
end