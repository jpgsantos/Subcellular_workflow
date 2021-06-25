function output = phensliceCa(obj,viewit,tvect)
% -------------------------------------------------------------------------
% phensliceCa(obj,viewit,tvect)
% -------------------------------------------------------------------------                
% 'phensliceCa'

    bastate(obj,[]);
    effectors = {'Spine.totalD32p34';...
                'Spine.totalD32p75'};

    variants = {'High Ca'};                             
    compartments = {'Spine'};
    tonica = 50000;
                                                                    
    [totam vobj robj cmpn miss] = FFmodobj(obj,{},variants,{},compartments,'phensliceCa',viewit);
        
    output{1,1} = 'Phenotype name';
    output{1,2} = 'sliceCa';
    output{2,1} = 'Model fitted. Single time measurement (600 sec)';
    output{2,2} = [0 600];
    output{3,1} = 'Observed phenotypes (Ca/basal) @ 600 sec';
    output{3,2}{1} = {'DARPP32-P34','DARPP32-P75'};
    output{3,2}{2} = [0.5,0.5];
    output{4,1} = 'Non-monitored Phenotypes';
    output{4,2}{1,1} = 'NMDA to Striatal Slice';     
                             
    if ~isempty(tvect) 
        output{5,1} = 'tvect Time series';   
        output{5,2}{1,1} = 'NMDA to Striatal Slice';
    end 
    
    relaxsys(obj,[],1);
    
    vobj{1}.active = 1;
     
    [t,x,names] = confANDrun(obj,600,1,[],'ode15s');
              
    output{4,2}{1,2} = t;   
    output{4,2}{2,3} = x;  
    output{4,2}{3,4} = names;
                     
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},names(:),'exact');
        if ~isempty(varit)
            res(k,:) = x(:,varit)';
        end
    end
                
    bar34_75 = [res(1,end)/res(1,1) res(2,end)/res(2,1)];
                 
    output{3,2}{3} = [bar34_75(1), bar34_75(2)];   
                   
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

        subplot(1,3,1)
        hold on;
        plot(t,res(1,:))
        plot([600,600],[min(res(1,:)) max(res(1,:))],'r')
        xlabel('time (s)'); ylabel('DARPP32-P34');
        title(['Ca = ',num2str(tonica),'nM'])

        subplot(1,3,2)
        hold on;
        plot(t,res(2,:))
        plot([600,600],[min(res(2,:)) max(res(2,:))],'r')
        xlabel('time (s)'); ylabel('DARPP32-P75');
        title(['Ca = ',num2str(tonica),'nM'])

        subplot(1,3,3)
        bar([0.5 0.5],'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
        hold on;
        bar(bar34_75,'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
        set(gca, 'xticklabel', {'DARPP32-P34','DARPP32-P75'})
        title({['Effect of Ca = ',num2str(tonica),' nM on DARPP32-P34 & DARPP32-P75in D1R+MSNs. Striatal slices for 5''']})
        legend({'Experimental','Model'})
    end

end
