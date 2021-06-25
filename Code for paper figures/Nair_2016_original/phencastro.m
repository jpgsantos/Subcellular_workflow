function output = phencastro(obj,viewit)
    
    bastate(obj,[]);
    effectors = {'Spine.cAMP';...
                 'Spine.totalAKAR3p'};
    variants = {'Non Competitive Golf&Gi at AC5. NC = 1',...
                'High DA',...
                'D32T34A',...
                'SKF Parameters'};
            %Competitive Golf&Gi at AC5. NC = 0
%     variants = {'Non Competitive Golf&Gi at AC5. NC = 1',...
%                 'SKF',...
%                 'D32T34A'};
            
    rules = {'0 DA spike',...
             '0 ACh dip',...
             '1 D1R Efficacy Golf binding to D1R',...
             '1 D1R Efficacy Golf binding to D1R*DA',...
             '1 D1R Reverse D1R*Golf',...
             '1 D1R Reverse D1RDA*Golf'};
         
    compartments = {'Spine'};
    
    %Experimental Data for High DA
    highDA_tExp = [1.03; 4.98; 8.94; 12.90; 17.03; 20.98; 24.94; 29.07; 33.03; 36.98; 49.03; 60.90];
    highDA_AKARpercentExp = [10.61; 36.16; 62.03; 79.17; 88.86; 93.38; 95.63; 97.55; 99.80; 100.00; 96.82; 95.80];
    highDA_thalf = 7.9;
    highDA_maxcamp = 2500;
    
    %Experimental Data for 10 sec High DA pulse for wild type
    tenSecDAWT_tExp = [0.0; 10.92; 21.85; 27.32; 53.55; 120.21; 172.67; 238.25; 286.33; 366.12; 438.25; 499.45; 555.19; 600.0];
    tenSecDAWT_AKARpercentExp = [0.0; 23.69; 64.36; 84.70; 92.23; 86.41; 76.41; 61.96; 53.34; 43.63; 36.42; 31.16; 27.28; 22.85];
    tenSecDAWT_thalf = 340;
    tenSecDAWT_bmax = 92.23;
    
    %Experimental Data for 10 sec High DA pulse for DARPP32T34A mutant
    %tenSecDAMutant_tExp = [0.0; 13.11; 22.95; 36.06; 53.55; 71.03; 84.15; 100.54; 121.31; 149.72; 180.32; 224.04; 259.01; 308.19; 359.56; 407.65; 459.01];
    %tenSecDAMutant_AKARpercentExp = [0.0; 34.27; 69.66; 88.32; 83.60; 72.46; 62.72; 52.14; 42.12; 33.50; 28.78; 24.34; 22.13; 19.37; 16.61; 15.24; 11.92];
    %tenSecDAMutant_thalf = 120;
    %tenSecDAMutant_bmax = 90;
    
    %Experimental Data for transient DA uncagging
    transientDA_tExp = [0; 6.37; 9.92; 12.04; 17.71; 31.88; 60.74; 85.74; 103.46; 125.43; 150.94; 180];
    transientDA_AKARpercentExp = [0; 22.0; 49; 60; 81; 94; 80; 68; 55; 43; 32; 25];
    transientDA_thalf = 120;
    transientDA_bmax = 94;
    
    
    [totam vobj robj cmpn miss] = FFmodobj(obj,[],variants,rules,compartments,'phencastro',viewit);
    
    output{1,1} = 'Phenotype name';
    output{1,2} = 'sliceD1MSNphosphoAKAR3';
    output{2,1} = 'Model fitted. Two time measurements (70 and 600 sec)';
    output{2,2} = [0 70 600];
    output{3,1} = 'Observed phenotypes (max(cAMP), AKAR3 phosphorylation) @ 70 sec, AKAR3 dephosphorylation @ 600 sec';
    output{3,2}{1} = {'cAMP','t(on)1/2', 'BMax(WT 10sec pulse)', 't(off)1/2(WT 10sec pulse)', 'BMax(DA uncagging)', 't(off)1/2(DA uncagging)'};
    output{3,2}{2} = [highDA_maxcamp, highDA_thalf, tenSecDAWT_bmax, tenSecDAWT_thalf, transientDA_bmax, transientDA_thalf];
    output{4,1} = 'Non-monitored Phenotypes';
    output{4,2}{1,1} = 'AKAR3 phosphorylation by tonic DA'; 
    output{4,2}{2,1} = 'AKAR3 phosphorylation by DA pulse on striatal slice'; 
    %output{4,2}{3,1} = 'AKAR3 phosphorylation by DA pulse on D32T34A striatal slice'; 
    output{4,2}{3,1} = 'AKAR3 phosphorylation by DA uncaging'; 
    
    parnamDA = {'nDA_ampbasal','nDA_ampmax','nDA_peakfirst','nDA_k1','nDA_k2','nDA_peakdens','nDA_peakn','nDA_peaklngth'};
    parvalDA = [            10,      1000,              2,     500,     0.2,             1,          1,               2];
    origparvalDA = zeros(1,8);
    
    for i = 1:length(parnamDA)
        pobj = sbioselect(obj,'Name', parnamDA{i});
        origparvalDA(i) = get(pobj,'Value');
        set(pobj,'Value',parvalDA(i));
    end
    
    parnamACh = {'nACh_ampbasal','nACh_ampmax','nACh_peakfirst','nACh_k1','nACh_k2','nACh_peakdens','nACh_peakn','dipdep','nACh_peaklngth'};
    parvalACh = [            15,            15,               2,      500,      0.2,              1,           1,    0.01,               2];
    origparvalACh = zeros(1,8);
    
    for i = 1:length(parnamACh)
        pobj = sbioselect(obj,'Name', parnamACh{i});
        origparvalACh(i) = get(pobj,'Value');
        set(pobj,'Value',parvalACh(i));
    end
    
    vobj{1}.active = 1;
    relaxsys(obj,[],0);
    
    %Run high DA
    robj{1}.active = 0;
    robj{2}.active = 0;
    vobj{2}.active = 1;
    [tss,xss,namesss] = confANDrun(obj,70,0.05,[],'ode15s');
    vobj{2}.active = 0;
    
    output{4,2}{1,2} = tss;   
    output{4,2}{1,3} = xss;  
    output{4,2}{1,4} = namesss;
    
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},namesss(:),'exact');
        if ~isempty(varit)
            resss(k,:) = xss(:,varit)';
        end
    end
    
    campIdx = strmatch('Spine.cAMP',effectors(:),'exact');
    akarIdx = strmatch('Spine.totalAKAR3p',effectors(:),'exact');
    time0ss = getTime0(tss, resss(akarIdx,:));
    tss = tss - repmat(time0ss,length(tss),1);
    
    thalfon = getXforY(tss, resss(akarIdx,:), 0.5, 1, 0, []);
    maxcAMP = resss(campIdx, end);
    
    normalisedCurveSS = (resss(akarIdx,:) - repmat(resss(akarIdx,1), 1, length(resss(akarIdx,:))))... 
                        ./ repmat(max(resss(akarIdx,:)) - resss(akarIdx,1), 1, length(resss(akarIdx,:)))...
                        .* repmat(100.0, 1, length(resss(akarIdx,:)));
    tss = tss + repmat(time0ss,length(tss),1);
    
    %Run DA transient for WT
    plengthDA = sbioselect(obj,'Name', 'nDA_peaklngth');
    set(plengthDA,'Value',10);
    ampmaxDA = sbioselect(obj,'Name', 'nDA_ampmax');
    set(ampmaxDA,'Value',1000);
    
    vobj{4}.active = 1;
    robj{1}.active = 1;
    for i=2:6
        robj{i}.active = 0;
    end
    [t,x,names] = confANDrun(obj,600,0.05,0:0.1:600,'ode15s');
    vobj{4}.active = 0;
    for i=3:6
        robj{i}.active = 1;
    end
    
    output{4,2}{2,2} = t;   
    output{4,2}{2,3} = x;  
    output{4,2}{2,4} = names;
    
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},names(:),'exact');
        if ~isempty(varit)
            res(k,:) = x(:,varit)';
        end
    end
    normalisedCurveWT = (res(akarIdx,:) - repmat(resss(akarIdx,1),1,length(res(akarIdx,:))))... 
                        ./ repmat((max(resss(akarIdx,:)) - resss(akarIdx,1)),1,length(res(akarIdx,:)))...
                        .* repmat(100,1,length(res(akarIdx,:)));
    [decreasingCurvex, decreasingCurvey] = getPartOfTimeSeries(t, normalisedCurveWT', 1);
    actualstart = find(decreasingCurvey == max(decreasingCurvey));
    decreasingCurvex = decreasingCurvex(actualstart:end);
    decreasingCurvey = decreasingCurvey(actualstart:end);
    
    thalfOffWT = getXforY(decreasingCurvex, decreasingCurvey, 0.5, 0, 0, []);
    bmaxWT = max(normalisedCurveWT);
    
    %Run D32T34A mutant
%     vobj{1}.active = 1;
%     vobj{3}.active = 1;
%     relaxsys(obj,[],0);
%     
%     robj{1}.active = 0;
%     vobj{2}.active = 1;
%     [tm,xm,namesm] = confANDrun(obj,70,0.05,[],'ode15s'); %SS for the mutant
%     vobj{2}.active = 0;
%     
%     varit = strmatch(effectors{akarIdx},namesm(:),'exact');
%     akar3_mutant = xm(:,varit);
%     basalSSm = akar3_mutant(1);
%     maxSSm = max(akar3_mutant);
%     
%     plengthDA = sbioselect(obj,'Name', 'nDA_peaklngth');
%     set(plengthDA,'Value',10);
%     ampmaxDA = sbioselect(obj,'Name', 'nDA_ampmax');
%     set(ampmaxDA,'Value',10000);
%     
%     robj{1}.active = 1;
%     [tm,xm,namesm] = confANDrun(obj,600,0.05,0:0.1:600,'ode15s');
%     
%     output{4,2}{3,2} = tm;   
%     output{4,2}{3,3} = xm;  
%     output{4,2}{3,4} = namesm;
%     
%     for k = 1:length(effectors)
%         varit = strmatch(effectors{k},namesm(:),'exact');
%         if ~isempty(varit)
%             resm(k,:) = xm(:,varit)';
%         end
%     end
%     normalisedCurveMutant = (resm(akarIdx,:) - repmat(basalSSm,1,length(resm(akarIdx,:))))...
%                             ./ repmat((maxSSm - basalSSm),1,length(resm(akarIdx,:)))...
%                             .* repmat(100,1,length(resm(akarIdx,:)));
%     [decreasingCurvex, decreasingCurvey] = getPartOfTimeSeries(tm, normalisedCurveMutant', 1);
%     actualstart = find(decreasingCurvey == max(decreasingCurvey));
%     decreasingCurvex = decreasingCurvex(actualstart:end);
%     decreasingCurvey = decreasingCurvey(actualstart:end);
%     
%     thalfOffmutant = getXforY(decreasingCurvex, decreasingCurvey, 0.5, 0, 0, []);
%     bmaxmutant = max(normalisedCurveMutant);
    
    %Run for the DA uncagging case
    stimLength = 1.5;
    ampmaxDA = sbioselect(obj,'Name', 'nDA_ampmax');
    set(ampmaxDA,'Value',5000);
    plengthDA = sbioselect(obj,'Name', 'nDA_peaklngth');
    set(plengthDA,'Value',stimLength);
    plengthACh = sbioselect(obj,'Name', 'nACh_peaklngth');
    set(plengthACh,'Value',stimLength);
    
    vobj{1}.active = 1;
    vobj{3}.active = 0;
    relaxsys(obj,[],0);
    
    robj{1}.active = 1;
    robj{2}.active = 1;
    [tu,xu,namesu] = confANDrun(obj,600,0.05,0:0.1:180,'ode15s');
    
    output{4,2}{3,2} = tu;   
    output{4,2}{3,3} = xu;  
    output{4,2}{3,4} = namesu;
    
    for k = 1:length(effectors)
        varit = strmatch(effectors{k},namesu(:),'exact');
        if ~isempty(varit)
            resu(k,:) = xu(:,varit)';
        end
    end
    
    normalisedCurveDAU = (resu(akarIdx,:) - repmat(resss(akarIdx,1),1,length(resu(akarIdx,:))))... 
                        ./ repmat((max(resss(akarIdx,:)) - resss(akarIdx,1)),1,length(resu(akarIdx,:)))...
                        .* repmat(100,1,length(resu(akarIdx,:)));
    [increasingCurvexU, increasingCurveyU] = getPartOfTimeSeries(tu, normalisedCurveDAU', 0);
    actualend = find(increasingCurveyU == max(increasingCurveyU));
    increasingCurvexU = increasingCurvexU(1:actualend);
    increasingCurveyU = increasingCurveyU(1:actualend);
    time0u = getTime0(increasingCurvexU, increasingCurveyU);
    
    tu = tu - repmat(time0u,length(tu),1);
    [decreasingCurvexU, decreasingCurveyU] = getPartOfTimeSeries(tu, normalisedCurveDAU', 1);
    actualstart = find(decreasingCurveyU == max(decreasingCurveyU));
    decreasingCurvexU = decreasingCurvexU(actualstart:end);
    decreasingCurveyU = decreasingCurveyU(actualstart:end);

    thalfOffDAU = getXforY(decreasingCurvexU, decreasingCurveyU, 0.5, 0, 0, []);
    bmaxDAU = max(normalisedCurveDAU);
    tu = tu + repmat(time0u,length(tu),1);
    
    % Reseting the parameter values.
    for i = 1:length(parnamDA)
        pobj = sbioselect(obj,'Name', parnamDA{i});
        set(pobj,'Value',origparvalDA(i));
    end
    for i = 1:length(parnamACh)
        pobj = sbioselect(obj,'Name', parnamACh{i});
        set(pobj,'Value',origparvalACh(i));
    end
    
    output{3,2}{3} = [maxcAMP thalfon bmaxWT thalfOffWT bmaxDAU thalfOffDAU];
    
    if viewit
       figure('Color','w','Position',get(0,'ScreenSize'))
       hold on;
       
       subplot(2,6,1)
       hold on
       title('10000 nM tonic DA');
       plot(tss, resss(campIdx,:), 'k', 'LineWidth',2);
       xlabel('time (s)');
       ylabel('cAMP (nM)');
       
       subplot(2,6,2)
       hold on
       title('10000 nM tonic DA');
       plot(tss, normalisedCurveSS, 'k', 'LineWidth',2);
       plot(highDA_tExp + repmat(time0ss,length(highDA_tExp),1), highDA_AKARpercentExp, 'k.','MarkerSize',20);
       xlabel('time (s)');
       ylabel('% AKAR3 phosphorylation');
       legend({'Model','Experimental'})
       
       subplot(2,6,[3,4])
       hold on
       title('Transient DA');
       plot(tu, normalisedCurveDAU, 'k', 'LineWidth',2);
       plot(transientDA_tExp + repmat(time0u, length(transientDA_tExp), 1), transientDA_AKARpercentExp, 'k.','MarkerSize',20);
       xlabel('time (s)');
       ylabel('% AKAR3 phosphorylation');
       legend({'Model', 'Experimental'})
       
       subplot(2,6,[5,6])
       bar([highDA_maxcamp/1000 highDA_thalf],'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
       hold on
       bar([maxcAMP/1000 thalfon],'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
       set(gca, 'xticklabel', {'cAMP (uM)','AKAR3 phosphorylation t1/2 (s)'});
       title({['Effect of 10000 nM DA on cAMP level & AKAR3 phosphorylation in D1R+MSNs.']});
       legend({'Experimental','Model'})
       
       subplot(2,6,[7,8])
       hold on
       title('10000 nM DA pulse for 10 sec');
       plot(t, normalisedCurveWT, 'k', 'LineWidth',2);
       plot(tenSecDAWT_tExp, tenSecDAWT_AKARpercentExp, 'k.','MarkerSize',20);
       xlabel('time (s)');
       ylabel('% of Steady State AKAR3 phosphorylation');
       legend({'Model', 'Experimental'})
       
       subplot(2,6,[9,10])
       bar([transientDA_bmax transientDA_thalf],'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
       hold on
       bar([bmaxDAU thalfOffDAU],'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
       set(gca, 'xticklabel', {'phospho AKAR3 Bmax','AKAR3 dephosphorylation t1/2 (s)'});
       title({['Effect of 1.5 sec DA uncaging on AKAR3 in D1R+MSNs.']});
       legend({'Experimental','Model'})
       
       subplot(2,6,[11,12])
       bar([tenSecDAWT_bmax tenSecDAWT_thalf],'BarWidth',0.5,'FaceColor', 'w', 'EdgeColor', 'k');
       hold on
       bar([bmaxWT thalfOffWT],'BarWidth',0.25,'FaceColor', 'r', 'EdgeColor', 'r');
       set(gca, 'xticklabel', {'phospho AKAR3 Bmax','AKAR3 dephosphorylation t1/2 (s)'});
       title({['Effect of 10 sec pulse of 10000 nM DA on AKAR3 in D1R+MSNs(WT).']});
       legend({'Experimental','Model'})
    end
    
end

function time0 = getTime0(x, y)
% This calculate the time 0 for the high DA case for AKAR3 phosphorylation.
% The time 0 is the point of intersection between the basal line and the
% line connecting 10% and 90%

    basalLiney = [y(1) y(1)];
    basalLinex = [x(1) x(end)];
    
    TenNintyLiney = [((max(y)-y(1))*0.1+y(1)) ((max(y)-y(1))*0.9+y(1))];
    TenNintyLinex = [getXforY(x, y, 0.1, 1, 0, []) getXforY(x, y, 0.9, 1, 0, [])];
    
    p1 = polyfit(basalLinex,basalLiney,1);
    p2 = polyfit(TenNintyLinex,TenNintyLiney,1);
    
    time0 = fzero(@(x) polyval(p1-p2,x),3);
end

function reqx = getXforY(x, y, yfraction, normalisemin, doSpline, steps)
% This function returns the value of x for which y reached half of the
% maximum value. This is not intelligent enough to handle non-monotonic
% function values. If provided with non-monotonic values it will return
% unreliable values depending on the resolution of spline. 
    
    xx = x; yy = y; offset = 0;
    if isempty(steps)
        steps = 1000;
    end
    
    if doSpline
        xx = linspace(x(1),x(end),steps);
        yy = spline(x,y,xx);
    end
    
    if normalisemin
        offset = min(yy);
    end
    yy = abs(yy - repmat((((max(yy)-offset)*yfraction)+offset),size(yy,1),1));
    reqIndex = find(yy == min(yy));
    
    reqx = xx(reqIndex);
end

function [xx, yy] = getPartOfTimeSeries(x, y, isdecreasing)
% This function return the increasing or decreasing part of a time series.
% if the flag 'isdecreasing' = 1 then it will return the decreasing part
% otherwise it returns increasing part. 
    derivative = diff(y)./diff(x);
    if isdecreasing
        indices = find(derivative < 0);
    else
        indices = find(derivative > 0);
    end
    xx = x(indices);
    yy = y(indices);
end
