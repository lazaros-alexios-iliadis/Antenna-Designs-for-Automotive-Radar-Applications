% Acknowledgement:
% This function is provided by Dr. P. N. Suganthan, and we have done minor
% revisions.

function [f] = BenchmarkFunc(x, problem, fid)

persistent fhd f_bias %#ok<*NUSED>

% benchmark_func.m is the main function for 25 test functions , all
% minimize
% problems
% e.g. f = benchmark_func(x , func_num)
% x is the variable , f is the function value
% func_num is the function num ,

%
%J. J. Liang & P. N. Suganthan 2005.Feb 18

if problem == 1, fhd = str2func('Antenna'); 
elseif problem == 99, fhd = str2func('Test_NN_func'); 
end

f = feval(fhd, x, fid);

function [fit] = Antenna(x, fid)
fit = 0;
Psi = 10000;
limitdB = -15;

[index] = mmWaveAntennaFunc(x);
[S11] = HFSSOutputsFunc(index);
S11_max = max(S11);
if S11_max > limitdB %dB
    fit = fit + Psi * abs(abs(limitdB) - abs(S11_max));
else
    fit = S11_max;
end

%if VSWRmaxval > 2 %impedance matching
%    fit = fit+Psi*abs(abs(VSWRmaxval-2));
%end

%if fit < 0
%    fit = -MinGain;
%end
%  if S11maxval>-20 %dB
%      fit=fit+Xi*abs(20-abs(S11maxval));
%
%  end
%
%  if VSWRmaxval>2 %impedance matching
%      fit=fit+Xi*abs(abs(VSWRmaxval-2));
%  end
%fit=fit+S11maxval;

% fprintf(fid,'S11=%fdB VSWR=%f AR=%f MinGain=%f ',S11maxval,VSWRmaxval,AR,MinGain);
% fprintf('S11=%fdB VSWR=%f AR=%f MinGain=%f ',S11maxval,VSWRmaxval,AR,MinGain);

fprintf(fid, '%4.2f ', S11);
fprintf('%4.2f ', S11);

for k = 1 : length(x)
    fprintf(fid, '%4.2f ', x(k));
    fprintf('%4.2f ', x(k));
end
fprintf(fid, '\n');
fprintf('\n');

% 99.Test Neural Network size
function [fit] = Test_NN_func(x)
[ps, D] = size(x); %#ok<*ASGLU>
%x
fit = 0;
for i = 1 : D
    fit = fit+x(i)^2;
end