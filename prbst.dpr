program prbst;

uses
  Vcl.Forms,
  uMain in 'bst\uMain.pas' {fmMain},
  uBaseForm in 'Base\uBaseForm.pas' {fmBaseForm},
  uRes in 'Base\uRes.pas' {Res},
  uLogin in 'Base\uLogin.pas' {fmLogin},
  uBaseGrid in 'Base\uBaseGrid.pas' {fmBaseGrid},
  uOwners in 'bst\uOwners.pas' {fmOwners},
  uObjects in 'bst\uObjects.pas' {fmObjects},
  uUsers in 'org\uUsers.pas' {fmUsers},
  uArrays in 'Utils\uArrays.pas',
  uConversion in 'Utils\uConversion.pas',
  uSprBase in 'spr\uSprBase.pas' {fmSprBase},
  uScaleType in 'spr\uScaleType.pas' {fmSprScaleType},
  uSprStatus in 'spr\uSprStatus.pas' {fmSprStatus},
  uObjectsNew in 'bst\uObjectsNew.pas' {fmObjectsNew},
  uScales in 'bst\uScales.pas' {fmScales},
  uOwnersNew in 'bst\uOwnersNew.pas' {fmOwnersNew};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TRes, Res);
  Application.CreateForm(TfmLogin, fmLogin);
  Application.Run;
end.
