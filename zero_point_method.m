% Script for extracting pulse signal.
% Based on the zero-point method
%%%%%%%%%%%%%%%%
%
% Inputs : 
% -Ground motion after Butterworth filtering (Signal_Filter)
% -Time step used for recording (dt)
%
% Outputs
% -Pulse signal (fp)
% -Pulse period (Tp)
% -Peak value of pulse signal (fp_max)
% -code to indicate the number of peak-points in the pulse signal
%   --Code = 1 if successful, 0 if failure
%%%%%%%%%%%%%%%%%

function [fp,Tp,fp_max,code]=zero_point_method(Signal_Filter,dt)

%%% If the filtered signal is not 0 %%%
if Signal_Filter~=0  
 [pks,locs]=findpeaks(abs(Signal_Filter));  % finds local peaks in the filtered signal
 [fp_max,pks_index]=max(pks);
 locs_max=locs(pks_index);
 zero_point=zeros(1,length(Signal_Filter));  % zero-points
 n=0;
 
%%% finds zero-points in the filtered signal %%%
 for i=2:length(Signal_Filter)
  if Signal_Filter(i-1)*Signal_Filter(i)<0
   n=n+1;
   zero_point(n)=i-1;               
  end        
 end
 
%%% finds zero-points of pulse signal %%%
 for j=1:n
  if zero_point(j)>locs_max
   if j==1  % If the pulse peaks in the first half-cycle interval of the Signal_Filter
    zero_point_1=1;
    zero_point_2=zero_point(j);   
   else
    zero_point_1=zero_point(j-1);
    zero_point_2=zero_point(j); 
   end   
   break; 
  end
 end
 
 if j<3  
  zero_point_3=1;
  zero_point_4=zero_point(j+1); 
 elseif j>length(Signal_Filter)-1  % If the pulse peaks in the last half-cycle interval of the Signal_Filter
  zero_point_3=zero_point(j-2);
  zero_point_4=length(Signal_Filter);
 else
  zero_point_3=zero_point(j-2);
  zero_point_4=zero_point(j+1);     
 end 
 
%%% Another half-cycle interval adjacent to the one in which the peak value is located %%     
 half_cycle_interval_1(zero_point_2:zero_point_4)=Signal_Filter(zero_point_2:zero_point_4);  
 half_cycle_interval_2(zero_point_3:zero_point_1)=Signal_Filter(zero_point_3:zero_point_1);
 
 fp=zeros(length(Signal_Filter),1); 
 if max(abs(half_cycle_interval_1))>=max(abs(half_cycle_interval_2))
  fp(1:zero_point_1-1,1)=0;  
  fp(zero_point_1:zero_point_4)=Signal_Filter(zero_point_1:zero_point_4); 
  fp(zero_point_4+1:length(Signal_Filter),1)=0;
  Tp=zero_point_4*dt-zero_point_1*dt; 
 else
  fp(1:zero_point_3-1,1)=0;  
  fp(zero_point_3:zero_point_2)=Signal_Filter(zero_point_3:zero_point_2); 
  fp(zero_point_2+1:length(Signal_Filter),1)=0;
  Tp=zero_point_2*dt-zero_point_3*dt; 
 end   

%%%code to indicate the number of peak-points in the pulse signal %%%
 [~,in1]=findpeaks(abs(fp));
 if length(in1)==2
  code=1;
 else 
  code=0;
 end
 
%%% If the filtered signal is 0 %%% 
else 
 fp=0;
 Tp=0;
 fp_max=0;   
 code=0;
end
end