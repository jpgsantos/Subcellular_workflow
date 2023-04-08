function plot = f_error_area(X,Y_SD)
tfs=[X];
sq=[Y_SD];
Xh=[tfs(1:end-1); tfs(1:end-1); tfs(2:end); tfs(2:end);];
Yh=[sq(1,1:end-1); sq(2,1:end-1); sq(2,2:end); sq(1,2:end); ];
plot = patch(Xh,Yh,zeros(size(Xh)),'DisplayName',"Data\_SD",'EdgeColor','none','FaceColor',[0 0 0],'FaceAlpha',0.25,'HandleVisibility','off');
end