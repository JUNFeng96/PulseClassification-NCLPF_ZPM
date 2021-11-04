%%% Classification standard of pulse-like ground motion [JUN Feng,2020]%%%
%%%%%%%%%%%%%%%%
%
% Inputs : 
% -Original ground motion (velocity)
% -Pulse signal (Vp)
% -The index of the most effective pulse (Er_index)
% -The relative energy(Er)
% -Peak value of pulse signal (Vp_max)
%
% Outputs
% -Pulse_type (pulse_type)
% -Final extracted pulse signal (FP)
% -The relative energy and the index of the most effective pulse(Er_max,Er_index)
%%%%%%%%%%%%%%%%%

function [pulse_type,FP,Er_max,Er_index]=classification_standard(velocity,Vp,Vp_max,Er)
 [Er_max,Er_index]=max(Er);
 pulse_type=0;
 if max(abs(velocity))>30 
 if Er(2)+Er(1)>0.55 && min(Er)>0.75*max(Er) 
   FP=Vp{1}'+Vp{2}';
   pulse_type=2;
 elseif Er(2)+Er(1)>0.55 && Er(2)>0.5*Er(1) && Vp_max(2)>0.75*Vp_max(1)
   FP=Vp{1}'+Vp{2}';
   pulse_type=2;
 elseif Er_max>0.32 && pulse_type==0
    pulse_type=1;
    FP=Vp{Er_index}';
 elseif Er_max<=0.32 && pulse_type==0
    pulse_type=0;
    FP=0;
 end
 
 else
    pulse_type=0;
    FP=0;
 end
end
