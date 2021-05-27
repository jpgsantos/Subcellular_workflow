save_rnf(file,t,x,names)

DA_spec = '@Spine:DA(d1r)';
Ca_spec = '@Spine:Ca(ac5,b72pp2a,cam)';
type = 'setConc';
%DA_spec = 'glu(x)@PSD';
%Ca_spec = 'Ca(x)@Synapse';

DA_spec = 'DA_ar0';
Ca_spec = 'Ca_ar0';
type = 'setParam';

%DA_spec = '@psd:b()';
%Ca_spec = '@Spine:a1()';
%type = 'setConc';

%sout = cell(length(timer_)*2,1); 

fid = fopen(file,'w');

for i=1:length(t) 
   
   
   for j=1:length(names)
       fprintf(fid,'%e \t',t(i));
       fprintf(fid,'%s \t',names(j).type);
       fprintf(fid,'%s \t',names(j).name);
       fprintf(fid,'%e \n',names(j).value);
   end
   %fprintf(fid,'%e \t',timer_(i));
   %fprintf(fid,'%s \t',type);
   %fprintf(fid,'%s \t',DA_spec);
   %fprintf(fid,'%e \n',DA_ar(i));

end
fclose(fid);
plot(timer_,[DA_ar, Ca_ar])

%dlmwrite('Ca_DA_stim.tsv',[DA_ar, Ca_ar],'\t')

