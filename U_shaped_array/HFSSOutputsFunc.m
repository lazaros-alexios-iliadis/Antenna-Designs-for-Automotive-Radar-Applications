function [S11] = HFSSOutputsFunc(index)
% function [S11maxval,VSWRmaxval,MinGain]=ReadHFSSOutput
S11  = HFSSParametersFunc('S11', index, 's');
% VSWRmaxval  = ReadHFSS_ParamOutFile('VSWR',2,'v' );
% [Gain,RealizedGain] = ReadHFSSAntennaParamsOutFile( 'AntParams' );
% MinGain=Gain;
% [Gain,RealizedGain] = ReadHFSSAntennaParamsOutFile( 'AntParams2' );
% if Gain<MinGain
%     MinGain=Gain;
% end
end