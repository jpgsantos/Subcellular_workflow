function f_save_plots(mmf)

Analysis_date_folder = mmf.model.results.analysis.date.main;

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');

mkdir(Analysis_date_folder);

savefig(FigList(end:-1:1),...
    Analysis_date_folder + "All_figures.fig");

for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = get(FigHandle, 'Name');
    
    saveas(FigHandle, Analysis_date_folder + FigName + ".png")
end
end