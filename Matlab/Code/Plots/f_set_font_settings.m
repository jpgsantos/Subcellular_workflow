function f_set_font_settings()
% This function sets various font settings for a plot or figure, such as
% font size, font weight, title spacing, and line width, according to the
% provided configuration. It then assigns these settings to the caller's
% workspace for further use.
%
% Inputs:
% - None
%
% Outputs:
% - None (The function assigns the font settings to the caller's workspace)
%
% Used Functions:
% - None
%
% Variables:
% Loaded:
% - None
%
% Initialized:
% - font_settings: A structure containing the font settings for different
% elements in a plot or figure.
% - font_settings_fields: A cell array of field names in the font_settings
% structure.
%
% Persistent:
% - None

% Set font settings for different elements
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
font_settings.Major_subtitle_FontSize = 8;
font_settings.Major_subtitle_Fontweight = 'bold';
font_settings.Major_subTitle_Spacing = 2;
font_settings.Legend_FontSize = 8;
font_settings.Legend_Fontweight = 'bold';
font_settings.Legend_ItemTokenSize = [20,18];
font_settings.line_width = 1;

% Set font settings for different elements
font_settings_fields = fieldnames(font_settings);

% Iterate through each field name and assign the corresponding value to the
% caller workspace
for i = 1:numel(font_settings_fields)
    assignin('caller', font_settings_fields{i},...
        font_settings.(font_settings_fields{i}))
end
end