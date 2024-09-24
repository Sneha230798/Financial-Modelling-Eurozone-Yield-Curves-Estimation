function [df_interest]=estimation_mcculloch_unweighted(price, coupon_all, dtm, K, T, boot, num_boot)
 
if boot==1
    df_interest=zeros(7,T,num_boot);
elseif boot==0
    df_interest=zeros(7,T);    
end

for t=1:T
    
    % Here we should subtract all future cashflow with cds premia
    % cds_adjust=zeros(K-t+1,N); 
    coupon_all2=coupon_all(t:K,:);
    coupon_all2(isnan(coupon_all2)==1)=0;     
    

    %% Apply Cubic B-Spline to estimate the term structure
    % Sort cashflow matrix (C) and maturity matrix (dtm) such that the N bonds are arranged in ascending order by their maturity dates

    C=coupon_all2;
    p=price(t,:);
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
    C(KK+1:end,:)=[];
    
    % Rearrange the matrices in ascending order 
    [d1,d2]=sort(DTM(end,:));
    DTM=DTM(:,d2);
    C=C(:,d2);
    p=p(:,d2);
    
    % New number of bonds (all NaN values are removed)
      N_t=size(p,2);
    
    
    % Compute length of discount factor, which can be estimated with data
   
    % Set knotpoints (arbitrarily or a la McCulloch: number of basis functions = integer nearest to the square root of the number of bonds k?)
    % n: number of basis functions
    % S: Knot points between 1:maximum maturity of a bond
    
    n=round(sqrt(N_t));
    S=round(mcculloch_knot(n, DTM, N_t))';
    
    % Now use function cubicspline
    G=cubicspline2(M,S);
    g=cubicspline2([2 183 365 730 1095 1460 1825],S); 
    

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
        df_interest(:,t,jj)=discount_factor_boot(1:7);
    
    end 
    
    elseif boot==0
    beta=regress(z, X);
      
    % Estimated discount factor
    discount_factor=1+(g*beta);
    
    % Save all values for t=365, 730, 1095
    df_interest(:,t)=discount_factor(1:7);
    end
end
end