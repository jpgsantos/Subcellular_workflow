function plots = f_plot(rst,stg,mmf)
set(0,'defaultAxesFontName','Arial')
set(0,'defaultAxesFontSize',10)

%Font settings
font_settings.Letter_FontSize = 10;
font_settings.Letter_Fontweight = 'bold';
font_settings.Axis_FontSize = 8;
font_settings.Axis_Fontweight = 'bold';
font_settings.Minor_title_FontSize = 10;
font_settings.Minor_title_Fontweight = 'bold';
font_settings.Minor_Title_Spacing = 1;
font_settings.Major_title_FontSize = 12;
font_settings.Major_title_Fontweight = 'bold';
font_settings.Major_Title_Spacing = 2;
font_settings.Legend_FontSize = 8;
font_settings.Legend_Fontweight = 'bold';
font_settings.Legend_ItemTokenSize = [20,18];
font_settings.line_width = 1;

% Inform the user that the plots are being done
disp("Plotting ...")

data_model = mmf.model.data.data_model;

% Import the data on the first run
load(data_model,'Data','sbtab')

if isfield(rst,'diag')
    % Generate figure with Scores
    plots1 = f_plot_scores(rst.diag,stg,sbtab,font_settings);
    % Generate figure with Inputs
    plots2 = f_plot_inputs(rst.diag,stg,sbtab,font_settings);
    % Generate figure with Outputs
    plots3 = f_plot_outputs(rst.diag,stg,sbtab,Data,mmf,font_settings);
    % Generate figure with input and Output of all experiments
    plots4 = f_plot_in_out(rst.diag,stg,sbtab,Data,mmf,font_settings);
    plots = [plots1;plots2;plots3;plots4];
end

% Generate figure with optimization results
if isfield(rst,'opt')
    plots5 = f_plot_opt(rst,stg,font_settings);
    plots = [plots1;plots2;plots3;plots4;plots5];
end

% Generate figures for Local Sensitivity Analysis
if isfield(rst,'lsa')
    plots = f_plot_lsa(rst.lsa,stg,font_settings);
end

% Generate figures for Global Sensitivity Analysis
if isfield(rst,'gsa')
    plots = f_plot_gsa_sensitivities(rst.gsa,stg,sbtab,font_settings);
end

% Generate figure for Profile Likelihood Analysis
if isfield(rst,'PLA')
    plots = f_plot_PL(rst,stg,mmf,font_settings);
end
end
