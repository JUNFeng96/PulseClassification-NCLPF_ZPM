%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------------------------------
% Input : Full path of the file to be parsed
% 
% Outputs: 
%   -Acceleration time history (Acc)
%   -Time step used for recording (record_dt)        
%   -Number of recorded points (NPTS)
%   -error code to indicate if the file was not present (errCode)
%   --errCode = 0 if successful, -1 if File not found
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Acc,record_dt,NPTS,errCode]=parseAT2(filename)
file_in=fopen(filename, 'r');
if(file_in==-1) 
    Acc=-1;
    record_dt=-1;
    errCode=-1;
    NPTS=-1;
else
    for j=1:4                             
        ans=fgetl(file_in);             
    end
    temp=regexp(ans,'\d*\.?\d*','match'); 
    NPTS=str2double(temp(1));
    record_dt=str2double(temp(2)); 
    Acc=fscanf(file_in, '%f');
    fclose(file_in);
    errCode=0;
end

end
