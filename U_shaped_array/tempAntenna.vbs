Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule

Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.NewProject
Set oProject = oDesktop.GetActiveProject

oProject.InsertDesign "HFSS", "mmWaveAntenna", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("mmWaveAntenna")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.SetModelUnits Array("NAME:Units Parameter", "Units:=", "mm", "Rescale:=",  false)

oProject.AddMaterial _
Array("NAME:Rogers3003", _
"permittivity:=", "3.000000", _
"conductivity:=", "0.000000", _
"dielectric_loss_tangent:=", "0.001000")

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-4.285000mm", _
"YStart:=", "-1.190000mm", _
"ZStart:=", "1.020000mm", _
"Width:=", "8.570000mm", _
"Height:=", "2.380000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "mmWaveAntenna", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "mmWaveAntenna"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 128, "G:=", 0, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","mmWaveAntenna"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.000000) _
			) _
		) _
	)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-4.285000mm", _
"YStart:=", "1.190000mm", _
"ZStart:=", "1.020000mm", _
"Width:=", "2.380000mm", _
"Height:=", "4.480000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "U1B", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "U1B"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 128, "G:=", 0, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","U1B"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.000000) _
			) _
		) _
	)

oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna,U1B"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "1.905000mm", _
"YStart:=", "1.190000mm", _
"ZStart:=", "1.020000mm", _
"Width:=", "2.380000mm", _
"Height:=", "4.480000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "U1C", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "U1C"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 128, "G:=", 0, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","U1C"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.000000) _
			) _
		) _
	)

oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna,U1C"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-1.205000mm", _
"YStart:=", "-25.641000mm", _
"ZStart:=", "0.000000mm", _
"Width:=", "2.410000mm", _
"Height:=", "51.282000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Feed", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "Feed"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 128, "G:=", 128, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","Feed"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.000000) _
			) _
		) _
	)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-2.755000mm", _
"YStart:=", "-0.475000mm", _
"ZStart:=", "0.510000mm", _
"Width:=", "5.510000mm", _
"Height:=", "0.950000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "slot", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-6.022500mm", _
"YPosition:=", "-25.641000mm", _
"ZPosition:=", "0.000000mm", _
"XSize:=", "12.045000mm", _
"YSize:=", "51.282000mm", _
"ZSize:=", "0.510000mm"), _
Array("NAME:Attributes", _
"Name:=", "FeedSubstrate", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "FeedSubstrate"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "Rogers3003", _
		"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "FeedSubstrate"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 0, "G:=", 128, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","FeedSubstrate"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.200000) _
			) _
		) _
	)

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-6.022500mm", _
"YPosition:=", "-25.641000mm", _
"ZPosition:=", "0.510000mm", _
"XSize:=", "12.045000mm", _
"YSize:=", "51.282000mm", _
"ZSize:=", "0.510000mm"), _
Array("NAME:Attributes", _
"Name:=", "PatchSubstrate", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "PatchSubstrate"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "Rogers3003", _
		"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "PatchSubstrate"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 0, "G:=", 128, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","PatchSubstrate"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.400000) _
			) _
		) _
	)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-6.022500mm", _
"YStart:=", "-25.641000mm", _
"ZStart:=", "0.510000mm", _
"Width:=", "12.045000mm", _
"Height:=", "51.282000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Ground", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","Ground"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.300000) _
			) _
		) _
	)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "-9.860000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "10.150000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "-18.950000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "mmWaveAntenna"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "18.950000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "slot"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "-9.860000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "slot"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "10.150000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "slot"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "-18.950000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "slot"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "18.950000mm", _
"ZComponent:=", "0.000000mm", _
"NumClones:=", 2), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"Ground", _
"Tool Parts:=", _
"slot"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"Ground", _
"Tool Parts:=", _
"slot_1"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"Ground", _
"Tool Parts:=", _
"slot_2"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"Ground", _
"Tool Parts:=", _
"slot_3"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"Ground", _
"Tool Parts:=", _
"slot_4"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-9.819968mm", _
"YPosition:=", "-29.438468mm", _
"ZPosition:=", "-3.797468mm", _
"XSize:=", "19.639937mm", _
"YSize:=", "58.876937mm", _
"ZSize:=", "12.412405mm"), _
Array("NAME:Attributes", _
"Name:=", "airbox", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","airbox"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.900000) _
			) _
		) _
	)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation _
Array("NAME:radiation", _
"Objects:=", Array("airbox"), _
"UseAdaptiveIE:=", false)

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "airbox"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "air", _
		"SolveInside:=", true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity1", "Objects:=", Array( _
  "Ground"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity2", "Objects:=", Array( _
  "mmWaveAntenna"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity3", "Objects:=", Array( _
  "mmWaveAntenna_1"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity4", "Objects:=", Array( _
  "mmWaveAntenna_2"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity5", "Objects:=", Array( _
  "mmWaveAntenna_3"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity6", "Objects:=", Array( _
  "mmWaveAntenna_4"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFiniteCond Array("NAME:finiteConductivity7", "Objects:=", Array( _
  "Feed"), "UseMaterial:=", true, "Material:=", "copper", "Roughness:=",  _
  "0um", "UseThickness:=", false, "InfGroundPlane:=",  _
  false)


oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-1.205000mm", _
"YStart:=", "25.641000mm", _
"ZStart:=", "0.000000mm", _
"Width:=", "0.510000mm", _
"Height:=", "2.410000mm", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "Port", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignLumpedPort _
Array("NAME:port", _
      Array("NAME:Modes", _
             Array("NAME:Mode1", _
                   "ModeNum:=", 1, _
                   "UseIntLine:=", true, _
                   Array("NAME:IntLine", _
                          "Start:=", Array("-1.205000mm", "25.641000mm", "0.000000mm"), _
                          "End:=",   Array("-1.205000mm", "25.641000mm", "0.510000mm") _
                         ), _
                   "CharImp:=", "Zpi" _
                   ) _
            ), _
      "Resistance:=", "50.000000Ohm", _
      "Reactance:=", "0.000000Ohm", _
      "Objects:=", Array("port") _
      )

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup79000MHz", _
"Frequency:=", "79.000000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 20, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 30, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertDrivenSweep _
"Setup79000MHz", _
Array("NAME:Dicrete", _
"Type:=", "Discrete", _
"SetupType:=", "SinglePoints", _
"FrequencyList:=", Array("79GHz"), _
"SaveFieldsList:=", Array(true))

Set oModule = oDesign.GetModule("RadField")
oModule.InsertFarFieldSphereSetup _
Array("NAME:radiation", _
"UseCustomRadiationSurface:=", false, _
"ThetaStart:=", "0.000000deg", _
"ThetaStop:=", "360.000000deg", _
"ThetaStep:=", "1.000000deg", _
"PhiStart:=", "0.000000deg", _
"PhiStop:=", "360.000000deg", _
"PhiStep:=", "1.000000deg", _
"UseLocalCS:=", false)

oDesign.Solve _
    Array("Setup79000MHz") 

Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "S11", _
"Modal S Parameter", _
"Rectangular Plot", _
"Setup79000MHz : Dicrete", _
Array("Domain:=", "Sweep"), _
Array("Freq:=", Array("All")), _
Array("X Component:=", "Freq", _
"Y Component:=", Array("dB(S(port, port))")), _
Array()

Set oModule = oDesign.GetModule("ReportSetup")
oModule.ExportToFile "S11", "S11.txt"

oProject.SaveAs _
    "D:\Research\simulations\Lazaros\2024-EuCAP\Automotive_radar\U_shaped\test\trial7\vector1\tempAntenna.aedt", _
    true
