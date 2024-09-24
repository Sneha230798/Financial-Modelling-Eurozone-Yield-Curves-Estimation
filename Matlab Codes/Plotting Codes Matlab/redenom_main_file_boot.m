load("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/Sov_wo_CDS/df_interest_sovereign_wo_CDS_Germany.mat");
load("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/Cor_wo_CDS/df_interest_corporate_wo_CDS_Germany.mat")

%% Merge all discount factor data
start_redenom = 1;
boot = 1;

% Generate baseline redenomination risk measure
    redenom_all_old_boot=[];
        for nn=1
            redenom_loop=redenom_measure_wo_CDS(df_interest_datastream_foreign_all, df_interest_sovereign_wo_CDS_all(((7*nn)-6):(7*nn),:,:), start_redenom, boot);
            redenom_all_old_boot=[redenom_all_old_boot redenom_loop];
        end


save("C:/Users/defaultuser0/Desktop/Sneha_thesis/plotting_codes/redenom_all_boot_wo_CDS_Germany.mat",'redenom_all_old_boot', '-v7.3')