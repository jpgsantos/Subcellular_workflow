function output = phenbasal(obj,viewit)
% -------------------------------------------------------------------------
% phenbasal(obj,viewit)
% -------------------------------------------------------------------------
% 'phenbasal'

    bastate(obj,[])

    effector = {'Spine.cAMP';...               
             'Spine.totalD32p34';...
             'Spine.totalD32p75';...
             'Spine.totalpRCS'};

    totalc = {'Spine.DARPP32';...
              'Spine.RCS'};
          
    [totam vobj robj cmpn miss] = FFmodobj(obj,totalc,{},{},{},'phenbasal',viewit);
                           
    output{1,1} = 'Phenotype name';
    output{1,2} = 'basal';
    output{2,1} = 'Model fitted. Single time measurement (4 month)';
    output{2,2} = 10^6;
    output{3,1} = 'Observed phenotypes (basal) @ 4 month';
    output{3,2}{1} = {'cAMP', 'DARPP32-P34', 'DARPP32-P75', 'pRCS'};
    output{3,2}{2} = [60, 0.008*totam(1), 0.24*totam(1), 0.016*totam(2)];
    output{4,1} = 'Non-monitored Phenotypes';
    output{4,2}{1,1} = 'Equilibration in basal';         

    [t,x,names] = relaxsys(obj,[],1);                               
             
    output{4,2}{1,2} = t;   
    output{4,2}{2,3} = x;  
    output{4,2}{3,4} = names;  
    
    for k = 1:length(effector)
        varit = strcmp(names(:),effector{k});
        if ~isempty(varit)
            res(k) = x(end,varit);
        end
    end

    output{3,2}{3} = res;
    
    if (output{3,2}{3}(1) >= 30) && (output{3,2}{3}(1) <= 90)
        output{3,2}{2}(1) = output{3,2}{3}(1);
    elseif output{3,2}{3}(1) < 30
        output{3,2}{2}(1) = 30;
    elseif  output{3,2}{3}(1) > 90
        output{3,2}{2}(1) = 90;
    end 

    if viewit
        scrsz = get(0,'ScreenSize');
        figure('Color','w','Position',round(scrsz))
        bar([1 1 1 1],'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
        hold on;
        bar((output{3,2}{3})./(output{3,2}{2}),'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
        set(gca, 'xticklabel', {['cAMP-',num2str(output{3,2}{2}(1))],['D32p34-',num2str(output{3,2}{2}(2))],...
            ['D32pP75-',num2str(output{3,2}{2}(3))], ['pRCS-',num2str(output{3,2}{2}(4))]})
        title({['Basal State']}) 
        legend({'Experimental','Model'})                  
    end              
end
