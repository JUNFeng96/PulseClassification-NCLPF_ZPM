% Main pulse classification script  [JUN Feng,2020]
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
 fprintf(fid_pulse_datas,'%s\r\n','Acc. Filename,Er-v-2p-1,Er-v-2p-2,Er_max,PGV,PEAK_PULSE,Tp,Number of pulses'); 
     
for n=1:1
 filename=[leg_str(n).folder,'./',leg_str(n).name];
 [Acc,dt,NPTS,errCode]=parseAT2(filename);
 
%%% Convert Acc (in g) to velocity (in cm/s) %%%
 velocity=cumsum(Acc)' .* dt .* 981;  % Velocity time histories (original ground motion) 
 t=0:dt:dt*(NPTS-1);   % Time 
 Signal=velocity;
 
%%% Define the parameters %%%
 Vp=cell(1,2);          
 Tp=zeros(1,2);
 Vp_max=zeros(1,2);
 Er=zeros(1,2);

for index=1:2
 for i=0:0.01:3.99
  fc=4-i;                % Cut-off frequency
  Wc=fc*dt*2;   
  [b, a]=butter(4, Wc);  % Filter order 4
  Signal_Filter=filtfilt(b, a, Signal);  % Butterworth non-causal filtering
  [Vp{index},Tp(index),Vp_max(index),code]=zero_point_method(Signal_Filter,dt);  % Extraction of pulse signal
  if code==1
   break;
  end
 end
 Er(index)=sum(Vp{index}.*Vp{index})/sum(velocity.*velocity);
 Signal=Signal-Vp{index}';
end
%%% Classification standard of pulse-like ground motion %%%
[pulse_type,FP,Er_max,Er_index]=classification_standard(velocity,Vp,Vp_max,Er);
 
 fprintf(fid_pulse_datas,'%s%s%d%s%d%s%d%s%d%s%d%s%d%s%d%s%d\r\n',...
 leg_str(n).name,',',Er(1),',',Er(2),',',Er_max,',',Er(1)+Er(2),',',...
 max(abs(velocity)),',',max(abs(FP)),',',Tp(Er_index), ',',pulse_type);

%     if pulse_type~=0
%      make_plot_comparison(FP,velocity,t);  % Makes the plot of original ground motion and extracted pulse
%     end
disp(n)
end
fclose(fid_pulse_datas);
