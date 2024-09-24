function [S] = mcculloch_knot(n,DTM,N_t)
% Place an approximately equal number of bonds between adjacent knots
dtm_end=DTM(end,:);
dtm_end=sort(dtm_end);
dtm_end2=unique(dtm_end);

if size(dtm_end,2)~= size(dtm_end2,2)
    N_t2=size(dtm_end2,2);
    n2=round(sqrt(size(dtm_end2,2)));
else 
    n2=n;
    N_t2=N_t;
end

if n2-1<=2
    S=[0; max(dtm_end2)];
else
    S=zeros(n2-1,1);
    dtm_end2=[0, dtm_end2 max(dtm_end2)];
    
    for l=1:n2-1
        h_all=((l-1).*N_t2)/(n2-2);
        h=ceil(h_all);
        theta=h_all-h;
        %theta=max(bsxfun(@minus, h_all, h));
        if theta==0
            S(l)=dtm_end2(h+1);
        else
            S(l)=round(dtm_end2(h)+theta.*(dtm_end2(h+1)-dtm_end2(h)));
        end
    end
S=sort(S);    
end

