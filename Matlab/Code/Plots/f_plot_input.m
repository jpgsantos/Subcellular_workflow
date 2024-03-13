function [input_plot,labelfig2] = f_plot_input(stg,rst,sbtab,exp_idx,layout)

% Set font settings
f_set_font_settings()

% Iterate through each input species for the current experiment.
    for ipt_idx = 1:size(sbtab.datasets(exp_idx).input,2)
        % Iterate through each set of parameters to process simulation results.
        for pa_idx = stg.pat
            % Check if the simulation was successful for the current parameter
            % set and experiment.
            if rst(pa_idx).simd{1,exp_idx} ~= 0
                % Convert species identifier from string to number.
                input_species_ID =...
                    str2double(strrep(sbtab.datasets(exp_idx).input(ipt_idx),'S',''))+1;

                % Create a scatter plot for the input species data points.
                input_plot = ...
                    scatter(rst(pa_idx).simd{1,exp_idx}.Time,...
                    rst(pa_idx).simd{1,exp_idx}.Data(1:end,input_species_ID),...
                    2,[0.5,0.5,0.5],"o","filled","MarkerFaceAlpha",1,...
                    "MarkerEdgeAlpha",1,"DisplayName",...
                    string(rst(pa_idx).simd{1,exp_idx}.DataNames(input_species_ID)));

                % Get the correct label for each input of the experiment
                labelfig2(ipt_idx) = rst(pa_idx).simd{1,exp_idx}.DataNames(input_species_ID);

                % Label the y-axis with the correct unit and apply pre-defined
                % font settings.
                ylabel(layout,string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{input_species_ID,1}.Units), ...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

                % Break after plotting the first available set to avoid clutter.
                break
            end
        end
    end
end