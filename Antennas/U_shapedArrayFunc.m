function [index] = mmWaveAntennaFunc(u)
% Function that implements an 1x5 antenna array for 79 GHz

% Add paths to the required m-files.
hfssSetExePath;
tmpPrjFile = [pwd, '\tempAntenna.aedt'];
tmpScriptFile = [pwd, '\tempAntenna.vbs'];

% Antenna tuning parameters
c = 3e8;
freq = 79e9;
index = length(freq);
freqlist = freq./1e9;  % convert to GHz
lambda = c./freq(1)*1000;  % in mm
decimalpoints = 3;
solution_name = 'mmWaveAntenna';

% Substrate
% Rogers 3003
er = 3;
thickness = 0.51;  % mm
tanDelta = 0.001;
total_thickness = 2 * thickness;

% Antenna design parameters

% Feed
feed_length = RoundNew(u(1), decimalpoints);
feed_width = RoundNew(u(2), decimalpoints);

% Patch parameters
% Planar U-shaped antennas
arm_width = RoundNew(u(3), decimalpoints);
arm_length = RoundNew(u(4), decimalpoints);

% arm
U1B_width = RoundNew(u(5), decimalpoints);
U1B_length = arm_width;

U1C_width = U1B_width;
U1C_length = arm_width;

% Aperture parameters
slot_length = RoundNew(u(6), decimalpoints);
slot_width = RoundNew(u(7), decimalpoints);

% Array parameters
d1 = RoundNew(u(8), decimalpoints);


% Substrate dimensions
substrate_length = RoundNew(1.1 * (arm_length + arm_width), decimalpoints);
substrate_width = RoundNew(1.1 * (arm_width + U1B_width+4*d1), decimalpoints);

% Ground plane
ground_length = substrate_length;
ground_width = substrate_width;

% Constraints
if (feed_width > substrate_width)
    feed_width = substrate_width;
end
if (U1B_width + arm_width >= substrate_width/2)
    U1B_width = U1B_width/2;
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

% Antenna design

% Arm 
hfssRectangle(fid, 'mmWaveAntenna', 'Z', [-arm_length/2, -arm_width/2, total_thickness], arm_length, arm_width, 'mm');
hfssSetColor(fid, 'mmWaveAntenna', [128 , 0, 0]);
hfssSetTransparency(fid, {'mmWaveAntenna'}, 0);

hfssRectangle(fid, 'U1B', 'Z', [-arm_length/2,  arm_width/2, total_thickness], U1B_length, U1B_width, 'mm');
hfssSetColor(fid, 'U1B', [128 , 0, 0]);
hfssSetTransparency(fid, {'U1B'}, 0);
hfssUnite(fid, {'mmWaveAntenna', 'U1B'});

hfssRectangle(fid, 'U1C', 'Z', [arm_length/2-arm_width,  arm_width/2, total_thickness], U1C_length, U1C_width, 'mm');
hfssSetColor(fid, 'U1C', [128 , 0, 0]);
hfssSetTransparency(fid, {'U1C'}, 0);
hfssUnite(fid, {'mmWaveAntenna', 'U1C'});

% Feed design
hfssRectangle(fid, 'Feed', 'Z', [-feed_length/2, substrate_width/2 - feed_width, 0],...
    feed_length, feed_width, 'mm');
hfssSetColor(fid, 'Feed', [128, 128, 0]);
hfssSetTransparency(fid, {'Feed'}, 0);

% Aperture design
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

% Array
hfssDuplicateAlongLine(fid, {'mmWaveAntenna'}, [0,-(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,-(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'mmWaveAntenna'}, [0,-(2*d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,-(2*d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'mmWaveAntenna'}, [0,(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'slot'}, [0,(d1), 0], 2, 'mm');
hfssDuplicateAlongLine(fid, {'mmWaveAntenna'}, [0,(2*d1), 0], 2, 'mm');
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
hfssAssignFiniteCondNew(fid, 'finiteConductivity2', 'mmWaveAntenna', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity3', 'mmWaveAntenna_1', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity4', 'mmWaveAntenna_2', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity5', 'mmWaveAntenna_3', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity6', 'mmWaveAntenna_4', 'copper', 0);
hfssAssignFiniteCondNew(fid, 'finiteConductivity7', 'Feed', 'copper', 0);

% Lumped port
hfssRectangle(fid, 'Port', 'Y', [-feed_length/2, substrate_width/2, 0],...
    thickness, feed_length, 'mm');
hfssAssignLumpedPort(fid, 'port', 'port', [-feed_length/2, substrate_width/2, 0],...
     [-feed_length/2, substrate_width/2, thickness], 'mm', 50, 0);


% Frequency solution setup
setupstr = ['Setup', int2str(freqlist(1) * 1000), 'MHz'];
hfssInsertSolution(fid, setupstr, freqlist(1), 0.02, 20, 1, 1, 30);
hfssDiscreteSweep(fid, 'Dicrete', setupstr, freqlist);

% Create far-field radiation 
hfssInsertFarFieldSphereSetup(fid, 'radiation', [0, 360, 1], [0, 360, 1]);

% Solve frequency solution 
hfssSolveSetup(fid, setupstr);

% Create solution reports
hfssCreateReport(fid, 'S11', 1, 1, setupstr, 'Dicrete', [], 'Sweep', {'Freq'}, {'Freq', 'dB(S(port, port))'});                 
hfssExportToFile(fid, 'S11', 'S11', 'txt'); 

% Save project
hfssSaveProject(fid, tmpPrjFile, true);

fclose(fid);

% Open HFSS to execute the script
hfssExecuteScript(hfssExePath, tmpScriptFile, true, true);

end

