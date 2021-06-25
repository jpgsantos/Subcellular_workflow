function output = phenall(obj,viewit,parinput,tvect)
% -------------------------------------------------------------------------
%        output = phenall(obj,viewit,parinput,tvect)
% -------------------------------------------------------------------------
% 'phenall' is a wrapper of runs for several phenotypes:
% - phenbasal
% - phensliceDA
% - phensliceCa
% - phenpascoliNMDA
% - phentrafficNMDA
% - phenhaplo*
% - phenyasudaRAS
%
% The phenotype scripts can be divided in 2 groups based on the requirement of re-equilibration.
% The ones that don't require re-equilibration are those where the perturbations are just in the input functions.
% The ones that do require re-equilibration have experimental perturbations in model parameters and/or total amounts (marked * above).
% In this second case the model is re-equilibrated after the substitution of phenotype specific perturbations and then re-equilibrated again back to wild-type state.
% This is the case of haploinsuficient and DARPP32KO
% When parameter/amounts scan is being performed for sensitivity analysis or for optimization in each of these re-equilibrations the total amount vector being 
% scanned is substituted before each of these re-equilibrations with the function 'setotalX'.  
%
% IMPORTANT: The variants that specify parameter values and are turned on by default during the simulations have the highest hierarchy in Simbiology 
%            and do prevent user defined parameter changes (like in sensitivity analysis and parameter scan) to be set.
%
% The arguments of the 'phenall' function are:
% -       obj: This is the model object.
% -    viewit: A Boolean. If you want to see some interesting graphs. Needless to say, this shoud be turned off (0) during parameter scanning.
% -  parinput: This is a user defined parameter vector. It is indeed a 3 membered cell array with the structures 'parm' , 'spec' and 'prsp'. 
%              Each of these structures have two fields: names and values. And they contain the user defined parameters, total amounts and species-as-parameters, 
%              respectively in case the user is running the simulations with values other than the default. This is the case for parameter optimization or sensitivity analysis.
% -     tvect: A user defined vector of times to run a simulation in those phenotype scripts that allows it and same the concentration of effectors at those times. 
%              If left empty, the sampling is not performed.
%{
The output of each phenotype script is a cell array with as many cells as phenotypes. 
Each of this cells contains a cell array with two columns and from 3 to 5 rows. 
For example, for the phenotype 'haploGolf':

>> output =

   'Phenotype name'                                         'haploD1R'
   'Model fitted. Single time measurement (900 sec)'        [1x2 double]
   'Observed phenotypes (KO/WT)*100 @ 900 sec'              {1x3 cell }
   'Non-monitored Phenotypes'                               {2x4 cell  }
   'tvect Time series'                                      {2x4 cell  }

Each cell in column 1 has a text describing what is in the column 2.
Row 3 column 2 contains a cell array with three columns in which the experimental results of each phenotype and the simulated value are stored. For example;

>> output(3,:)

   'Observed phenotypes (KO/WT)*100 @ 900 sec'    {1x3 cell}

The first cell has an array with the names of the variables, the second a vector with the experimental values and the third a vector with the simulated results.

Row 5 column 5 contains a cell array with the simulated values for the user-defined time vector if any.
This cell array has as many rows as runs and 4 columns: name of the run, time vector, simulation results (time x species matrix) 
and an array with the species names (in the same order than the columns in the previous matrix).
This cell array has as many rows as experimental conditions in the phenotype

 %}
% This is an example of the user defined parameters and total amounts. 

  parm.names = {'kfERKpp*STEP','kcatSTEP*ERKpp'};
 parm.values = [0.67,0.6];
  spec.names = {'STEP'};
 spec.values = 300;  
 

 %% These 5 lines are compulsory
         act = checkrules(obj,[],0);                                        % Detect rules running transient inputs
               checkrules(obj,act,0);                                       % Disable rules running transient inputs     
                FFparamin(obj,parm,[]);                                       % Substitute the user-defined parameters in the model
                setotalX(obj,spec);                                           % Substitute user defined total amounts in the model 
   output{1} = phenbasal(obj,viewit);                                       % Equilibrate the system. Output is relevant to check that the basal state is correct.

 %% The scripts with phenotypes are optional

   whichphen = [1,...       % phensliceDA
                1,...       % phensliceCa
                0,...       % phenpascoliNMDA: This phenotype is to be matched just qualitatively.
                0,...       % phentrafficNMDA
                0,...       % phenhaplo
                0,...       % phenyasudaRAS  
                0,...       % phencastro
                0];         %phengpcr
            
if whichphen(1)  
   output{2} = phensliceDA(obj,viewit,tvect);
end

if whichphen(2)
   output{3} = phensliceCa(obj,viewit,tvect);
end

if whichphen(3)
   output{4} = phenpascoliNMDA(obj,viewit);
end

if whichphen(4)
   FFbastate(obj,0)                                                         % This need to be run here due to an unresolve bug. Even at MatLab they haven't been able to solve this issue.
   output{5} = phentrafficNMDA(obj,viewit,tvect);
end

if whichphen(5)
   output{6} = phenhaplo(obj,viewit,spec);                                  % As you can see 'phenhaplo' gets the argument 'spec' because as it needs to re-equilibrate, 
end                                                                         % any user defined change in the total amounts must be updated at each re-equilibration.

if whichphen(6)
   output{7} = phenyasudaRAS(obj,viewit);
end  

if whichphen(7)
    output{8} = phencastro(obj,viewit);
end

if whichphen(8)
    output{9} = phengpcr(obj,viewit);
end
   
 checkrules(obj,act,1);                                                     % Reactivate rules running transient inputs.

 
 %% Generation of the Simulated vs. Experimental plot.
 
       scrsz = get(0,'ScreenSize');
        figure('Color','w','Position',round(scrsz))
        hold on;
         clf = {'w','k','b','r','g','m','c','y','r','g','m'};
         clb = {'k','r','y','y','r','k','g','b','g','m','r'};   
          ct = 0;
          
      for i = 1:length(output)
        if ~isempty(output{i})
          ct = ct + 1;  
       plot(log2(output{i}{3,2}{2}),log2(output{i}{3,2}{3}),'o','MarkerSize',9, 'MarkerFaceColor',clf{ct},'MarkerEdgeColor',clb{ct})
            if ct == 1
       exper = output{i}{3,2}{2};
       simul = output{i}{3,2}{3};       
         leg = output{i}(1,2);
            else
       exper = [exper output{i}{3,2}{2}];
       simul = [simul output{i}{3,2}{3}];
         leg = [leg; output{i}(1,2)];
            end       
        end
      end
      
          il = min([log2(exper) log2(simul)]);
          xl = max([log2(exper) log2(simul)]);    

      plot([il,xl],[il xl])     
      
      plot([il-sign(il)*0.83 xl],[il xl-sign(xl)*0.83],'r--')
      plot([il xl-sign(xl)*0.83],[il-sign(il)*0.83 xl],'r--')
      
      plot([il-sign(il)*0.37 xl],[il xl-sign(xl)*0.37],'r--')
      plot([il xl-sign(xl)*0.37],[il-sign(il)*0.37 xl],'r--')
      xlabel('log2(Experimental)')
      ylabel('log2(Simulated)')
      legend(leg)
           
end