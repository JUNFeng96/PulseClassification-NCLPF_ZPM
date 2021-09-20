% Main pulse classification script
%%%%%%%%%%%%%%%%
%
% Inputs : 
% Ground motion (AT2)
%
% Outputs
% pulse_datas 
%
%%%%%%%%%%%%%%%%%
clear all;
close all;

 leg_str=dir('./The folder of Ground motion (AT2)./*.AT2');  % The folder of Ground motion (AT2)
 N=length(leg_str);
 fid_pulse_datas=fopen('./Classification results.txt','w');  % Record the data about the extracted pulse
 fprintf(fid_pulse_datas,'%s\r\n','PM_Name,PGV,PEAK_PULSE,Tp,Er-1,Er-2,pulse_type'); 
     
for n=1:N
 filename=[leg_str(n).folder,'./',leg_str(n).name];
 [Acc,dt,NPTS,errCode]=parseAT2(filename);
 
%%% Convert Acc (in g) to velocity (in cm/s) %%%
 velocity=cumsum(Acc)' .* dt .* 981;  % Velocity time histories (original ground motion) 
 t=0:dt:dt*(NPTS-1);   % Time 
 Signal=velocity;
 
%%% Define the parameters %%%
 fp=cell(1,2);          
 Tp=zeros(1,2);
 fp_max=zeros(1,2);
 Er=zeros(1,2);

for index=1:2
   
 for i=0:0.01:3.99
    
  fc=4-i;  % Cut-off frequency
  Wc=fc*dt*2;   
  [b, a]=butter(4, Wc);  % Filter order 4
  Signal_Filter=filtfilt(b, a, Signal);  % Butterworth non-causal filtering

  [fp{index},Tp(index),fp_max(index),code]=zero_point_method(Signal_Filter,dt);  % Extraction of pulse signal
  if code==1
   break;
  end
 end

 Er(index)=sum(fp{index}.*fp{index})/sum(velocity.*velocity);
 Signal=Signal-fp{index}';
end


%%% Classification standard of pulse-like ground motion %%%
 [Er_max,Er_index]=max(Er);
 
 pulse_type=0;
 if Er(2)+Er(1)>0.55 && min(Er)>0.75*max(Er) 
   FP=fp{1}'+fp{2}';
   pulse_type=2;
 elseif Er(2)+Er(1)>0.55 && Er(2)>0.5*Er(1) && fp_max(2)>0.75*fp_max(1)
   FP=fp{1}'+fp{2}';
   pulse_type=2;
 elseif Er_max>0.32 && pulse_type==0
    pulse_type=1;
    FP=fp{Er_index}';
 elseif Er_max<=0.32 && pulse_type==0
    pulse_type=0;
    FP=0;
 end

 fprintf(fid_pulse_datas,'%s%s%d%s%d%s%d%s%d%s%d%s%d\r\n',...
 leg_str(n).name,',',max(abs(velocity)),',',max(abs(FP)),',',Tp(Er_index),',',Er(1),',',Er(2),',', pulse_type);

   if pulse_type~=0
    make_plot_comparison(FP,velocity,t);  % Makes the plot of original ground motion and extracted pulse
   end
disp(n)
end
fclose(fid_pulse_datas);
