 function [u, strProb] = DecisionVariablesFunc(problem, D)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

switch problem
    
    case 1
        
        % lu: define the upper and lower bounds of the variables
        u = [-1.0 * ones(1, D); 1.0 * ones(1, D)];
        
        u(1, 1) = 3;  % lower feed length (in mm)
        u(2, 1) = 5;  % upper feed length (in mm)
        
        u(1, 2) = 0.5;  % lower feed width (in mm)
        u(2, 2) = 1;  % upper feed width (in mm)
        
        u(1, 3) = 3.8;  % lower horizontal slot length (in mm)
        u(2, 3) = 5;  % upper horizontal slot length (in mm)
        
        u(1, 4) = 0.5;  % lower horizontal slot width (in mm)
        u(2, 4) = 1.1;  % upper horizontal slot width (in mm)
        
        u(1, 5) = 1;  % lower bow_tie_length (in mm)
        u(2, 5) = 2.2;  % upper bow_tie_length (in mm)
        
        u(1, 6) = 0.3;  % lower bow_tie_angle (in radians)
        u(2, 6) = 0.4;  % upper bow_tie_angle (in radians)
        
        u(1, 7) = 0.05;  % lower stripline gap (in mm)
        u(2, 7) = 0.2;  % upper stripline gap (in mm)
        
        strProb='bowtie';
        
    case 2
        
        % lu: define the upper and lower bounds of the variables
        u = [-100 * ones(1, D); 100 * ones(1, D)];
        u(1,1)=5;
        u(2,1)=30;
        u(1,2)=5;
        u(2,2)=30;
        strProb='NNsize_H2';
        
    case 99
        
        % lu: define the upper and lower bounds of the variables
        u = [-100 * ones(1, D); 100 * ones(1, D)];
        strProb='sphere_func';
end

end