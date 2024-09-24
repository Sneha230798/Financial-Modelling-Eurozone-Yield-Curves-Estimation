% Generate trading days redenomination r
nontd_ind=any(trading_days,2);

if boot==0
    load('../main_results/redenom_all_old_2020')
    redenom_old_td=redenom_all_old_2020.*repmat(trading_days,1,27);
    redenom_old_td=redenom_old_td(nontd_ind,:);
        
    save('../main_results/redenom_old_td_2020_sqrt','redenom_old_td')

elseif boot==1
    load('../main_results/redenom_all_old_boot_2020')
    redenom_all_old_td_boot=redenom_all_old_boot_2020.*repmat(trading_days,1,27,boot);
    redenom_all_old_td_boot=redenom_all_old_td_boot(nontd_ind,:,:);
    
    save('../main_results/redenom_all_old_td_boot_2020','redenom_all_old_td_boot')

end