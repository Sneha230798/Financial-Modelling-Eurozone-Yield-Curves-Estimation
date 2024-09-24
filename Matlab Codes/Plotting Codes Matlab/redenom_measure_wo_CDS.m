function [redenom_estimation]=redenom_measure(df_corporate, df_sovereign, start, boot)

    if boot==0
        
        redenom = (df_corporate./ df_sovereign);
        
        redenom_1d_1y=((redenom(3,start:end)./redenom(2,start:end))-1)*200;
        redenom_1y_2y=((redenom(4,start:end)./redenom(3,start:end))-1)*100;
        redenom_2y_3y=((redenom(5,start:end)./redenom(4,start:end))-1)*100;
        redenom_3y_4y=((redenom(6,start:end)./redenom(5,start:end))-1)*100;
        redenom_4y_5y=((redenom(7,start:end)./redenom(6,start:end))-1)*100;
        redenom_1y_5y=((redenom(7,start:end)./redenom(2,start:end))-1)*100;
        redenom_3y_5y=((redenom(7,start:end)./redenom(5,start:end))-1)*100;
%        redenom_1y_10y=((redenom(12,start:end)./redenom(2,start:end))-1)*100;       
%        redenom_5y_10y=((redenom(12,start:end)./redenom(7,start:end))-1)*100;
%         redenom_19y_20y=((redenom(22,start:end)./redenom(21,start:end))-1)*100;
%         redenom_29y_30y=((redenom(32,start:end)./redenom(31,start:end))-1)*100;
                
        redenom_estimation= [redenom_1d_1y' redenom_1y_2y' redenom_2y_3y' redenom_3y_4y' ...
            redenom_4y_5y' redenom_1y_5y' redenom_3y_5y']; %redenom_1y_10y' redenom_5y_10y'
    
    elseif boot==1
        
        redenom = (df_corporate./ df_sovereign);
        
        redenom_1d_1y=((redenom(3,start:end,:)./redenom(2,start:end,:))-1)*200;
        redenom_1y_2y=((redenom(4,start:end,:)./redenom(3,start:end,:))-1)*100;
        redenom_2y_3y=((redenom(5,start:end,:)./redenom(4,start:end,:))-1)*100;
        redenom_3y_4y=((redenom(6,start:end,:)./redenom(5,start:end,:))-1)*100;
        redenom_4y_5y=((redenom(7,start:end,:)./redenom(6,start:end,:))-1)*100;
        redenom_1y_5y=((redenom(7,start:end,:)./redenom(2,start:end,:))-1)*100;
        redenom_3y_5y=((redenom(7,start:end,:)./redenom(5,start:end,:))-1)*100;
%       redenom_1y_10y=((redenom(12,start:end,:)./redenom(2,start:end,:))-1)*100;
%       redenom_5y_10y=((redenom(12,start:end,:)./redenom(7,start:end,:))-1)*100;
%         redenom_19y_20y=((redenom(22,start:end,:)./redenom(21,start:end,:))-1)*100;
%         redenom_29y_30y=((redenom(32,start:end,:)./redenom(31,start:end,:))-1)*100;
       
        redenom_estimation= [permute(redenom_1d_1y,[2 1 3]) permute(redenom_1y_2y,[2 1 3]) ...
            permute(redenom_2y_3y,[2 1 3]) permute(redenom_3y_4y,[2 1 3]) permute(redenom_4y_5y,[2 1 3]) ...
            permute(redenom_1y_5y,[2 1 3]) permute(redenom_3y_5y,[2 1 3]) ]; %permute(redenom_1y_10y,[2 1 3]) ... permute(redenom_5y_10y,[2 1 3])


end