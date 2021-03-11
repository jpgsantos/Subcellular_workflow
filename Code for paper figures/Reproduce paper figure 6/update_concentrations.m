function update_concentrations(file,time,conc, varargin)

%DA_spec = '@Spine:DA(d1r)';
%Ca_spec = '@Spine:Ca(ac5,b72pp2a,cam)';
%type = 'setConc';
%%DA_spec = 'glu(x)@PSD';
%%Ca_spec = 'Ca(x)@Synapse';

%DA_spec = 'DA_ar0';
%Ca_spec = 'Ca_ar0';
%type = 'setParam';

%%DA_spec = '@psd:b()';
%%Ca_spec = '@Spine:a1()';
%%type = 'setConc';

%sout = cell(length(timer_)*2,1); 
% fconv=1;
% if length(varargin)>1
%     fconv=varargin{2};
% end
add=0;
name_rnf=[];
if ~isempty(varargin)
    name_rnf = varargin{1};
    if length(varargin)>1
        add=varargin{2};
    end
    compartment='';
    if length(varargin)>2
    compartment=['@',varargin{3}];
    end
end
if add==0
fid = fopen(file,'w');
else
fid = fopen(file,'a');    
end    
% %'clampConc','DA()@Spine '; 'clampConc','Ca()@Spine';
% fprintf(fid,'%e \t',0);
% fprintf(fid,'%s \t','clampConc');
% fprintf(fid,'%s \t','DA()@Spine');
% fprintf(fid,'%e \n',1);
% 
% fprintf(fid,'%e \t',0);
% fprintf(fid,'%s \t','clampConc');
% fprintf(fid,'%s \t','Ca()@Spine');
% fprintf(fid,'%e \n',1);

for i=1:length(time) 

   for j=1:size(conc,2)
       fprintf(fid,'%e \t',time(i));
       stim_type = conc{'stim_type',j}{1};
       fprintf(fid,'%s \t',stim_type);
       stim_name = conc{'stim_name',j}{1}; %[conc.Properties.VariableNames{j},'()',compartment];
       fprintf(fid,'%s \t',stim_name);
       stim_value = conc{'value',j}{1};
       fprintf(fid,'%e \n',stim_value);
   end
   %fprintf(fid,'%e \t',timer_(i));
   %fprintf(fid,'%s \t',type);
   %fprintf(fid,'%s \t',DA_spec);
   %fprintf(fid,'%e \n',DA_ar(i));

end
fclose(fid);
%plot(t,x)

%dlmwrite('Ca_DA_stim.tsv',[DA_ar, Ca_ar],'\t')

%

%save .rnf file
if ~isempty(varargin)
    name_rnf = varargin{1};
end
if ~isempty(name_rnf)    
fid2 = fopen([file,'.rnf'],'w');
fprintf(fid2,'%s \t','-xml ');
fprintf(fid2,'%s \n',name_rnf);
fprintf(fid2,'%s \n','-utl 3');
%-xml simple_system.xml
%-v
%-utl 3      
%-o simple_system_fromRNF.gdat

fprintf(fid2,'%s \n','begin');
% eq 50 5
% sim 50 100
% set kcat 0.01
% update
t0 = time(1);
fprintf(fid2,'%s \t','eq'); 
fprintf(fid2,'%e \t 50 \n',t0);

for i=2:length(time) 
   fprintf(fid2,'%s \t','sim'); 
   fprintf(fid2,'%e \t 1 \n',time(i)-t0);
   t0=time(i);
   for j=1:size(stim_name,1)
       stim_type = 'set';
       if stim_name{j,1}=='setParam'
       stim_type = 'set';
       end
       fprintf(fid2,'%s \t',stim_type);
       fprintf(fid2,'%s \t',stim_name{j,2});
       fprintf(fid2,'%e \n',value(i,j));
   end
   fprintf(fid2,'%s \n','update');
   %fprintf(fid,'%e \t',timer_(i));
   %fprintf(fid,'%s \t',type);
   %fprintf(fid,'%s \t',DA_spec);
   %fprintf(fid,'%e \n',DA_ar(i));

end


fprintf(fid2,'%s \n','end');
fclose(fid2);
end