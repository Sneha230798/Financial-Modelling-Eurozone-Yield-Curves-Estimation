% load('../main_results/discount_rates/df_interest_all_datastream_foreign_boot_2020.mat');
% load('../main_results/discount_rates/df_interest_sovereign_all_boot_2020.mat')

%% Merge all discount factor data

% Generate baseline redenomination risk measure
    redenom_all_old=[];
        for nn=1:3
            redenom_loop=redenom_measure(df_interest_all_datastream_foreign_boot, df_interest_sovereign_all_boot(((12*nn)-11):(12*nn),:,:), start_redenom, boot);
            redenom_all_old=[redenom_all_old redenom_loop];
        end


save('../main_results/redenom_all_old_2020','redenom_all_old', '-v7.3')