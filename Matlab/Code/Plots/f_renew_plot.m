function plot = f_renew_plot(plot_name)
% This function closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
%
% Inputs:
% - plot_name: A string representing the name of the figure.
%
% Outputs:
% - plot: A 1x2 cell array containing the figure name and the figure
% handle.
%
% Functions called:
% - findobj: Searches for objects with specified properties.
% - close: Closes open figures.
%
% Variables:
% Loaded:
% None
%
% Initialized:
% - figHandles: An array of figure handles with the specified name.
%
% Persistent:
% None

% Find all figure objects with the given name.
figHandles = findobj('type', 'figure', 'name', plot_name);

% Close existing figures with the same name.
if ~isempty(figHandles)
    close(figHandles);
end

% Store the figure name in the first cell of the output array.
plot{1,1} = plot_name;

% Create a new figure with the specified name and properties, store the
% handle in the second cell of the output array.
plot{1,2} = ...
    figure('WindowStyle', 'docked','Name',plot_name,...
    'NumberTitle', 'off');
end