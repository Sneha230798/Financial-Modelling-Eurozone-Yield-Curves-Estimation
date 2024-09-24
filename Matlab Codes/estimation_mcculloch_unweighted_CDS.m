function [df_interest]=estimation_mcculloch_unweighted_all(price, coupon_all, dtm, cdspremia, cds_initial, K, T, boot, num_boot)
 
if boot==1
    df_interest=zeros(12,T,num_boot);
elseif boot==0
    df_interest=zeros(12,T);    
end



for t=1:T

    disp(t);
    
    
    % Here we should subtract all future cashflow with cds premia
    % cds_adjust=zeros(K-t+1,N); 
    coupon_all2=coupon_all(t:K,:);
    coupon_all2(coupon_all2==0 | coupon_all2>=100)=NaN; %pick all pure cupon dates
    cdspremia_rep=repmat(cdspremia(t,:),K-t+1,1);
    coupon_cds_adjusted=coupon_all2-cdspremia_rep;

   

    coupon_all3=coupon_all(t:K,:);
    coupon_all3(coupon_all3<100)=0; % pick the repayment events (set all pure coupon dates to zero)
    coupon_cds_adjusted(isnan(coupon_cds_adjusted)==1)=0;
    coupon_cds_adjusted=coupon_cds_adjusted+coupon_all3;
    
    
    %% Apply Cubic B-Spline to estimate the term structure
    % Sort cashflow matrix (C) and maturity matrix (dtm) such that the N bonds are arranged in ascending order by their maturity dates
    
    C=coupon_cds_adjusted;
    p=price(t,:)+cds_initial(t,:);
    
    
    DTM=flipud(dtm(t:end,:));
    DTM=DTM+1;
    
    
   % Delet all rows, which contains only NaNs
   % M(~any(~isnan(M), 2),:)=[];
    
    %   p(:)-  Sum b_j(C* G_j(M))
    % Find NaN price values and remove
    
    [row_p,col_p]=find(isnan(p));
    
    
    C(:,col_p)=[];
    
    p(:,col_p)=[];
    DTM(:,col_p)=[];
    
    [row_dtm, col_dtm]=find(isnan(DTM(end,:)));
    C(:,col_dtm)=[];
    
    p(:,col_dtm)=[];
    DTM(:,col_dtm)=[];
    
    
    KK=max(DTM(end,:));
    
    
    M = (1:KK)';
    
    C(floor(KK + 1):end, :) = [];
    
    % Rearrange the matrices in ascending order 
    [d1,d2]=sort(DTM(end,:));
    DTM=DTM(:,d2);
    C=C(:,d2);
   
    p=p(:,d2);
    
    % New number of bonds (all NaN values are removed)
      N_t=size(p,2);
    
    
    % Compute length of discount factor, which can be estimated with data

    
    % Set knotpoints (arbitrarily or a la McCulloch: number of basis functions = integer nearest to the square root of the number of bonds k?)
    % I will start with equidistant knot points
    % n: number of basis functions
    % S: Knot points between 1:maximum maturity of a bond
    
    n=round(sqrt(N_t));
    %DTM2=DTM(:);
    %DTM2(isnan(DTM2)==1)=[];
    %S=quantile(DTM2, linspace(0,1,n));
    %S=round(S);
    %S=[0 365 730  linspace(1095, K-t+1, n - 3)];
    S=round(mcculloch_knot(n, DTM, N_t))';
    %S2=round(linspace(0,K-t+1,n));
 
    
    %round(linspace(0,K-t+1,n));

    
    % Now use function cubicspline
    G=cubicspline2(M,S);
    %g=cubicspline2([2 183 365 730 1095 1460 1825],S);
    g=cubicspline2([2 183 365 730 1095 1460 1825 2190 2555 2920 3285 3650],S);
    
    disp(size(C));
    disp(size(G));
    
    %B=B(:,(1:size(B,2)-5));
    %g=g(:,1:4);
    X=(C'*G);
    % We need the sum of cash flows of one bond
    sum_cf=sum(C);
    z=(p-sum_cf)';
    
    if boot==1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Bootstrapping %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    XX=[z X];
    sample_size=size(XX,1);
    indexes= randi(sample_size,sample_size,num_boot);
    
    for jj=1:num_boot
        
        z_boot=XX(indexes(:,jj),1);
        X_boot=XX(indexes(:,jj),2:end);

        % Estimated bootstrapped discount factor    
        beta_boot=regress(z_boot,X_boot);
      
        % Estimated bootstrapped discount factor
        discount_factor_boot=1+(g*beta_boot);
    
        % Save all values for t=365, 730, 1095
        df_interest(:,t,jj)=discount_factor_boot(1:12);
    
    end 
    
    elseif boot==0
    beta=regress(z, X);
      
    % Estimated discount factor
    discount_factor=1+(g*beta);
    
    % Save all values for t=365, 730, 1095
    df_interest(:,t)=discount_factor(1:12);
    end
end
end