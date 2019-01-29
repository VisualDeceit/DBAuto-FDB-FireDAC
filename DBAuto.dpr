program DBAuto;



uses
  Forms,
  unMain in 'unMain.pas' {fmMain},
  unDirection in 'unDirection.pas' {fmDirection},
  unStations in 'unStations.pas' {fmStations},
  unLimits in 'unLimits.pas' {fmLimits},
  unTrains in 'unTrains.pas' {fmTrains},
  unTimeTable in 'unTimeTable.pas' {fmTimeTable},
  unVars in 'unVars.pas',
  unPrep in 'unPrep.pas' {fmPrep},
  unPrepinfo in 'unPrepinfo.pas' {fmPrepinfo},
  unAbout in 'unAbout.pas' {fmAbout},
  unSvet in 'unSvet.pas' {fmSvet},
  unProf in 'unProf.pas' {fmProf},
  unSetup in 'unSetup.pas' {fmSetup},
  unImport in 'unImport.pas' {fmImport},
  unStationExport in 'unStationExport.pas' {fmstationExport},
  unShift in 'unShift.pas' {fmShift},
  unShiftSet in 'unShiftSet.pas' {fmShiftSet},
  unProgressBar in 'unProgressBar.pas' {frmProgress},
  Vcl.Themes,
  Vcl.Styles,
  unUpdate in 'unUpdate.pas' {Form3},
  sevenzip in 'sevenzip.pas',
  unGraph in 'unGraph.pas' {fmGraph},
  unGraphColors in 'unGraphColors.pas' {fmGraphColors},
  unProfImportFormat in 'unProfImportFormat.pas' {fmProfImportFormat};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Редактор базы данных автоведения';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmProfImportFormat, fmProfImportFormat);
  Init;
  Application.CreateForm(TfmGraphColors, fmGraphColors);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfmSetup, fmSetup);
  Application.CreateForm(TfmTrains, fmTrains);
  Application.CreateForm(TfmPrepinfo, fmPrepinfo);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.CreateForm(TfmstationExport, fmstationExport);
  Application.CreateForm(TfmShiftSet, fmShiftSet);
  Application.Run;
end.
