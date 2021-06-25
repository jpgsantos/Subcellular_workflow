function output = phensliceDA(obj,viewit,tvect)
% -------------------------------------------------------------------------
% phensliceDA(obj,viewit,tvect)
% -------------------------------------------------------------------------                
% 'phensliceDA'

    bastate(obj,[])
    effectors = {'Spine.totalD32p34';...
                'Spine.totalD32p75';...
                'Spine.totalpRCS'};

    variants = {'High DA'};     
    
    compartments = {'Spine'};
                                                                    
    [totam vobj robj cmpn miss] = FFmodobj(obj,{},variants,{},compartments,'phensliceDA',viewit);
        
    output{1,1} = 'Phenotype name';
    output{1,2} = 'sliceDA';
    output{2,1} = 'Model fitted. Single time measurement (300 sec)';
    output{2,2} = [0 300];
    output{3,1} = 'Observed phenotypes (DA/basal) @ 300 sec';
    output{3,2}{1} = {'DARPP32-P34','DARPP32-P75','pRCS'};
    output{3,2}{2} = [11,0.5,6];
    output{4,1} = 'Non-monitored Phenotypes';
    output{4,2}{1,1} = 'DA to Striatal Slice';     
                             
    if ~isempty(tvect) 
        output{5,1} = 'tvect Time series';   
        output{5,2}{1,1} = 'DA to Striatal Slice';
    end 
    
    relaxsys(obj,[],1);
    
    vobj{1}.active = 1;
     
    [t,x,names] = confANDrun(obj,300,1,[],'ode15s');
              
    output{4,2}{1,2} = t;   
    output{4,2}{2,3} = x;  
    output{4,2}{3,4} = names;
                     
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},names(:),'exact');
        if ~isempty(varit)
            res(k,:) = x(:,varit)';
        end
    end
                
    bar34_75_p = [res(1,end)/res(1,1) res(2,end)/res(2,1) res(3,end)/res(3,1)];
                 
    output{3,2}{3} = [bar34_75_p(1), bar34_75_p(2), bar34_75_p(3)];   
                   
    if ~isempty(tvect)      
        [tv,xv,namesv] = confANDrun(obj,max(tvect),10,tvect,'ode15s');
        output{5,2}{1,2} = tv;
        output{5,2}{2,3} = xv;
        output{5,2}{3,4} = namesv; 
    end
    vobj{1}.active = 0;
    bastate(obj,[]);
                           
    if viewit        
        scrsz = get(0,'ScreenSize');
        figure('Color','w','Position',round(scrsz))

        subplot(2,2,1)
        hold on;
        plot(t,res(1,:))
        plot([300,300],[res(1,1) res(1,end)],'r')
        xlabel('time (s)'); ylabel('DARPP32-P34');
        title(['DA = ',num2str(10000),'nM'])

        subplot(2,2,2)
        hold on;
        plot(t,res(2,:))
        plot([300,300],[res(2,1) res(2,end)],'r')
        xlabel('time (s)'); ylabel('DARPP32-P75');
        title(['DA = ',num2str(10000),'nM'])
        
        subplot(2,2,3)
        hold on;
        plot(t,res(3,:))
        plot([300,300],[res(3,1) res(3,end)],'r')
        xlabel('time (s)'); ylabel('pRCS');
        title(['DA = ',num2str(10000),'nM'])

        subplot(2,2,4)
        bar(output{3,2}{2},'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
        hold on;
        bar(bar34_75_p,'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
        set(gca, 'xticklabel', {'DARPP32-P34','DARPP32-P75','pRCS'})
        title({['Effect of DA = ',num2str(10000),' nM on DARPP32-P34,DARPP32-P75 & RCS in D1R+MSNs. Striatal slices for 5''']})
        legend({'Experimental','Model'})
    end

end
