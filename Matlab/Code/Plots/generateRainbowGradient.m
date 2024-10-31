function colors = generateRainbowGradient(n)


if n == 1
colors = [0, 0, 0.8];
elseif n == 2
colors = [0, 0, 0.8;0.8, 0, 0];
elseif n == 3
colors = [0, 0, 0.8;0, 0.8, 0;0.8, 0, 0];
elseif n == 4
colors = [0, 0, 0.8;0, 0.8, 0;0.8, 0.8, 0;0.8, 0, 0];
else
a = turbo(n+2);
colors = a(2:end-1,:);
end
% % Define the base colors for the rainbow gradient
% baseColors = [
%     % 0.15196, 0.05741, 0.18574;  % Dark Indigo
%     0, 0, 0.8;                  % Blue
%     0, 0.4, 0.8;                % Light Blue
%     0, 0.8, 0.8;                % Cyan
%     0, 0.8, 0;                  % Green
%     0.4, 0.8, 0;                % Light Green
%     0.8, 0.8, 0;                % Yellow
%     0.8, 0.4, 0;                % Orange
%     0.8, 0, 0;                  % Red
%     % 0.51765, 0.04706, 0.06588;  % Dark Red
%     ];
% 
% % Number of base colors
% numBaseColors = size(baseColors, 1);
% if n >= numBaseColors
%     % Interpolation case (same as before)
%     colors = zeros(n, 3);
%     for i = 1:n
%         ratio = (i - 1) / (n - 1) * (numBaseColors - 1);
%         baseIndex = floor(ratio) + 1;
%         if baseIndex < numBaseColors
%             nextIndex = baseIndex + 1;
%             alpha = ratio - floor(ratio);
%             colors(i, :) = (1 - alpha) * baseColors(baseIndex, :) + alpha * baseColors(nextIndex, :);
%         else
%             colors(i, :) = baseColors(end, :);
%         end
%     end
% else
%     % Selection case
%     indices = round(linspace(1, numBaseColors, n));
%     colors = baseColors(indices, :);
% end
end