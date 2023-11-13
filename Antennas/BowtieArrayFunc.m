function [index] =  AntennaFunc(u)

% Add paths to the required m-files.
hfssSetExePath;
tmpPrjFile = [pwd, '\tempAntenna.aedt'];
tmpScriptFile = [pwd, '\tempAntenna.vbs'];

% Antenna tuning papameters
c = 3e8;
freq = 79e9;
index = length(freq);
freqlist = freq./1e9; % convert to GHz
lambda = c./freq(1)*1000;
decimalpoints = 3;
solution_name = 'bowtie';

% Antenna design parameters

% Feed
feed_length = RoundNew(u(1), decimalpoints);
feed_width = RoundNew(u(2), decimalpoints);

% Substrate
% Rogers 3003
er = 3;
thickness = 0.51;  % mm
tanDelta = 0.001;
total_thickness = 2 * thickness;

% Aperture parameters
% Orthogonal-shaped
slot_length = RoundNew(u(3), decimalpoints);
slot_width = RoundNew(u(4), decimalpoints);

% Bowtie parameters
bow_tie_length = RoundNew(u(5), decimalpoints);
bow_tie_angle = u(6);
bow_tie_offset = 0;
gap = RoundNew(u(7), decimalpoints); %in mm
d1 = RoundNew(u(8), decimalpoints);
%d2 = RoundNew(u(9), decimalpoints);
% Substrate parameters
substrate_length = RoundNew(1.1 * bow_tie_length + gap, decimalpoints);
substrate_width = RoundNew(1.2 * ( bow_tie_length * tan(bow_tie_angle)+4*d1), decimalpoints);
% Ground plane
ground_length = substrate_length;
ground_width = substrate_width;

% Constraints
if (feed_width > substrate_width)
    feed_width = substrate_width;
end

if (slot_length >= substrate_length)
    slot_length = slot_length/2;
end

% Open temp file
fid = fopen(tmpScriptFile, 'wt');

% Create a new HFSS project
hfssNewProject(fid);
hfssInsertDesign(fid, solution_name);

% Set model units to mm
hfssSetUnit(fid, 'mm');

name = 'Rogers3003';
hfssAddMaterial(fid, name, er, 0, tanDelta);

% Bow-tie antenna design
    % bow_tie_arm_01a
hfssRectangle(fid, 'bowtie_antenna', 'Z', [-bow_tie_length/2, 0, total_thickness], bow_tie_length, bow_tie_length, 'mm');
hfssSetColor(fid, 'bowtie_antenna', [128 , 0, 0]);
hfssSetTransparency(fid, {'bowtie_antenna'}, 0);
hfssRectangle(fid, 'rectangle1', 'Z', [-bow_tie_length/2, 0, total_thickness], 2*bow_tie_length, 2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle1'}, 'Z', bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_antenna'}, {'rectangle1'});
%hfssMove(fid, {'bowtie_antenna'}, [bow_tie_offset+gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle2', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    gap/2-bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_antenna'}, {'rectangle2'});
    % bow_tie_arm_01b
hfssRectangle(fid, 'bowtie_arm_01b', 'Z', [-bow_tie_length/2, 0, total_thickness], bow_tie_length, -bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle3', 'Z', [-bow_tie_length/2, 0, total_thickness], 2*bow_tie_length, -2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle3'}, 'Z', -bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_01b'}, {'rectangle3'});
%hfssMove(fid, {'bowtie_arm_01b'}, [bow_tie_offset+gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle4', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    gap/2-bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_01b'}, {'rectangle4'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_01b'});
    % bow_tie_arm_02a
hfssRectangle(fid, 'bowtie_arm_02a', 'Z', [bow_tie_length/2, 0, total_thickness], -bow_tie_length, bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle5', 'Z', [bow_tie_length/2, 0, total_thickness], -2*bow_tie_length, 2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle5'}, 'Z', -bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_02a'}, {'rectangle5'});
%hfssMove(fid, {'bowtie_arm_02a'}, [-bow_tie_offset-gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle6', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    -gap/2+bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_02a'}, {'rectangle6'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_02a'});
    % bow_tie_arm_02b
hfssRectangle(fid, 'bowtie_arm_02b', 'Z', [bow_tie_length/2, 0, total_thickness], -bow_tie_length, -bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle7', 'Z', [bow_tie_length/2, 0, total_thickness], -2*bow_tie_length, -2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle7'}, 'Z', bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_02b'}, {'rectangle7'});
%hfssMove(fid, {'bowtie_arm_02b'}, [-bow_tie_offset-gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle8', 'Z', [-bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    -gap/2+bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_02b'}, {'rectangle8'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_02b'});


% Feed design
hfssRectangle(fid, 'Feed', 'Z', [-feed_length/2, -substrate_width/2, 0],...
    feed_length, feed_width, 'mm');
hfssSetColor(fid, 'Feed', [128, 128, 0]);
hfssSetTransparency(fid, {'Feed'}, 0);

hfssRectangle(fid, 'slot', 'Z', [-slot_length/2, -slot_width/2, thickness],...
    slot_length, slot_width, 'mm');



% Substrates
hfssBox(fid, 'FeedSubstrate', [-substrate_length/2, -substrate_width/2, 0],...
    [substrate_length, substrate_width, thickness], 'mm');
hfssAssignMaterial(fid, 'FeedSubstrate', 'Rogers3003');
hfssSetColor(fid, 'FeedSubstrate', [0, 128, 0]);
hfssSetTransparency(fid, {'FeedSubstrate'}, 0.2);

hfssBox(fid, 'PatchSubstrate', [-substrate_length/2, -substrate_width/2, thickness],...
    [substrate_length, substrate_width, thickness], 'mm');
hfssAssignMaterial(fid, 'PatchSubstrate', 'Rogers3003');
hfssSetColor(fid, 'PatchSubstrate', [0, 128, 0]);
hfssSetTransparency(fid, {'PatchSubstrate'}, 0.4);

% Ground plane
hfssRectangle(fid, 'Ground', 'Z', [-substrate_length/2, -substrate_width/2, thickness],...
    ground_length, ground_width, 'mm');
hfssSetTransparency(fid, {'Ground'}, 0.3);

hfssDuplicateAlongLine(fid, {'bowtie_antenna'}, [0,-(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,-(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'bowtie_antenna'}, [0,-(2*d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,-(2*d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'bowtie_antenna'}, [0,(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'bowtie_antenna'}, [0,(2*d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,(2*d1), 0], 2, 'mm');
hfssSubtract(fid, {'Ground'}, {'slot'});
hfssSubtract(fid, {'Ground'}, {'slot_1'});
hfssSubtract(fid, {'Ground'}, {'slot_2'});
hfssSubtract(fid, {'Ground'}, {'slot_3'});
hfssSubtract(fid, {'Ground'}, {'slot_4'});


% Air Box design
hfssBox(fid, 'airbox', [-substrate_length/2-lambda, -substrate_width/2-lambda, -lambda], ...
    [substrate_length+2*lambda, substrate_width+2*lambda, total_thickness+3*lambda], 'mm');
hfssSetTransparency(fid, {'airbox'}, 0.9);
hfssAssignRadiation(fid, 'radiation', 'airbox');

hfssAssignMaterial(fid, 'airbox', 'air');

hfssAssignFiniteCondNew(fid, 'finiteConductivity1', 'Ground', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity2', 'bowtie_antenna', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity3', 'bowtie_antenna_1', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity4', 'bowtie_antenna_2', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity5', 'bowtie_antenna_3', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity6', 'bowtie_antenna_4', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity7', 'Feed', 'copper', 0);

% Lumped port
hfssRectangle(fid, 'Port', 'Y',  [-feed_length/2, -substrate_width/2, 0],...
    thickness, feed_length, 'mm');
hfssAssignLumpedPort(fid, 'port', 'port',  [-feed_length/2, -substrate_width/2, 0],...
     [-feed_length/2, -substrate_width/2, thickness], 'mm', 50, 0);

% Frequency solution setup
setupstr = ['Setup', int2str(freqlist(1) * 1000), 'MHz'];
hfssInsertSolution(fid, setupstr, freqlist(1), 0.02, 20, 1, 1, 30);
hfssDiscreteSweep(fid, 'Discrete', setupstr, freqlist);

% Create far-field radiation 
hfssInsertFarFieldSphereSetup(fid, 'radiation', [0, 360, 1], [0, 360, 1]);
%hfssInsertFarFieldSphereSetup(fid, 'Radiation',[0, 180, 10],[-90, 90, 2]);

% Solve frequency solution 
hfssSolveSetup(fid, setupstr);

% Create solution reports
hfssCreateReport(fid, 'S11', 1, 1, setupstr, 'Discrete', [], 'Sweep', {'Freq'}, {'Freq', 'dB(S(port, port))'});                 
hfssExportToFile(fid, 'S11', 'S11', 'txt'); 

% Save project
hfssSaveProject(fid, tmpPrjFile, true);

fclose(fid);

% Open HFSS to execute the script
hfssExecuteScript(hfssExePath, tmpScriptFile, true, true);
end