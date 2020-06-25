function varargout = patch_error_plot(xdata,ydata,Percs,FColor,Falpha)

tfs=xdata;
sq=sort(ydata,2); n=size(sq,2); n1=fix(n*Percs(1))+1; n2=fix(n*Percs(2));
Xh=[tfs(1:end-1); tfs(1:end-1); tfs(2:end); tfs(2:end);];
Yh=[sq(1:end-1,n1)'; sq(1:end-1,n2)'; sq(2:end,n2)'; sq(2:end,n1)'; ]; 
patch(Xh,Yh,zeros(size(Xh)),'EdgeColor','none','FaceColor',FColor,'FaceAlpha',Falpha)