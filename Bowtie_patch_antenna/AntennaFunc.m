function [index] =  AntennaFunc(u)

% Add paths to the required m-files.
hfssSetExePath;
tmpPrjFile = [pwd, '\tempAntenna.aedt'];
tmpScriptFile = [pwd, '\tempAntenna.vbs'];

% Antenna tuning papameters
c = 3e8;
freq = 79e9;
index = length(freq);
freqlist = freq./1e9; %convert to GHz
lambda = c./freq(1)*1000;
decimalpoints = 3;
solution_name = 'bowtie';

% Antenna design parameters

% Feed
feed_length = RoundNew(u(1), decimalpoints);
feed_width = RoundNew(u(2), decimalpoints);

% Feed substrate
% Rogers 5880 RT/duroid
er_rogers = 2.2;
thickness_rogers = 0.508;  % mm
tanDelta_rogers = 0.0009;

% Patch substrate
% Taconic
er_taconic = 2.2;
thickness_taconic = 0.76;
tanDelta_taconic = 0.0009;

% Aperture parameters
% L-shaped
slotHorizontal_length = RoundNew(u(3), decimalpoints);
slotHorizontal_width = RoundNew(u(4), decimalpoints);

% Bowtie parameters
bow_tie_length = RoundNew(u(5), decimalpoints);
bow_tie_angle = u(6);
bow_tie_offset = 0;
gap = RoundNew(u(7), decimalpoints); %in mm

% Substrate parameters
substrate_length = RoundNew(2 * 2 * bow_tie_length + gap, decimalpoints);
substrate_width = RoundNew(2.85 * 2 * bow_tie_length * tan(bow_tie_angle), decimalpoints);
total_thickness = thickness_rogers + thickness_taconic;

% Ground plane
ground_length = substrate_length;
ground_width = substrate_width;

% Constraints
if (feed_length > substrate_width)
    feed_length = substrate_width;
end
if (feed_width > substrate_length)
    feed_width = substrate_length;
end
if (slotHorizontal_length >= substrate_length)
    slotHorizontal_length = slotHorizontal_length/2;
end

% Open temp file
fid = fopen(tmpScriptFile, 'wt');

% Create a new HFSS project
hfssNewProject(fid);
hfssInsertDesign(fid, solution_name);

% Set model units to mm
hfssSetUnit(fid, 'mm');

name1 = 'Rogers5880';
hfssAddMaterial(fid, name1, er_rogers, 0, tanDelta_rogers);

name2 = 'Taconic';
hfssAddMaterial(fid, name2, er_taconic, 0, tanDelta_taconic);

% Bow-tie antenna design
    % bow_tie_arm_01a
hfssRectangle(fid, 'bowtie_antenna', 'Z', [0, 0, total_thickness], bow_tie_length, bow_tie_length, 'mm');
hfssSetColor(fid, 'bowtie_antenna', [128 , 0, 0]);
hfssSetTransparency(fid, {'bowtie_antenna'}, 0);
hfssRectangle(fid, 'rectangle1', 'Z', [0, 0, total_thickness], 2*bow_tie_length, 2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle1'}, 'Z', bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_antenna'}, {'rectangle1'});
hfssMove(fid, {'bowtie_antenna'}, [bow_tie_offset+gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle2', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    gap/2-bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_antenna'}, {'rectangle2'});
    % bow_tie_arm_01b
hfssRectangle(fid, 'bowtie_arm_01b', 'Z', [0, 0, total_thickness], bow_tie_length, -bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle3', 'Z', [0, 0, total_thickness], 2*bow_tie_length, -2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle3'}, 'Z', -bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_01b'}, {'rectangle3'});
hfssMove(fid, {'bowtie_arm_01b'}, [bow_tie_offset+gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle4', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    gap/2-bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_01b'}, {'rectangle4'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_01b'});
    % bow_tie_arm_02a
hfssRectangle(fid, 'bowtie_arm_02a', 'Z', [0, 0, total_thickness], -bow_tie_length, bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle5', 'Z', [0, 0, total_thickness], -2*bow_tie_length, 2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle5'}, 'Z', -bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_02a'}, {'rectangle5'});
hfssMove(fid, {'bowtie_arm_02a'}, [-bow_tie_offset-gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle6', 'Z', [bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    -gap/2+bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_02a'}, {'rectangle6'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_02a'});
    % bow_tie_arm_02b
hfssRectangle(fid, 'bowtie_arm_02b', 'Z', [0, 0, total_thickness], -bow_tie_length, -bow_tie_length, 'mm');
hfssRectangle(fid, 'rectangle7', 'Z', [0, 0, total_thickness], -2*bow_tie_length, -2*bow_tie_length, 'mm');
hfssRotate(fid, {'rectangle7'}, 'Z', bow_tie_angle*180/pi);
hfssSubtract(fid, {'bowtie_arm_02b'}, {'rectangle7'});
hfssMove(fid, {'bowtie_arm_02b'}, [-bow_tie_offset-gap/2, 0, 0], 'mm');
hfssRectangle(fid, 'rectangle8', 'Z', [-bow_tie_offset, -bow_tie_length/2, total_thickness], ...
    -gap/2+bow_tie_offset, bow_tie_length, 'mm');
hfssSubtract(fid, {'bowtie_arm_02b'}, {'rectangle8'});
hfssUnite(fid, {'bowtie_antenna', 'bowtie_arm_02b'});


% Feed design
hfssRectangle(fid, 'Feed', 'Z', [-gap, -substrate_width/2, 0],...
    feed_width, feed_length, 'mm');
hfssSetColor(fid, 'Feed', [128, 128, 0]);
hfssSetTransparency(fid, {'Feed'}, 0);

% Aperture design
hfssRectangle(fid, 'SlotHorizontal', 'Z', [0, 0, thickness_rogers],...
    slotHorizontal_length, slotHorizontal_width, 'mm');
hfssMove(fid, {'SlotHorizontal'}, [-slotHorizontal_length/3-2*gap, -slotHorizontal_width/2, 0], 'mm');
hfssRectangle(fid, 'SlotVertical', 'Z', [0, 0, thickness_rogers],...
    slotHorizontal_width, slotHorizontal_length/2, 'mm');
hfssMove(fid, {'SlotVertical'}, [-slotHorizontal_length/2, -slotHorizontal_width/2, 0], 'mm');
% % hfssRectangle(fid, 'SlotVertical2', 'Z', [slotHorizontal_length/2, 0, thickness_rogers],...
%     slotVertical_width, slotVertical_length, 'mm');

% Substrates
hfssBox(fid, 'FeedSubstrate', [-substrate_length/2, -substrate_width/2, 0],...
    [substrate_length, substrate_width, thickness_rogers], 'mm');
hfssAssignMaterial(fid, 'FeedSubstrate', 'Rogers5880');
hfssSetColor(fid, 'FeedSubstrate', [0, 128, 0]);
hfssSetTransparency(fid, {'FeedSubstrate'}, 0.2);

hfssBox(fid, 'PatchSubstrate', [-substrate_length/2, -substrate_width/2, thickness_rogers],...
    [substrate_length, substrate_width, thickness_taconic], 'mm');
hfssAssignMaterial(fid, 'PatchSubstrate', 'Taconic');
hfssSetColor(fid, 'PatchSubstrate', [0, 128, 0]);
hfssSetTransparency(fid, {'PatchSubstrate'}, 0.4);

% Ground plane
hfssRectangle(fid, 'Ground', 'Z', [-substrate_length/2, -substrate_width/2, thickness_rogers],...
    ground_length, ground_width, 'mm');
hfssSetTransparency(fid, {'Ground'}, 0.3);

hfssSubtract(fid, {'Ground'}, {'SlotHorizontal'});
hfssSubtract(fid, {'Ground'}, {'SlotVertical'});
% hfssSubtract(fid, {'Ground'}, {'SlotVertical2'});

% Air Box design
hfssBox(fid, 'airbox', [-substrate_length/2-lambda, -substrate_width/2-lambda, -lambda], ...
    [substrate_length+3*lambda, substrate_width+3*lambda, total_thickness+6*lambda], 'mm');
hfssMove(fid, {'airbox'}, [0, -substrate_width/2, -lambda], 'mm');
hfssSetTransparency(fid, {'airbox'}, 0.9);
hfssAssignRadiation(fid, 'radiation', 'airbox');

hfssAssignMaterial(fid, 'airbox', 'air');


hfssAssignFiniteCondNew(fid, 'finiteConductivity1', 'Ground', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity2', 'bowtie_antenna', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity3', 'Feed', 'copper', 0);

% Lumped port
hfssRectangle(fid, 'Port', 'Y', [-gap, -substrate_width/2, 0],...
    thickness_rogers, feed_width, 'mm');
hfssAssignLumpedPort(fid, 'port', 'port', [-gap, -substrate_width/2, 0],...
     [-gap, -substrate_width/2, thickness_rogers], 'mm', 50, 0);

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