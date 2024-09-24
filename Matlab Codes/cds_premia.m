
function [cdspremia] = cds_premia_sov_0(cds,T,N,dtm, cds_dtm)

% First we compute the (interpolated) cds premia of all bonds at every observation period
cdspremia=NaN(T,N); %CDS premia(Date, Bond)

cds=cds(:,4:size(cds,2));
cds=[zeros(size(cds,1),1) cds];

dtm_interest = dtm(1:T,:); 
[~,ind] = histc(dtm_interest,cds_dtm); % Find next smallest DTM on CDS DTM grid

ind = max(ind,1); % replace ind by 1 for DTM smaller than smallest grid

dist = dtm_interest - cds_dtm(ind); % Calculate difference in DTM to next smallest DTM on grid

weight = dist./(cds_dtm(ind+1)-cds_dtm(ind)); % calculate the weight on next larger on grid point CDS 

linear_index1 = sub2ind([T,9],repmat((1:T)',[1,N]),ind); % calculate linear indeces
linear_index2 = sub2ind([T,9],repmat((1:T)',[1,N]),ind+1);
weight = max(weight,0);  %do not extrapolate

cdspremia = cds(linear_index1)+ weight.*(cds(linear_index2)-cds(linear_index1));

end