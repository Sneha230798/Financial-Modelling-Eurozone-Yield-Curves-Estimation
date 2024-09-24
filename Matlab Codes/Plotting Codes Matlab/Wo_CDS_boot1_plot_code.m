load("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/All_Euro/df_interest_sovereign_wo_CDS_all_euro.mat");
load("C:/Users/defaultuser0/Desktop/Sneha_thesis/Discount_Rate/boot1/All_Euro/df_interest_corporate_wo_CDS_all_euro.mat")

%% Merge all discount factor data
start_redenom = 1;
boot = 1;

% Generate baseline redenomination risk measure
    redenom_all_old_boot=[];
        for nn=1
            redenom_loop=redenom_measure_wo_CDS(df_interest_datastream_foreign_all, df_interest_sovereign_wo_CDS_all(((7*nn)-6):(7*nn),:,:), start_redenom, boot);
            redenom_all_old_boot=[redenom_all_old_boot redenom_loop];
        end

%% Graphs without events. One graph per country, one scale for all.

startDate = datenum('01-January-2010');
endDate=datenum('29-June-2023');
MATLABDate1=startDate:endDate;
mdate= datenum(MATLABDate1);

%Confidence Intervals
CI_low=prctile(redenom_all_old_boot, 8,3);
CI_up=prctile(redenom_all_old_boot, 92,3);

CI_low_5=prctile(redenom_all_old_boot, 2.5,3);
CI_up_5=prctile(redenom_all_old_boot, 97.5,3);

%CI_low_5_sqrt=prctile(redenom_all_old_sqrt_boot, 2.5,3);
%CI_up_5_sqrt=prctile(redenom_all_old_sqrt_boot, 97.5,3);

for pp=1:7
        figure(pp)
        plotshaded(mdate, [CI_low_5(:,pp) CI_up_5(:,pp)], 'k')
        hold on;
        plot(mdate, redenom_all_old_boot(:,pp), 'k')
        ylim([-15 15])
        %xlabel('Date')
        %ylabel(Labels{pp})
        ylabel('in %')
        set(gca, 'xtick', [datenum('01-January-2010') datenum('01-January-2011') datenum('01-January-2012') datenum('01-January-2013') datenum('01-January-2014') datenum('01-January-2015') datenum('01-January-2016') datenum('01-January-2017') datenum('01-January-2018') datenum('01-January-2019') datenum('01-January-2020')  datenum('01-January-2021')  datenum('01-January-2022')  datenum('01-January-2023')])
        set(gca, 'xticklabel', {'01Jan10', '01Jan11','01Jan12','01Jan13', '01Jan14','01Jan15','01Jan16','01Jan17','01Jan18','01Jan19','01Jan20', '01Jan21', '01Jan22', '01Jan23'})
        set(gca,'XTickLabelRotation',45)
        hold on; plot(xlim,[0,0],'-.k')
        set(gca,'FontSize',35)
        set(gcf,'units','points','position',[100,100,700,500])
        figname = sprintf('Netherlands_all_2020_%d', pp);
        filename = fullfile('C:\Users\defaultuser0\Desktop\Sneha_thesis\plotting_codes\Plots\All_Euro', [figname, '.png']);
        %if pp<=7
         %   figname=[period{pp} '_Netherlands_all_2020'];
        %elseif pp>7 & pp<=14
         %   figname=[period{pp-7} '_Germany_all_2020'];
        %else 
         %   figname=[period{pp-14} '_Netherlands_all_2020'];
         saveas(gcf, filename, 'png');
        end