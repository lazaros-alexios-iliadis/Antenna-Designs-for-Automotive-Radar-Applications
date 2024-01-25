function [S11] = HFSSParametersFunc(outfile, nof, FileType)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%nof =number of frequencies
filename = strcat(outfile, '.txt');
if exist(filename, 'file')
    fid = fopen(filename, 'r');
    tline = fgets(fid);

    switch (FileType)
        case 's', start = 22; %S parameters file
        case 'v', start = 21; % VSWR file
        case 'a', start = 26; % AR file
        otherwise, error('Export File Type Unknown!');
    end
    
    i = 1;
    for j = 1 : 7
        %read 7 lines
        tline = fgets(fid);
    end
    
    S11_value = SubstrFunc(tline, start, 18);
    S11(i) = str2double(S11_value);
    S11_max = S11(i);
    
    i = i + 1;
    tline = fgets(fid);
    
    while ischar(tline)
        S11_value = SubstrFunc(tline, start, 18);
        S11(i) = str2double(S11_value);
        if (S11(i) > S11_max)
            S11_max = S11(i);
        end
       
        i = i + 1;
        if (i > nof)
            break;
        end
        
        tline = fgets(fid);
    end
    fclose(fid);
else
    S11_max = 1000; %#ok<NASGU>
end

end
